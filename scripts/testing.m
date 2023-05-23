% opts = ["C22","C21","C78"];
% x = "C22";
% if sum(contains(opts,x)) >= 1
%     disp("Works");
% else
%     disp("No works");
% end


%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 7);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:G287";

% Specify column names and types
opts.VariableNames = ["Time", "P33", "P110", "P33R", "P33B", "Q33R", "Q33B"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double"];


% Specify variable properties
opts = setvaropts(opts, "Time", "InputFormat", "");

% Import the data
test_table = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\testing_power_spitting.xlsx", opts, "UseExcel", false);


%% Testing Access.
customer_ids = opts.VariableNames;
customer_ids = customer_ids(2:length(customer_ids));

clear opts
test_time_table = table2timetable(test_table)
test_time_table.Time.Format = 'HH:mm' %need to change all format in load_agg.m and base_load_aggregation.m to this
test_time_table(:,{'P33R'}) %NOTE: '(' and ')' return tables
%% Testing accessing part of customer ID
test_str = "P33"
test_str(2:end)
%% 
% 
%             TESTING
% 
% 
% 
%             BASE            LOAD
% 
% 
% 
% 
%             AGGREGATION
% 
% 

%Importing full data
opts = delimitedTextImportOptions("NumVariables", 507);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["Time", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27", "P28", "P29", "P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37", "P38", "P39", "P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47", "P48", "P49", "P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57", "P58", "P59", "P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67", "P68", "P69", "P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77", "P78", "P79", "P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87", "P88", "P89", "P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97", "P98", "P99", "P100", "P101", "P102", "P103", "P104", "P105", "P106", "P107", "P108", "P109", "P110", "P111", "P112", "P113", "P114", "P115", "P116", "P117", "P118", "P119", "P120", "P121", "P122", "P123", "P124", "P125", "P126", "P127", "P128", "P129", "P130", "P131", "P132", "P133", "P134", "P135", "P136", "P137", "P138", "P139", "P140", "P141", "P142", "P143", "P144", "P145", "P146", "P147", "P148", "P149", "P150", "P151", "P152", "P153", "P154", "P155", "P156", "P157", "P158", "P159", "P160", "P161", "P162", "P163", "P164", "P165", "P166", "P167", "P168", "P169", "P170", "P171", "P172", "P173", "P174", "P175", "P176", "P177", "P178", "P179", "P180", "P181", "P182", "P183", "P184", "P185", "P186", "P187", "P188", "P189", "P190", "P191", "P192", "P193", "P194", "P195", "P196", "P197", "P198", "P199", "P200", "P201", "P202", "P203", "P204", "P205", "P206", "P207", "P208", "P209", "P210", "P211", "P212", "P213", "P214", "P215", "P10R", "P10B", "P25R", "P25B", "P33R", "P33B", "P34R", "P34B", "P43R", "P43B", "P53R", "P53B", "P54R", "P54B", "P63R", "P63B", "P64R", "P64B", "P65R", "P65B", "P73R", "P73B", "P115R", "P115B", "P163R", "P163B", "P182R", "P182B", "P198R", "P198B", "P202R", "P202B", "P207R", "P207B", "P212R", "P212B", "P215R", "P215B", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13", "Q14", "Q15", "Q16", "Q17", "Q18", "Q19", "Q20", "Q21", "Q22", "Q23", "Q24", "Q25", "Q26", "Q27", "Q28", "Q29", "Q30", "Q31", "Q32", "Q33", "Q34", "Q35", "Q36", "Q37", "Q38", "Q39", "Q40", "Q41", "Q42", "Q43", "Q44", "Q45", "Q46", "Q47", "Q48", "Q49", "Q50", "Q51", "Q52", "Q53", "Q54", "Q55", "Q56", "Q57", "Q58", "Q59", "Q60", "Q61", "Q62", "Q63", "Q64", "Q65", "Q66", "Q67", "Q68", "Q69", "Q70", "Q71", "Q72", "Q73", "Q74", "Q75", "Q76", "Q77", "Q78", "Q79", "Q80", "Q81", "Q82", "Q83", "Q84", "Q85", "Q86", "Q87", "Q88", "Q89", "Q90", "Q91", "Q92", "Q93", "Q94", "Q95", "Q96", "Q97", "Q98", "Q99", "Q100", "Q101", "Q102", "Q103", "Q104", "Q105", "Q106", "Q107", "Q108", "Q109", "Q110", "Q111", "Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120", "Q121", "Q122", "Q123", "Q124", "Q125", "Q126", "Q127", "Q128", "Q129", "Q130", "Q131", "Q132", "Q133", "Q134", "Q135", "Q136", "Q137", "Q138", "Q139", "Q140", "Q141", "Q142", "Q143", "Q144", "Q145", "Q146", "Q147", "Q148", "Q149", "Q150", "Q151", "Q152", "Q153", "Q154", "Q155", "Q156", "Q157", "Q158", "Q159", "Q160", "Q161", "Q162", "Q163", "Q164", "Q165", "Q166", "Q167", "Q168", "Q169", "Q170", "Q171", "Q172", "Q173", "Q174", "Q175", "Q176", "Q177", "Q178", "Q179", "Q180", "Q181", "Q182", "Q183", "Q184", "Q185", "Q186", "Q187", "Q188", "Q189", "Q190", "Q191", "Q192", "Q193", "Q194", "Q195", "Q196", "Q197", "Q198", "Q199", "Q200", "Q201", "Q202", "Q203", "Q204", "Q205", "Q206", "Q207", "Q208", "Q209", "Q210", "Q211", "Q212", "Q213", "Q214", "Q215", "Q10R", "Q10B", "Q25R", "Q25B", "Q33R", "Q33B", "Q34R", "Q34B", "Q43R", "Q43B", "Q53R", "Q53B", "Q54R", "Q54B", "Q63R", "Q63B", "Q64R", "Q64B", "Q65R", "Q65B", "Q73R", "Q73B", "Q115R", "Q115B", "Q163R", "Q163B", "Q182R", "Q182B", "Q198R", "Q198B", "Q202R", "Q202B", "Q207R", "Q207B", "Q212R", "Q212B", "Q215R", "Q215B"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, "Time", "InputFormat", "yyyy-MM-dd HH:mm:ss");
customer_base_loads = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\full_load_data_hres.csv", opts);

test_customer_ids = opts.VariableNames;
test_customer_ids = test_customer_ids(2:length(test_customer_ids));
customer_base_loads(1,:) = [] ;

%% specifying which customers are on closed deltas
closed_delta_customers = ["P33","P53","P115","P182","P198","P202","P207"];

customer_base_loads_tstep = minutes(minutes(customer_base_loads(2,1).Time - customer_base_loads(1,1).Time)); %calculating the timestep based on the values of the table
customer_power_data = customer_base_loads(:,2:size(customer_base_loads,2)); %isolating the power readings of the original table
customer_base_loads_st = minutes(minute(customer_base_loads(1, 1).Time)); %start time of the utilization data
customer_base_loads_tt = table2timetable(customer_power_data,'TimeStep',customer_base_loads_tstep,'StartTime',customer_base_loads_st);

%% Generating starting times and durations

%Specify distributions for level 2 start times and durations
level2_start_times = makedist("Normal",916.60,302.02);
level2_durations = makedist("GeneralizedPareto",'theta',16.92, ...
    'sigma',3.08,'k',0.55);

level1_start_times = makedist("Normal",877.50,294.90);
level1_durations = makedist("GeneralizedPareto",'theta',-94.34,'sigma',114.34,'k',2.02);


%choosing level 2 for the test scenario
start_distribution = level1_start_times;
duration_distribution = level1_durations;

%declaing the charging level for the scenario to be generated
scenario_clevel = 1;

%%  INITIALIZATION
%test customer(NOT ON CLOSED DELTA)
tcust_ID = "P33";
customer_ID = tcust_ID;

%specifying charging level based on generated scenario for customer
charging_level = 0;
if scenario_clevel == 1
    charging_level = 1.92;
else
    charging_level = 6.6;
end

%make a charging scenario, rounding minutes to multiples of 5 to improve stability
scenario_start_time = 5*round(start_distribution.random()/5); %generating scenario start time from start time distribution
scenario_duration = 5*round(duration_distribution.random()/5); %generating scenario start time from start time distribution

scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
charging_mask = timerange(minutes(scenario_start_time),scenario_end_time); %creating mask to isolate period of charging so there values can be modified
modified_customer_loads = customer_base_loads_tt;%initializing the modified load table to the base load table

%% CREATING CHARGING SCNEARIO 

%constraining the duration to be less than 24 hours but greater than 0
while  (scenario_duration > 1440 || scenario_duration<0)
    scenario_duration = 5*round(duration_distribution.random()/5);
    if (scenario_duration < 1440 && scenario_duration>0)
        break
    else
        continue
    end
end

%constraining the start time to be less than 24 hours but greater than 0
%DISCLAIMER: THIS WORK DOES NOT CONSIDER SCENARIOS STARTING AT THE
%TRANSITION INTO THE NEXT DAY
while  (scenario_start_time > 1440 || scenario_start_time <0)
    scenario_start_time = 5*round(start_distribution.random()/5);
    if (scenario_start_time < 1440 && scenario_start_time >0)
        break
    else
        continue
    end
end

scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
charging_mask = timerange(minutes(scenario_start_time),scenario_end_time); %creating mask to isolate period of charging so there values can be modified

%%
num_timestamps = size(modified_customer_loads(charging_mask,customer_ID),1);
%disp("==================== Base Load Before (REDUCED TO AREA OF MASK) ====================")
%modified_customer_loads(charging_mask,customer_ID)


%% checking if customer is on a closed delta
customer_R_ID = "";
customer_B_ID = "";

if sum(ismember(closed_delta_customers,customer_ID)) >= 1

    %add 2/3 of the EV load to customer base load(on the system this is
    %the 2nd phase)
    disp("==================== WHITE PHASE BASE LOAD =============")
    customer_base_loads_tt{charging_mask,customer_ID}
    disp("==================== WHITE PHASE MODIFIED LOAD =============")
    modified_customer_loads{charging_mask,customer_ID} = modified_customer_loads{ ...
    charging_mask,customer_ID} + ones(num_timestamps,1)*(2/3)*charging_level;
    modified_customer_loads{charging_mask,customer_ID}

    %add 1/3 load to R, this is the 1st phase on the system
    customer_R_ID = append(customer_ID,"R"); %ID for customer R-Phase ID
    disp("==================== RED PHASE BASE LOAD =============")
    customer_base_loads_tt{charging_mask,customer_R_ID}

    modified_customer_loads{charging_mask,customer_R_ID} = modified_customer_loads{ ...
    charging_mask,customer_R_ID} + ones(num_timestamps,1)*(1/3)*charging_level;
    disp("==================== RED PHASE MODIFIED LOAD =============")
    modified_customer_loads{charging_mask,customer_R_ID}


    %add 1/3 load to B, this is the last phase on the system
    disp("==================== BLACK PHASE BASE LOAD =============")
    customer_B_ID = append(customer_ID,"B"); %ID for customer B-Phase ID
    customer_base_loads_tt{charging_mask,customer_B_ID}

    disp("==================== BLACK PHASE MODIFIED LOAD =============")
    modified_customer_loads{charging_mask,customer_B_ID} = modified_customer_loads{ ...
    charging_mask,customer_B_ID} + ones(num_timestamps,1)*(1/3)*charging_level;
    modified_customer_loads{charging_mask,customer_B_ID} 
else
    disp("Not a closed delta customer");
end


zeta_white_phase  = modified_customer_loads(:,customer_ID); %modified load of customer selected from scenario on the white phase
zeta_red_phase = modified_customer_loads(:,customer_R_ID); %modified load of customer selected from scenario on the red phase
zeta_black_phase = modified_customer_loads(:,customer_B_ID); %modified load of customer selected from scenario on the black phase
zeta_base = customer_base_loads_tt(:,customer_ID); %base load of customer selected from scenario 

zeta_red_phase = renamevars(zeta_red_phase,customer_R_ID,'Red Phase');
zeta_white_phase = renamevars(zeta_white_phase,customer_ID,'White Phase');
zeta_black_phase = renamevars(zeta_black_phase,customer_B_ID,'Black Phase');

zeta = join( zeta_base,zeta_red_phase);
zeta = join(zeta,zeta_white_phase);
zeta = join(zeta,zeta_black_phase);

zeta.Time.Format = 'hh:mm';

s = stackedplot(zeta)

title(append("Load Aggregation for Customer ID: ",customer_ID));
s.DisplayLabels=["Base Load/kW","Modified Red Phase/kW", ...
    "Modified White Phase/kW","Modified Black Phase/kW"];
s.FontSize = 12;
s.GridVisible = "on";




%plot graphs of the base load, then the modified load on te Red, White and
%Blue



% modified_cutils{charging_mask,[customer_ID]} = modified_cutils{charging_mask,[customer_ID]} + ones(num_timestamps,1)*charging_level;
% event_details = {customer_ID,scenario_clevel,minutes(sst),minutes(sp)};
% if sum(ismember(closed_delta_customers,customer_ID)) >= 1
%     %add 2/3 of the EV load to  customer base load
%     %customer ID is a string
%     modified_cutils{charging_mask,[customer_ID]} = modified_cutils{charging_mask,[customer_ID]} + ones(num_timestamps,1)*(charging_level*(2.0/3.0));
%     %add 1/3 load to R then 1/3 load to B
%     modified_cutils{charging_mask,[customer_ID]} = modified_cutils{charging_mask,[customer_ID]} + ones(num_timestamps,1)*(charging_level*(2.0/3.0));
% else
%     disp("No works");
% end
