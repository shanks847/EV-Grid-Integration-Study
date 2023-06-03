%% Optimizing initialization of flat profiles via preallocation and array2timtable method
clear all
clc

collection_period = 0:5:1425;
mutable_customer_power_IDs = ["P1","P2","P3","P4"];
mapping_ids = ["P1C1","P2C3","P3C5","PC1"];

%preallocating space to reduce runtime
TF_CUSTOMER_flat_profiles = array2timetable( ...
    zeros(numel(collection_period),numel(mapping_ids)),"RowTimes", ...
    minutes(collection_period(:)),"VariableNames", ...
    mutable_customer_power_IDs);

%% Checking to see if IDs for flat profile are valid -- PASED

clear all
clc

tf_list_path = "C:\Users\Shankar Ramharack\Documents\EV-Grid-Integration-Study-STABLE\data\load_statistical_analysis\customers_from_disaggregation.xlsx";

data = readtable(tf_list_path, 'Sheet', 1, 'VariableNamingRule', 'preserve');

% Get the column index of "TF Power" and "Loading"
tfPowerColIndex = find(strcmp(data.Properties.VariableNames, 'TF Power'));
loadingColIndex = find(strcmp(data.Properties.VariableNames, 'Loading'));

% Initialize the lists for TF Power values without suffix and ending with "R"
mutable_IDs = {};

% Iterate over the rows and check the Loading column
for i = 1:size(data, 1)
    loadingValue = data{i, loadingColIndex};
    
    % Check if the Loading value is nonzero
    if loadingValue ~= 0
        tfPowerValue = data{i, tfPowerColIndex};
        mutable_IDs = [mutable_IDs; tfPowerValue];
     end
end

mutable_IDs

%% Checking Generation of Flat Profile -- PASSED

clear all
clc

tf_details_path = "C:\Users\Shankar Ramharack\Documents\EV-Grid-Integration-Study-STABLE\data\load_statistical_analysis\customers_from_disaggregation.xlsx";



%generating a sampling base of 5 minute intervals spanning one day
collection_period = 0:5:1425;
%mutable_customer_power_IDs = ["P1","P2","P3","P4"];
%mapping_ids = ["P1C1","P2C3","P3C5","PC1"];
mutable_customer_power_IDs = get_mutable_IDs(tf_details_path);
mapping_ids = get_modified_customer_ID(tf_details_path);



TFPID_flat_profiles_timetable = array2timetable( ...
    zeros(numel(collection_period),numel(mutable_customer_power_IDs)), ...
    "RowTimes", minutes(collection_period(:)),"VariableNames", ...
    mutable_customer_power_IDs);

TF_CUSTOMER_flat_profiles = array2timetable( ...
    zeros(numel(collection_period),numel(mapping_ids)),"RowTimes", ...
    minutes(collection_period(:)),"VariableNames", ...
    mapping_ids);



%% TEST ADDDING

%NEED TO DO A STACKED PLOT ON DUMMY DATA
clear all
clc

tf_list_path = "C:\Users\Shankar Ramharack\Documents\EV-Grid-Integration-Study-STABLE\data\load_statistical_analysis\customers_from_disaggregation.xlsx";
charging_events_path = "C:\Users\Shankar Ramharack\Documents\EV-Grid-Integration-Study-STABLE\data\misc\charging_events.mat";

%% Setting a seed to make results reproducible
rng(1);
opts = delimitedTextImportOptions("NumVariables", 507);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Time", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27", "P28", "P29", "P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37", "P38", "P39", "P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47", "P48", "P49", "P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57", "P58", "P59", "P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67", "P68", "P69", "P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77", "P78", "P79", "P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87", "P88", "P89", "P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97", "P98", "P99", "P100", "P101", "P102", "P103", "P104", "P105", "P106", "P107", "P108", "P109", "P110", "P111", "P112", "P113", "P114", "P115", "P116", "P117", "P118", "P119", "P120", "P121", "P122", "P123", "P124", "P125", "P126", "P127", "P128", "P129", "P130", "P131", "P132", "P133", "P134", "P135", "P136", "P137", "P138", "P139", "P140", "P141", "P142", "P143", "P144", "P145", "P146", "P147", "P148", "P149", "P150", "P151", "P152", "P153", "P154", "P155", "P156", "P157", "P158", "P159", "P160", "P161", "P162", "P163", "P164", "P165", "P166", "P167", "P168", "P169", "P170", "P171", "P172", "P173", "P174", "P175", "P176", "P177", "P178", "P179", "P180", "P181", "P182", "P183", "P184", "P185", "P186", "P187", "P188", "P189", "P190", "P191", "P192", "P193", "P194", "P195", "P196", "P197", "P198", "P199", "P200", "P201", "P202", "P203", "P204", "P205", "P206", "P207", "P208", "P209", "P210", "P211", "P212", "P213", "P214", "P215", "P10R", "P10B", "P25R", "P25B", "P33R", "P33B", "P34R", "P34B", "P43R", "P43B", "P53R", "P53B", "P54R", "P54B", "P63R", "P63B", "P64R", "P64B", "P65R", "P65B", "P73R", "P73B", "P115R", "P115B", "P163R", "P163B", "P182R", "P182B", "P198R", "P198B", "P202R", "P202B", "P207R", "P207B", "P212R", "P212B", "P215R", "P215B", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13", "Q14", "Q15", "Q16", "Q17", "Q18", "Q19", "Q20", "Q21", "Q22", "Q23", "Q24", "Q25", "Q26", "Q27", "Q28", "Q29", "Q30", "Q31", "Q32", "Q33", "Q34", "Q35", "Q36", "Q37", "Q38", "Q39", "Q40", "Q41", "Q42", "Q43", "Q44", "Q45", "Q46", "Q47", "Q48", "Q49", "Q50", "Q51", "Q52", "Q53", "Q54", "Q55", "Q56", "Q57", "Q58", "Q59", "Q60", "Q61", "Q62", "Q63", "Q64", "Q65", "Q66", "Q67", "Q68", "Q69", "Q70", "Q71", "Q72", "Q73", "Q74", "Q75", "Q76", "Q77", "Q78", "Q79", "Q80", "Q81", "Q82", "Q83", "Q84", "Q85", "Q86", "Q87", "Q88", "Q89", "Q90", "Q91", "Q92", "Q93", "Q94", "Q95", "Q96", "Q97", "Q98", "Q99", "Q100", "Q101", "Q102", "Q103", "Q104", "Q105", "Q106", "Q107", "Q108", "Q109", "Q110", "Q111", "Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120", "Q121", "Q122", "Q123", "Q124", "Q125", "Q126", "Q127", "Q128", "Q129", "Q130", "Q131", "Q132", "Q133", "Q134", "Q135", "Q136", "Q137", "Q138", "Q139", "Q140", "Q141", "Q142", "Q143", "Q144", "Q145", "Q146", "Q147", "Q148", "Q149", "Q150", "Q151", "Q152", "Q153", "Q154", "Q155", "Q156", "Q157", "Q158", "Q159", "Q160", "Q161", "Q162", "Q163", "Q164", "Q165", "Q166", "Q167", "Q168", "Q169", "Q170", "Q171", "Q172", "Q173", "Q174", "Q175", "Q176", "Q177", "Q178", "Q179", "Q180", "Q181", "Q182", "Q183", "Q184", "Q185", "Q186", "Q187", "Q188", "Q189", "Q190", "Q191", "Q192", "Q193", "Q194", "Q195", "Q196", "Q197", "Q198", "Q199", "Q200", "Q201", "Q202", "Q203", "Q204", "Q205", "Q206", "Q207", "Q208", "Q209", "Q210", "Q211", "Q212", "Q213", "Q214", "Q215", "Q10R", "Q10B", "Q25R", "Q25B", "Q33R", "Q33B", "Q34R", "Q34B", "Q43R", "Q43B", "Q53R", "Q53B", "Q54R", "Q54B", "Q63R", "Q63B", "Q64R", "Q64B", "Q65R", "Q65B", "Q73R", "Q73B", "Q115R", "Q115B", "Q163R", "Q163B", "Q182R", "Q182B", "Q198R", "Q198B", "Q202R", "Q202B", "Q207R", "Q207B", "Q212R", "Q212B", "Q215R", "Q215B"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Time", "InputFormat", "yyyy-MM-dd HH:mm:ss");

STABLE_balanced_eba_hres_path = "C:\Users\Shankar Ramharack\Documents\EV-Grid-Integration-Study-STABLE\data\balanced loads\balanced_eba_hres.csv"
balanced_eba_hres = readtable(STABLE_balanced_eba_hres_path,opts);

customer_ids = opts.VariableNames;
customer_ids = customer_ids(2:length(customer_ids));
clear opts

customer_base_loads = balanced_eba_hres;
customer_base_loads_tstep = minutes(minutes(customer_base_loads(2,1).Time - customer_base_loads(1,1).Time)); %calculating the timestep based on the values of the table
customer_power_data = customer_base_loads(:,2:size(customer_base_loads,2)); %isolating the power readings of the original table
customer_base_loads_st = minutes(minute(customer_base_loads(1, 1).Time)); %start time of the utilization data
customer_base_loads_tt = table2timetable(customer_power_data,'TimeStep',customer_base_loads_tstep,'StartTime',customer_base_loads_st);







% ---------------------------------- SCENARIO PARAMETERS -------------------


num_feeder_customers = 2400;
penetration_level = 0.05;
chargers_being_used = "MIX"; % Takes on either:"1", "2" OR "MIX"
closed_delta_customers = ["P33","P53","P115","P182","P198","P202","P207"];

%----------------------------------------------------------------------------------
%calculating number of EV customers on feeder based on penetration
num_ev_customers = round(penetration_level*num_feeder_customers);

%creating transformer-customer pair IDs
viable_ev_customer_IDs = get_modified_customer_ID(tf_list_path);

% Generate random indices, randperm(n) eturns a row vector containing a random permutation of the integers from 1 to n without repeating elements.
randomIndices = randperm(numel(viable_ev_customer_IDs), num_ev_customers);

% Sample from the string array using the random indices
ev_customer_IDs = viable_ev_customer_IDs(randomIndices);


%generating a sampling base of 5 minute intervals spanning one day
collection_period = 0:5:1425;
%mutable_customer_power_IDs = ["P1","P2","P3","P4"];
%mapping_ids = ["P1C1","P2C3","P3C5","PC1"];
mutable_customer_power_IDs = get_mutable_IDs(tf_list_path);
mapping_ids = get_modified_customer_ID(tf_list_path);



TFPID_flat_profiles_timetable = array2timetable( ...
    zeros(numel(collection_period),numel(mutable_customer_power_IDs)), ...
    "RowTimes", minutes(collection_period(:)),"VariableNames", ...
    mutable_customer_power_IDs);

TF_CUSTOMER_flat_profiles_timetable = array2timetable( ...
    zeros(numel(collection_period),numel(mapping_ids)),"RowTimes", ...
    minutes(collection_period(:)),"VariableNames", ...
    mapping_ids);


customer_charging_levels = 0;

switch(chargers_being_used)
    case "1"
        customer_charging_levels = ones(1,num_ev_customers);
    case "2"
        customer_charging_levels = ones(1,num_ev_customers)*2;
    case "MIX"
        customer_charging_levels = randi(2,1,num_ev_customers);
end

collection_period = 0:5:1425;
charging_mask_set = cell(num_ev_customers,1);

%create a table of zeros and then use array2timetable and the respec.
%headings to generate  the scenario details

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
    [charging_mask,scenario_start_time,scenario_duration] = generate_charging_mask(charger_level,charging_events_path);
    
    %adding the charging event time details to the mask list
    charging_mask_set(x) = {charging_mask};   %possible bug

    event_details = {customer_ID,charger_level,scenario_start_time,scenario_duration};
    if x == 1
        scenario_details = cell2table(event_details,"VariableNames",["Customer ID","Charging Level", ...
            "Start Time(HH:MM)","Duration(HH:MM)"]);
    else
        scenario_details = [scenario_details; event_details];
    end

    %calculating number of datapoints needed to populate charging event
    num_timestamps = size(TF_CUSTOMER_flat_profiles_timetable{charging_mask,customer_ID},1);

    %splitting the modified customer ID to check if connected transformer
    %is a closed delta
    customer_info_split = strsplit(customer_ID, 'C');
    tf_ID = customer_info_split(1);
    CID = customer_info_split(2);

    if sum(ismember(closed_delta_customers,tf_ID)) >=1
       
        %Declaring red and blue suffixes for connected transformer
        tf_ID_R = append(tf_ID,"R");
        tf_ID_B = append(tf_ID,"B");

        fprintf("[!]CLOSED DELTA OCCURING AT: %s \n",customer_ID);
        closed_delta_test_subject = customer_ID;
%------------------------ WHITE PHASE ---=---------------------------------
        
        %add 2/3 of the EV load to customer base load(on the system this is
        %the 2nd phase) -- ADDING AT CUSTOMER LEVEL
        TF_CUSTOMER_flat_profiles_timetable{charging_mask,customer_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            charging_mask,customer_ID} + ones(num_timestamps,1)*(2/3)*charging_load;

        %Adding to white phase -- ADDING AT TF LEVEL
        TFPID_flat_profiles_timetable{charging_mask,tf_ID} = TFPID_flat_profiles_timetable{charging_mask,tf_ID} +ones(num_timestamps,1)*(2/3)*charging_load;


% ------------------------ RED PHASE --------------------------------------

        %add 1/3 load to R, this is the 1st phase on the system
        customer_R_ID = append(tf_ID_R,"C");
        customer_R_ID = append(customer_R_ID,CID);

        %superimposing the charging event onto the flat profile using the
        %charging mask and closed delta weightings -- ADDING AT CUSTOMER LEVEL
        TF_CUSTOMER_flat_profiles_timetable{charging_mask,customer_R_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            charging_mask,customer_R_ID} + ones(num_timestamps,1)*(1/3)*charging_load;
       
        %Adding to red phase
        TFPID_flat_profiles_timetable{charging_mask,tf_ID_R} = TFPID_flat_profiles_timetable{charging_mask,tf_ID_R} +ones(num_timestamps,1)*(1/3)*charging_load;
%----------------------- BLACK PHASE ------------------------------------

        customer_B_ID = append(tf_ID_B,"C");
        customer_B_ID = append(customer_B_ID,CID);

        %superimposing the charging event onto the flat profile using the
        %charging mask and closed delta weightings-- BLACK PHASE
        TF_CUSTOMER_flat_profiles_timetable{charging_mask,customer_B_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            charging_mask,customer_B_ID} + ones(num_timestamps,1)*(1/3)*charging_load;


        %Adding to black phase
        TFPID_flat_profiles_timetable{charging_mask,tf_ID_B} = TFPID_flat_profiles_timetable{charging_mask,tf_ID_B} +ones(num_timestamps,1)*(1/3)*charging_load;

%         TF_CUSTOMER_flat_profiles_timetable{charging_mask,[customer_ID,customer_R_ID,customer_B_ID]}
% 
%         validation_modified_base_load = customer_base_loads_tt;
%         validation_modified_base_load(:,tf_ID) = num2cell(validation_modified_base_load{:,tf_ID} + TFPID_flat_profiles_timetable{:,tf_ID});
%         validation_modified_base_load(:,tf_ID_R) = num2cell(validation_modified_base_load{:,tf_ID_R} + TFPID_flat_profiles_timetable{:,tf_ID_R});
%         validation_modified_base_load(:,tf_ID_B) = num2cell(validation_modified_base_load{:,tf_ID_B} + TFPID_flat_profiles_timetable{:,tf_ID_B});
% 
%         customer_base_loads_tt{charging_mask,[tf_ID,tf_ID_R,tf_ID_B]}
%         validation_modified_base_load{charging_mask,[tf_ID,tf_ID_R,tf_ID_B]}
        

    else
        TF_CUSTOMER_flat_profiles_timetable{charging_mask,customer_ID} = TF_CUSTOMER_flat_profiles_timetable{ ...
            charging_mask,customer_ID} + ones(num_timestamps,1)*charging_load;

        TFPID_flat_profiles_timetable{charging_mask,tf_ID} = TFPID_flat_profiles_timetable{charging_mask,tf_ID} +ones(num_timestamps,1)*charging_load;
        
    end

end 
%%
%Adding load for one of the selected customers who is not a closed delta
test_subject = ev_customer_IDs(1);
customer_base_loads_tt.Time.Format = 'hh:mm';

customer_info_split = strsplit(test_subject, 'C');
tf_ID = customer_info_split(1);
CID = customer_info_split(2);

tf_ID_R = append(tf_ID,"R");
tf_ID_B = append(tf_ID,"B");

%add power to a temporary variable and assign it as the mod val

test_subject_modified_load = customer_base_loads_tt(:,tf_ID);
test_subject_modified_load(:,tf_ID) = num2cell(test_subject_base_load{ ...
    :,tf_ID} + TFPID_flat_profiles_timetable{:,tf_ID});

%plot base load in a light blue
plot(customer_base_loads_tt(:,tf_ID),'Time',tf_ID,'Color',"#80B3FF")
hAx=gca;
set(hAx,'YGrid','on','XGrid','on')
%set(hAx,'xminorgrid','on','yminorgrid','on')
hold on


%plot charging event in yellow
% plot(TF_CUSTOMER_flat_profiles_timetable(:,test_subject), ...
%     'Time',test_subject,'Color',"#EDB120")

% %plot modified load in red
plot(test_subject_modified_load,'Time',tf_ID,'Color','red')

ylim([10 25])
%%



% Define the colors for base and mod

test_subject = closed_delta_test_subject;
customer_info_split = strsplit(test_subject, 'C');
tf_ID = customer_info_split(1);
CID = customer_info_split(2);
tf_ID_R = append(tf_ID,"R");
tf_ID_B = append(tf_ID,"B");


red_base = customer_base_loads_tt(:,tf_ID_R);
white_base = customer_base_loads_tt(:,tf_ID);
black_base = customer_base_loads_tt(:,tf_ID_B);


red_mod = red_base;
white_mod = white_base;
black_mod = black_base;

red_mod(:,tf_ID_R) = num2cell(red_base{ ...
    :,tf_ID_R} + TFPID_flat_profiles_timetable{:,tf_ID_R});

white_mod(:,tf_ID) = num2cell(white_base{ ...
    :,tf_ID} + TFPID_flat_profiles_timetable{:,tf_ID});


black_mod(:,tf_ID_B) = num2cell(black_base{ ...
    :,tf_ID_B} + TFPID_flat_profiles_timetable{:,tf_ID_B});

% Create the figure and subplots
figure;
subplot(3, 1, 1);
hold on;
% Plot red_base and red_mod in the first subplot
plot(red_base,'Time', tf_ID_R, 'color', "#FF0303", 'DisplayName', 'red\_base');
plot(red_mod,'Time', tf_ID_R, 'color', "#227C70", 'DisplayName', 'red\_mod','LineStyle','--');
% Create ylabel
ylabel('Power/kW');
legend('Location', 'best');
set(gca,'FontSize',18)
grid on

subplot(3, 1, 2);
hold on;
% Plot white_base and white_mod in the second subplot
plot(white_base,'Time', tf_ID, 'color', "#27E1C1", 'DisplayName', 'white\_base');
plot(white_mod,'Time', tf_ID, 'color', "#227C70", 'DisplayName', 'white\_mod','LineStyle','--');
% Create ylabel
ylabel('Power/kW');
legend('Location', 'best');
set(gca,'FontSize',18)
grid on

subplot(3, 1, 3);
hold on;
% Plot black_base and black_mod in the third subplot
plot(black_base,'Time', tf_ID_B, 'color', "#E7AB9A", 'DisplayName', 'black\_base');
plot(black_mod,'Time', tf_ID_B, 'color', "#227C70", 'DisplayName', 'black\_mod','LineStyle','--');
xlabel('Time');
% Create ylabel
ylabel('Power/kW');
legend('Location', 'best');
set(gca,'FontSize',18)

grid on
% Adjust spacing between subplots
sgtitle('Closed Delta Load Sharing during Charging Event');

ylim([10 25])
