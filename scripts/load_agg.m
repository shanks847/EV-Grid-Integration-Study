%% Generate random samples of customers based on a penetration level

total_num_customers = 215;
opts = delimitedTextImportOptions("NumVariables", 507);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Time", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27", "P28", "P29", "P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37", "P38", "P39", "P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47", "P48", "P49", "P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57", "P58", "P59", "P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67", "P68", "P69", "P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77", "P78", "P79", "P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87", "P88", "P89", "P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97", "P98", "P99", "P100", "P101", "P102", "P103", "P104", "P105", "P106", "P107", "P108", "P109", "P110", "P111", "P112", "P113", "P114", "P115", "P116", "P117", "P118", "P119", "P120", "P121", "P122", "P123", "P124", "P125", "P126", "P127", "P128", "P129", "P130", "P131", "P132", "P133", "P134", "P135", "P136", "P137", "P138", "P139", "P140", "P141", "P142", "P143", "P144", "P145", "P146", "P147", "P148", "P149", "P150", "P151", "P152", "P153", "P154", "P155", "P156", "P157", "P158", "P159", "P160", "P161", "P162", "P163", "P164", "P165", "P166", "P167", "P168", "P169", "P170", "P171", "P172", "P173", "P174", "P175", "P176", "P177", "P178", "P179", "P180", "P181", "P182", "P183", "P184", "P185", "P186", "P187", "P188", "P189", "P190", "P191", "P192", "P193", "P194", "P195", "P196", "P197", "P198", "P199", "P200", "P201", "P202", "P203", "P204", "P205", "P206", "P207", "P208", "P209", "P210", "P211", "P212", "P213", "P214", "P215", "P10R", "P10B", "P25R", "P25B", "P33R", "P33B", "P34R", "P34B", "P43R", "P43B", "P53R", "P53B", "P54R", "P54B", "P63R", "P63B", "P64R", "P64B", "P65R", "P65B", "P73R", "P73B", "P115R", "P115B", "P163R", "P163B", "P182R", "P182B", "P198R", "P198B", "P202R", "P202B", "P207R", "P207B", "P212R", "P212B", "P215R", "P215B", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13", "Q14", "Q15", "Q16", "Q17", "Q18", "Q19", "Q20", "Q21", "Q22", "Q23", "Q24", "Q25", "Q26", "Q27", "Q28", "Q29", "Q30", "Q31", "Q32", "Q33", "Q34", "Q35", "Q36", "Q37", "Q38", "Q39", "Q40", "Q41", "Q42", "Q43", "Q44", "Q45", "Q46", "Q47", "Q48", "Q49", "Q50", "Q51", "Q52", "Q53", "Q54", "Q55", "Q56", "Q57", "Q58", "Q59", "Q60", "Q61", "Q62", "Q63", "Q64", "Q65", "Q66", "Q67", "Q68", "Q69", "Q70", "Q71", "Q72", "Q73", "Q74", "Q75", "Q76", "Q77", "Q78", "Q79", "Q80", "Q81", "Q82", "Q83", "Q84", "Q85", "Q86", "Q87", "Q88", "Q89", "Q90", "Q91", "Q92", "Q93", "Q94", "Q95", "Q96", "Q97", "Q98", "Q99", "Q100", "Q101", "Q102", "Q103", "Q104", "Q105", "Q106", "Q107", "Q108", "Q109", "Q110", "Q111", "Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120", "Q121", "Q122", "Q123", "Q124", "Q125", "Q126", "Q127", "Q128", "Q129", "Q130", "Q131", "Q132", "Q133", "Q134", "Q135", "Q136", "Q137", "Q138", "Q139", "Q140", "Q141", "Q142", "Q143", "Q144", "Q145", "Q146", "Q147", "Q148", "Q149", "Q150", "Q151", "Q152", "Q153", "Q154", "Q155", "Q156", "Q157", "Q158", "Q159", "Q160", "Q161", "Q162", "Q163", "Q164", "Q165", "Q166", "Q167", "Q168", "Q169", "Q170", "Q171", "Q172", "Q173", "Q174", "Q175", "Q176", "Q177", "Q178", "Q179", "Q180", "Q181", "Q182", "Q183", "Q184", "Q185", "Q186", "Q187", "Q188", "Q189", "Q190", "Q191", "Q192", "Q193", "Q194", "Q195", "Q196", "Q197", "Q198", "Q199", "Q200", "Q201", "Q202", "Q203", "Q204", "Q205", "Q206", "Q207", "Q208", "Q209", "Q210", "Q211", "Q212", "Q213", "Q214", "Q215", "Q10R", "Q10B", "Q25R", "Q25B", "Q33R", "Q33B", "Q34R", "Q34B", "Q43R", "Q43B", "Q53R", "Q53B", "Q54R", "Q54B", "Q63R", "Q63B", "Q64R", "Q64B", "Q65R", "Q65B", "Q73R", "Q73B", "Q115R", "Q115B", "Q163R", "Q163B", "Q182R", "Q182B", "Q198R", "Q198B", "Q202R", "Q202B", "Q207R", "Q207B", "Q212R", "Q212B", "Q215R", "Q215B"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Time", "InputFormat", "yyyy-MM-dd HH:mm:ss");

% Import the data
fullloaddatahres = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\full_load_data_hres.csv", opts);

customer_ids = opts.VariableNames;
customer_ids = customer_ids(2:length(customer_ids));
fullloaddatahres(1,:) = [] ;
clear opts
%fullloaddatahres = table2timetable(fullloaddatahres);
%fullloaddatahres.Time.Format = 'HH:mm'; %need to change all format in load_agg.m and base_load_aggregation.m to this
%fullloaddatahres(:,{'P33R'}) %NOTE: '(' and ')' return tables --- testing


customerutilizationhres = fullloaddatahres;


%% reformatting utilization in appropriate Data Structure

cutilhres_tstep = minutes(minutes(customerutilizationhres(2,1).Time - customerutilizationhres(1,1).Time)); %calculating the timestep based on the values of the table
power_data = customerutilizationhres(:,2:size(customerutilizationhres,2)); %isolating the power readings of the original table
cutilres_st = minutes(minute(customerutilizationhres(1, 1).Time)); %start time of the utilization data
cutilres_tt = table2timetable(power_data,'TimeStep',cutilhres_tstep,'StartTime',cutilres_st);


%% Specify distributions for level 1 start times and durations
level1_start_times = makedist("Normal",877.50,294.90);
level1_durations = makedist("GeneralizedPareto",'theta',-94.34,'sigma',114.34,'k',2.02);

%% Specify distributions for level 2 start times and durations
level2_start_times = makedist("Normal",916.60,302.02);
level2_durations = makedist("GeneralizedPareto",'theta',16.92,'sigma',3.08,'k',0.55);

%% GENERATING PEN. LEVEL = x% SCENARIO

%specifying penetration level
pen_level = 0.15;
num_ev_customers = ceil(pen_level*total_num_customers);

%specifying random customers that have EVs based on penetration level
ev_customer_IDs = randsample(total_num_customers,num_ev_customers);


%CONTROLS LEVEL CHOSEN FOR CHARGING SCENARIO
customer_charging_levels = randi(2,1,num_ev_customers);
%customer_charging_levels = ones(1,num_ev_customers);
%customer_charging_levels = ones(1,num_ev_customers)*2;  
scenario_data = table(ev_customer_IDs,customer_charging_levels', ...
    'VariableNames',["Customer ID","Charging Level"]);

modified_cutils = cutilres_tt;
start_distribution = 0;
duration_distribution = 0;
customer_ID = "0";
init_data = {"PX",0,minutes(0),minutes(0)};
scenario_details = cell2table(init_data,"VariableNames",["Customer ID","Charging Level", ...
    "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);

closed_delta_customers = [33,53,115,182,198,202,207]; %write code to find this in the base data automatically
%%
for i=1:size(scenario_data,1)
    customer_ID = append('P',int2str(ev_customer_IDs(1)));
    scenario_clevel = scenario_data{i,2};
    if scenario_clevel == 1
        start_distribution = level1_start_times;
        duration_distribution = level1_durations;
    else
        start_distribution = level2_start_times;
        duration_distribution = level2_durations;
    end
    
    [event_details, modified_cutils] = base_load_aggregation(start_distribution, ...
        duration_distribution,scenario_clevel,customer_ID,modified_cutils, closed_delta_customers);
    if i == 1
        scenario_details = cell2table(event_details,"VariableNames",["Customer ID","Charging Level", ...
    "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);
    else
        scenario_details = [scenario_details; event_details];
    end
end
%% 

scenario_details.("Customer ID") = string(scenario_details.("Customer ID"));
scenario_details.Properties.VariableNames(3) = "Start Time(HH:MM)";
scenario_details.("Start Time(HH:MM)").Format = 'hh:mm';
scenario_details.Properties.VariableNames(4) = "Duration(HH:MM)";
scenario_details.("Duration(HH:MM)").Format = 'hh:mm';
scenario_details

%% PLOTTING A CUSTOMER'S LOAD PROFILE BEFORE AND AFTER AGGREGATION
test_idx = append('P',int2str(ev_customer_IDs(1)));
zeta_mod  = modified_cutils(:,test_idx); %modified load of customer selected from scenario
zeta_base = cutilres_tt(:,test_idx); %base load of customer selected from scenario

zeta_ce = 0; %charging event of customer selected from scenario
zeta_mod = renamevars(zeta_mod,test_idx,'Modified');
zeta = join(zeta_mod, zeta_base);
zeta.Time.Format = 'hh:mm';
%zeta = renamevars(zeta,'Var2','Base');
s = stackedplot(zeta)
title(append("Load Aggregation for Customer ID: ",int2str(ev_customer_IDs(1))));
s.DisplayLabels=["Modified Load/kW","Base Load/kW"];
s.FontSize = 12;
s.GridVisible = "on";


%% Generating CSVs for EMTP Simulation
modified_cutils.Time.Format = 'hh:mm';
% writetimetable(modified_cutils, '../data/scenarios/balanced_load/modified_loads/mload_level_1_pen_lvl_10.csv')
% writetable(scenario_details,'../data/scenarios/balanced_load/scenario_details/sdets_level_1_pen_lvl_10.csv')

writetimetable(modified_cutils, '../data/scenarios/balanced_load/modified_loads/mload_charging_level_mixed_pen_lvl_15.csv')
writetable(scenario_details,'../data/scenarios/balanced_load/scenario_details/sdets_charging_level_mixed_pen_lvl_15.csv')
%% ==========================   TESTING ============================================
% 
% 
% 
% 
% 
% 
% 
%               NO
% 
% 
% 
%       MAN'S
% 
% 
% 
% 
%                     LAND
% 
% 
% 
%       :) 
% 
% 





%% TESTING - [PENDING] Base Load Aggregation with modified customer_ID dtype

%using full dataset from above as the base load
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

test_cutilhres_tstep = minutes(minutes(customerutilizationhres(2,1).Time - customerutilizationhres(1,1).Time)); %calculating the timestep based on the values of the table
test_power_data = customerutilizationhres(:,2:size(customerutilizationhres,2)); %isolating the power readings of the original table
%cutilres_st = minutes(minute(customerutilizationhres(1, 1).Time)); %start time of the utilization data
test_cutilres_tt = table2timetable(power_data,'TimeStep',cutilhres_tstep,'StartTime',cutilres_st);

%%

%Specify distributions for level 2 start times and durations
level2_start_times = makedist("Normal",916.60,302.02);
level2_durations = makedist("GeneralizedPareto",'theta',16.92, ...
    'sigma',3.08,'k',0.55);

%choosing level 2 for the test scenario
start_distribution = level2_start_times;
duration_distribution = level2_durations;

%declaing the charging level for the scenario to be generated
scenario_clevel = 2;

%% 
%test customer(NOT ON CLOSED DELTA)
tcust_ID = "P110";


%customer_base_loads_ttbl = table2timetable(customer_base_loads);
[event_results,modified_base_load] = base_load_aggregation( ...
    start_distribution,duration_distribution, ...
    scenario_clevel, tcust_ID, test_cutilres_tt, ...
    closed_delta_customers);

%% TESTING - [PENDING] Base Load Aggregation with close delta customer
