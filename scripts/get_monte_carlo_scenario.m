function [modified_base_load, scenario_details] = get_monte_carlo_scenario( ...
    num_feeder_customers,penetration_level, ...
    chargers_being_used,customer_base_loads_tt)

% tf_list_path = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\load_statistical_analysis\customers_from_disaggregation.xlsx";
% charging_events_path = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\misc\charging_events.mat";

tf_list_path = "C:\Users\shank\Local Desktop\EV-Grid-Integration-Study\data\load_statistical_analysis\customers_from_disaggregation.xlsx";
charging_events_path = "C:\Users\shank\Local Desktop\EV-Grid-Integration-Study\data\misc\charging_events.mat";

closed_delta_customers = ["P33","P53","P115","P182","P198","P202","P207"];

%calculating number of EV customers on feeder based on penetration
num_ev_customers = round(penetration_level*num_feeder_customers);

%creating transformer-customer pair IDs
[viable_ev_customer_IDs,CD_TF_RBs,CD_TFC_RBs] = get_modified_customer_ID(tf_list_path,closed_delta_customers);

% Generate random indices, randperm(n) eturns a row vector containing a random permutation of the integers from 1 to n without repeating elements.
randomIndices = randperm(numel(viable_ev_customer_IDs), num_ev_customers);

% Sample from the string array using the random indices
ev_customer_IDs = viable_ev_customer_IDs(randomIndices);


%generating a sampling base of 5 minute intervals spanning one day
collection_period = 0:5:1425;
mutable_customer_power_IDs = get_mutable_IDs(tf_list_path);

%transposing due to weird concatenation constraints in MATLAB, see: https://www.mathworks.com/matlabcentral/answers/156075-how-to-get-rid-of-the-error-error-using-horzcat-dimensions-of-matrices-being-concatenated-are-not
TF_FPs = [mutable_customer_power_IDs',CD_TF_RBs];

%Variable names of all customer level IDs including R and B variables for
%mask completition
TF_CFPs = [viable_ev_customer_IDs,CD_TFC_RBs];

TFPID_flat_profiles_timetable = array2timetable(zeros(numel( ...
    collection_period),numel(TF_FPs)), "RowTimes", minutes( ...
    collection_period(:)),"VariableNames", ...
    TF_FPs);

TF_CUSTOMER_flat_profiles_timetable = array2timetable( ...
    zeros(numel(collection_period),numel(TF_CFPs)),"RowTimes", ...
    minutes(collection_period(:)),"VariableNames", ...
    TF_CFPs);

%%
customer_charging_levels = 0;

switch(chargers_being_used)
    case "1"
        customer_charging_levels = ones(1,num_ev_customers,'gpuArray');
    case "2"
        customer_charging_levels = ones(1,num_ev_customers,'gpuArray')*2;
    case "MIX"
        customer_charging_levels = randi(2,1,num_ev_customers,'gpuArray');
end

%% Generate flat profiles for both transformer variables, and transformer-customer pairings.


%charging_mask_set = cell(num_ev_customers,1);

%This approach is needed since preallocation results in ou
scenario_details = 0;

closed_delta_test_subject = 0;

for x=1:num_ev_customers
    %assigning selected charging level to customer
    charger_level = customer_charging_levels(x);

    %declaring variable to represent charger power rating
    charging_load = 0;

    %Assigning EV Customer ID for accessing their data in the load tables
    customer_ID = ev_customer_IDs(x);
    
    if charger_level == 1
        charging_load = 1.92;
    else
        charging_load = 6.6;
    end

    %generating charging mask using the NREL based probability distrubution
    [pre_overflow_mask,post_overflow_mask,scenario_start_time,scenario_duration] = generate_charging_mask(charger_level,charging_events_path);
    
    %adding the charging event time details to the mask list
    %charging_mask_set(x) = {charging_mask};   %possible bug

    event_details = {customer_ID,charger_level,scenario_start_time,scenario_duration};
    if x == 1
        scenario_details = cell2table(event_details,"VariableNames",["Customer ID","Charging Level", ...
            "Start Time(HH:MM)","Duration(HH:MM)"]);
    else
        scenario_details = [scenario_details; event_details];
    end

    %calculating number of datapoints needed to populate charging event
    num_timestamps_pre_overflow = size(TF_CUSTOMER_flat_profiles_timetable{pre_overflow_mask,customer_ID},1);
    num_timestamps_post_overflow = size(TF_CUSTOMER_flat_profiles_timetable{post_overflow_mask,customer_ID},1);


    %splitting the modified customer ID to check if connected transformer
    %is a closed delta
    customer_info_split = strsplit(customer_ID, 'C');
    tf_ID = customer_info_split(1);
    CID = customer_info_split(2);

    if sum(ismember(closed_delta_customers,tf_ID)) >=1
       
        %Declaring red and blue suffixes for connected transformer
        tf_ID_R = append(tf_ID,"R");
        tf_ID_B = append(tf_ID,"B");

        %fprintf("[!]CLOSED DELTA OCCURING AT: %s \n",customer_ID);
        closed_delta_test_subject = customer_ID;
%------------------------ WHITE PHASE ---=---------------------------------
        
        %add 2/3 of the EV load to customer base load(on the system this is
        %the 2nd phase) -- ADDING AT CUSTOMER LEVEL
        TF_CUSTOMER_flat_profiles_timetable{pre_overflow_mask,customer_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            pre_overflow_mask,customer_ID} + ones(num_timestamps_pre_overflow,1)*(2/3)*charging_load;

        TF_CUSTOMER_flat_profiles_timetable{post_overflow_mask,customer_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            post_overflow_mask,customer_ID} + ones(num_timestamps_post_overflow,1)*(2/3)*charging_load;

        %Adding to white phase -- ADDING AT TF LEVEL
        TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID} = TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID} +ones(num_timestamps_pre_overflow,1)*(2/3)*charging_load;

        TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID} = TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID} +ones(num_timestamps_post_overflow,1)*(2/3)*charging_load;


% ------------------------ RED PHASE --------------------------------------

        %add 1/3 load to R, this is the 1st phase on the system
        customer_R_ID = append(tf_ID_R,"C");
        customer_R_ID = append(customer_R_ID,CID);

        %superimposing the charging event onto the flat profile using the
        %charging mask and closed delta weightings -- ADDING AT CUSTOMER LEVEL
        TF_CUSTOMER_flat_profiles_timetable{pre_overflow_mask,customer_R_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            pre_overflow_mask,customer_R_ID} + ones(num_timestamps_pre_overflow,1)*(1/3)*charging_load;

        TF_CUSTOMER_flat_profiles_timetable{post_overflow_mask,customer_R_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            post_overflow_mask,customer_R_ID} + ones(num_timestamps_post_overflow,1)*(1/3)*charging_load;
       
        %Adding to red phase
        TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID_R} = TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID_R} +ones(num_timestamps_pre_overflow,1)*(1/3)*charging_load;
        TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID_R} = TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID_R} +ones(num_timestamps_post_overflow,1)*(1/3)*charging_load;

%----------------------- BLACK PHASE ------------------------------------

        customer_B_ID = append(tf_ID_B,"C");
        customer_B_ID = append(customer_B_ID,CID);

        %superimposing the charging event onto the flat profile using the
        %charging mask and closed delta weightings-- BLACK PHASE
        TF_CUSTOMER_flat_profiles_timetable{pre_overflow_mask,customer_B_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            pre_overflow_mask,customer_B_ID} + ones(num_timestamps_pre_overflow,1)*(1/3)*charging_load;

        TF_CUSTOMER_flat_profiles_timetable{post_overflow_mask,customer_B_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            post_overflow_mask,customer_B_ID} + ones(num_timestamps_post_overflow,1)*(1/3)*charging_load;

        %Adding to black phase
        TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID_B} = TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID_B} +ones(num_timestamps_pre_overflow,1)*(1/3)*charging_load;
        TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID_B} = TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID_B} +ones(num_timestamps_post_overflow,1)*(1/3)*charging_load;
        

    else
        TF_CUSTOMER_flat_profiles_timetable{pre_overflow_mask,customer_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            pre_overflow_mask,customer_ID} + ones(num_timestamps_pre_overflow,1)*charging_load;

        TF_CUSTOMER_flat_profiles_timetable{post_overflow_mask,customer_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            post_overflow_mask,customer_ID} + ones(num_timestamps_post_overflow,1)*charging_load;

        TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID} = TFPID_flat_profiles_timetable{pre_overflow_mask,tf_ID} +ones(num_timestamps_pre_overflow,1)*charging_load;
        TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID} = TFPID_flat_profiles_timetable{post_overflow_mask,tf_ID} +ones(num_timestamps_post_overflow,1)*charging_load;
        
    end

end 
%% Aggregating customers loads onto their transformers

modified_base_load = customer_base_loads_tt;

for x=1:num_ev_customers
    customer_ID = ev_customer_IDs(x);

    %splitting the modified customer ID to check if connected transformer
    %is a closed delta
    customer_info_split = strsplit(customer_ID, 'C');
    tf_ID = customer_info_split(1);
    CID = customer_info_split(2);

    if sum(ismember(closed_delta_customers,tf_ID)) >=1
        tf_ID_R = append(tf_ID,"R");
        tf_ID_B = append(tf_ID,"B");

        customer_R_ID = append(tf_ID_R,"C");
        customer_R_ID = append(customer_R_ID,CID);

        customer_B_ID = append(tf_ID_B,"C");
        customer_B_ID = append(customer_B_ID,CID);

        modified_base_load(:,tf_ID) = num2cell(modified_base_load{:,tf_ID} + TF_CUSTOMER_flat_profiles_timetable{:,customer_ID});
        modified_base_load(:,tf_ID_R) = num2cell(modified_base_load{:,tf_ID_R} + TF_CUSTOMER_flat_profiles_timetable{:,customer_R_ID});
        modified_base_load(:,tf_ID_B) = num2cell(modified_base_load{:,tf_ID_B} + TF_CUSTOMER_flat_profiles_timetable{:,customer_B_ID});
    else
        modified_base_load(:,tf_ID) = num2cell(modified_base_load{:,tf_ID} + TF_CUSTOMER_flat_profiles_timetable{:,customer_ID});

    end

end

%% Writing scenario details
modified_base_load.Time.Format = 'hh:mm';
%scenario_details
%% Validating at the customer level -- REG. CONFIG
%Adding load for one of the selected customers who is not a closed delta
% test_subject = "P95C4";
% customer_base_loads_tt.Time.Format = 'hh:mm';
% 
% customer_info_split = strsplit(test_subject, 'C');
% tf_ID = customer_info_split(1);
% 
% %add power to a temporary variable and assign it as the mod val
% test_subject_modified_load = customer_base_loads_tt(:,tf_ID);
% test_subject_modified_load(:,tf_ID) = num2cell(test_subject_modified_load{ ...
%     :,tf_ID} + TF_CUSTOMER_flat_profiles_timetable{:,test_subject});
% 
% %plot base load in a light blue
% plot(customer_base_loads_tt(:,tf_ID),'Time',tf_ID,'Color',"#80B3FF")
% hAx=gca;
% set(hAx,'YGrid','on','XGrid','on')
% %set(hAx,'xminorgrid','on','yminorgrid','on')
% hold on
% 
% % %plot modified load in red
% plot(test_subject_modified_load,'Time',tf_ID,'Color','red','LineStyle','--')
% hold off

q=0;

%% Validating at the customer level -- CLOSED DELTA

% %test_subject = closed_delta_test_subject;
% test_subject =  "P53C11";
% customer_info_split = strsplit(test_subject, 'C');
% tf_ID = customer_info_split(1);
% CID = customer_info_split(2);
% 
% tf_ID_R = append(tf_ID,"R");
% tf_ID_B = append(tf_ID,"B");
% 
% customer_B_ID = append(tf_ID_B,"C");
% customer_B_ID = append(customer_B_ID,CID);
% 
% customer_R_ID = append(tf_ID_R,"C");
% customer_R_ID = append(customer_R_ID,CID);
% 
% red_base = customer_base_loads_tt(:,tf_ID_R);
% white_base = customer_base_loads_tt(:,tf_ID);
% black_base = customer_base_loads_tt(:,tf_ID_B);
% 
% 
% red_mod = red_base;
% white_mod = white_base;
% black_mod = black_base;
% 
% red_mod(:,tf_ID_R) = num2cell(red_base{ ...
%     :,tf_ID_R} + TF_CUSTOMER_flat_profiles_timetable{:,customer_R_ID});
% 
% white_mod(:,tf_ID) = num2cell(white_base{ ...
%     :,tf_ID} + TF_CUSTOMER_flat_profiles_timetable{:,test_subject});
% 
% 
% black_mod(:,tf_ID_B) = num2cell(black_base{ ...
%     :,tf_ID_B} + TF_CUSTOMER_flat_profiles_timetable{:,customer_B_ID});
% 
% % Create the figure and subplots
% figure;
% subplot(3, 1, 1);
% hold on;
% % Plot red_base and red_mod in the first subplot
% plot(red_base,'Time', tf_ID_R, 'color', "#FF0303", 'DisplayName', 'red\_base');
% plot(red_mod,'Time', tf_ID_R, 'color', "#227C70", 'DisplayName', 'red\_mod','LineStyle','--');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% grid on
% 
% subplot(3, 1, 2);
% hold on;
% % Plot white_base and white_mod in the second subplot
% plot(white_base,'Time', tf_ID, 'color', "#27E1C1", 'DisplayName', 'white\_base');
% plot(white_mod,'Time', tf_ID, 'color', "#227C70", 'DisplayName', 'white\_mod','LineStyle','--');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% grid on
% 
% subplot(3, 1, 3);
% hold on;
% % Plot black_base and black_mod in the third subplot
% plot(black_base,'Time', tf_ID_B, 'color', "#E7AB9A", 'DisplayName', 'black\_base');
% plot(black_mod,'Time', tf_ID_B, 'color', "#227C70", 'DisplayName', 'black\_mod','LineStyle','--');
% xlabel('Time');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% 
% grid on
% % Adjust spacing between subplots
% sgtitle('Closed Delta Load Sharing during Charging Event');
% 
% hold off

q=0;

% %% Validating at the TF level -- REG CONFIG
% %Adding load for one of the selected customers who is not a closed delta
% %test_subject = ev_customer_IDs(1);
% test_subject = "P156C1";
% customer_base_loads_tt.Time.Format = 'hh:mm';
% 
% customer_info_split = strsplit(test_subject, 'C');
% tf_ID = customer_info_split(1);
% CID = customer_info_split(2);
% 
% 
% %add power to a temporary variable and assign it as the mod val
% 
% test_subject_modified_load = customer_base_loads_tt(:,tf_ID);
% test_subject_modified_load(:,tf_ID) = num2cell(test_subject_modified_load{ ...
%     :,tf_ID} + TFPID_flat_profiles_timetable{:,tf_ID});
% 
% %plot base load in a light blue
% plot(customer_base_loads_tt(:,tf_ID),'Time',tf_ID,'Color',"#80B3FF")
% hAx=gca;
% set(hAx,'YGrid','on','XGrid','on')
% %set(hAx,'xminorgrid','on','yminorgrid','on')
% hold on
% 
% plot(test_subject_modified_load,'Time',tf_ID,'Color','red')
% hold off
% %% Validating at the TF level -- CLOSED DELTA
% test_subject = closed_delta_test_subject;
% customer_info_split = strsplit(test_subject, 'C');
% tf_ID = customer_info_split(1);
% CID = customer_info_split(2);
% tf_ID_R = append(tf_ID,"R");
% tf_ID_B = append(tf_ID,"B");
% 
% 
% red_base = customer_base_loads_tt(:,tf_ID_R);
% white_base = customer_base_loads_tt(:,tf_ID);
% black_base = customer_base_loads_tt(:,tf_ID_B);
% 
% 
% red_mod = red_base;
% white_mod = white_base;
% black_mod = black_base;
% 
% red_mod(:,tf_ID_R) = num2cell(red_base{ ...
%     :,tf_ID_R} + TFPID_flat_profiles_timetable{:,tf_ID_R});
% 
% white_mod(:,tf_ID) = num2cell(white_base{ ...
%     :,tf_ID} + TFPID_flat_profiles_timetable{:,tf_ID});
% 
% 
% black_mod(:,tf_ID_B) = num2cell(black_base{ ...
%     :,tf_ID_B} + TFPID_flat_profiles_timetable{:,tf_ID_B});
% 
% % Create the figure and subplots
% figure;
% subplot(3, 1, 1);
% hold on;
% % Plot red_base and red_mod in the first subplot
% plot(red_base,'Time', tf_ID_R, 'color', "#FF0303", 'DisplayName', 'red\_base');
% plot(red_mod,'Time', tf_ID_R, 'color', "#227C70", 'DisplayName', 'red\_mod','LineStyle','--');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% grid on
% 
% subplot(3, 1, 2);
% hold on;
% % Plot white_base and white_mod in the second subplot
% plot(white_base,'Time', tf_ID, 'color', "#27E1C1", 'DisplayName', 'white\_base');
% plot(white_mod,'Time', tf_ID, 'color', "#227C70", 'DisplayName', 'white\_mod','LineStyle','--');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% grid on
% 
% subplot(3, 1, 3);
% hold on;
% % Plot black_base and black_mod in the third subplot
% plot(black_base,'Time', tf_ID_B, 'color', "#E7AB9A", 'DisplayName', 'black\_base');
% plot(black_mod,'Time', tf_ID_B, 'color', "#227C70", 'DisplayName', 'black\_mod','LineStyle','--');
% xlabel('Time');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% 
% grid on
% % Adjust spacing between subplots
% sgtitle('Closed Delta Load Sharing during Charging Event');
% hold off