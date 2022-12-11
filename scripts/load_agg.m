%% Generate random samples of customers based on a penetration level
total_num_customers = 220; %this can be altered for future studies

%specifying penetration level
pen_level = 0.1;
num_ev_customers = ceil(pen_level*total_num_customers);

%specifying random customers that have EVs based on penetration level
ev_customer_IDs = randsample(total_num_customers,num_ev_customers);
%level of charging is a uniform distribution, each customer is assigned a
%particular level of charging
customer_charging_levels = randi(2,1,num_ev_customers);

%% Importing downsampled customer load

opts = delimitedTextImportOptions("NumVariables", 221);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Time", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27", "P28", "P29", "P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37", "P38", "P39", "P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47", "P48", "P49", "P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57", "P58", "P59", "P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67", "P68", "P69", "P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77", "P78", "P79", "P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87", "P88", "P89", "P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97", "P98", "P99", "P100", "P101", "P102", "P103", "P104", "P105", "P106", "P107", "P108", "P109", "P110", "P111", "P112", "P113", "P114", "P115", "P116", "P117", "P118", "P119", "P120", "P121", "P122", "P123", "P124", "P125", "P126", "P127", "P128", "P129", "P130", "P131", "P132", "P133", "P134", "P135", "P136", "P137", "P138", "P139", "P140", "P141", "P142", "P143", "P144", "P145", "P146", "P147", "P148", "P149", "P150", "P151", "P152", "P153", "P154", "P155", "P156", "P157", "P158", "P159", "P160", "P161", "P162", "P163", "P164", "P165", "P166", "P167", "P168", "P169", "P170", "P171", "P172", "P173", "P174", "P175", "P176", "P177", "P178", "P179", "P180", "P181", "P182", "P183", "P184", "P185", "P186", "P187", "P188", "P189", "P190", "P191", "P192", "P193", "P194", "P195", "P196", "P197", "P198", "P199", "P200", "P201", "P202", "P203", "P204", "P205", "P206", "P207", "P208", "P209", "P210", "P211", "P212", "P213", "P214", "P215", "P216", "P217", "P218", "P219", "P220"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Time", "InputFormat", "yyyy-MM-dd HH:mm:ss");

% Import the data
customerutilizationhres = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\customer_utilization_hres.csv", opts);

clear opts
%% reformattig utilization in appropriate Data Structure

cutilhres_tstep = minutes(minutes(customerutilizationhres(2,1).Time - customerutilizationhres(1,1).Time)); %calculating the timestep based on the values of the table
power_data = customerutilizationhres(:,2:size(customerutilizationhres,2)); %isolating the power readings of the original table
cutilres_st = minutes(minute(customerutilizationhres(1, 1).Time)); %start time of the utilization data
%cutilhres_tt = timetable(power_data,'TimeStep',cutilhres_tstep,'StartTime',customerutilizationhres(1,1).Time); %creating a timetable based on the power data and start time
cutilres_tt = table2timetable(power_data,'TimeStep',cutilhres_tstep,'StartTime',cutilres_st);

%NOTE, for post processing, I can use the below to obtain a timestamp
%>> cutilres_tt(2,1).Time.Format
%>> cutilres_tt(2,1).Time.Format = 'hh:mm'


%% Specify distributions for level 1 start times and durations
level1_start_times = makedist("Normal",877.50,294.90);
level1_durations = makedist("GeneralizedPareto",'theta',-94.34,'sigma',114.34,'k',2.02);

%% Specify distributions for level 2 start times and durations
level2_start_times = makedist("Normal",916.60,302.02);
level2_durations = makedist("GeneralizedPareto",'theta',16.92,'sigma',3.08,'k',0.55);
%% [ ! ] Modifyig base loads for a scenario of EV Customers

scenario_data = table(ev_customer_IDs,customer_charging_levels', ...
    'VariableNames',["Customer ID","Charging Level"]);

modified_cutils = cutilres_tt;
start_distribution = 0;
duration_distribution = 0;
customer_ID = 0;
init_data = {"PX",0,minutes(0),minutes(0)};
scenario_details = cell2table(init_data,"VariableNames",["Customer ID","Charging Level", ...
    "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);

for i=1:size(scenario_data,1)
    customer_ID = scenario_data{i,1};
    scenario_clevel = scenario_data{i,2};
    if scenario_clevel == 1
        start_distribution = level1_start_times;
        duration_distribution = level1_durations;
    else
        start_distribution = level2_start_times;
        duration_distribution = level2_durations;
    end
    
    [event_details, modified_cutils] = base_load_aggregation(start_distribution, ...
        duration_distribution,scenario_clevel,customer_ID,modified_cutils);
    if i == 1
        scenario_details = cell2table(event_details,"VariableNames",["Customer ID","Charging Level", ...
    "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);
    else
        scenario_details = [scenario_details; event_details];
    end
end


scenario_details.("Customer ID") = string(scenario_details.("Customer ID"));
scenario_details.("Start Time(Minutes from 00:00 AM)")
scenario_details








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
%% Testing SINGLE CUSTOMER BASE LOAD AGGREGATION

%mask charging profile
tstep = cutilhres_tstep;
test_tt = timetable(tdata','TimeStep',tstep,'StartTime',minutes(400)); %creating a timetable of the baseload
tr = timerange(minutes(405),minutes(415));
test_tt(tr,:).Var1 = test_tt(tr,:).Var1 + [1;1] %testing to see if I can modify rows of data based on mask

%making a copy of base load test data
test_bload = bltt

%make a charging scenario
scenario_end_time = minutes(scenario_start_times(1)) + minutes(scenario_durations(1));
charging_mask = timerange(minutes(scenario_start_times(1)),scenario_end_time);

%import base load
num_timestamps = length(test_bload(charging_mask,:).Var1);
disp("==================== Base Load Before (REDUCED TO AREA OF MASK) ====================")
test_bload(charging_mask,:).Var1
test_bload(charging_mask,:).Var1 = test_bload(charging_mask,:).Var1 + ones(num_timestamps,1)*1.920;
disp("==================== Base Load After (REDUCED TO AREA OF MASK) ====================")
test_bload(charging_mask,:).Var1




%% Testing single customer base load aggregation from full db



%specifying charging level based on generated scenario for customer
charging_level = 1.92;
% if customer_charging_levels(customer_ID) == 1
%     charging_level = 1.92;
% else
%     charging_level = 6.6;
% end

start_distribution = level1_start_times; %testing at lev 1
duration_distribution = level1_durations; %testing at lev 1
customer_ID = 2;

cutilres_cpy = cutilres_tt;

%make a charging scenario
sst = 5*round(start_distribution.random()/5); %generating scenario start time from start time distribution
sp = 5*round(duration_distribution.random()/5); %generating scenario duration from duration distribution
scenario_end_time = minutes(sst) + minutes(sp);
%rounding minutes to multiples of 5 to improve stability
charging_mask = timerange(minutes(sst),scenario_end_time); %creating mask to isolate period of charging so there values can be modified

%import base load
num_timestamps = size(cutilres_cpy(charging_mask,customer_ID),1);
% disp("==================== Base Load Before (REDUCED TO AREA OF MASK) ====================")
% cutilres_cpy(charging_mask,customer_ID)
cutilres_cpy{charging_mask,[customer_ID]} = cutilres_cpy{charging_mask,[customer_ID]} + ones(num_timestamps,1)*charging_level;
% disp("==================== Base Load After (REDUCED TO AREA OF MASK) ====================")
% cutilres_cpy(charging_mask,customer_ID)


%% Testing base_load_aggregation function

cutilres_fcpy = cutilres_tt;
mod_load = base_load_aggregation(level1_start_times,level1_durations, ...
    2, 1, cutilres_fcpy);


%% NOMAN'S LAND

%empty_table = table('Customer ID','Charging Level','Start Time', 'Duration')

cidca = []; %customer ID cell array
lca = []; %charging level cell array
stca = timetable(); %start time cell array
dtca = timetable(); %duration cell array

% cidca(1) = "P1";
% lca(1) = 1;
% stca(1,1) = {minutes(sst)};
% dtca(1,1) = {minutes(sp)};

sca = {'P1',1,minutes(sst),minutes(sp)}; %scenario details table
sct = cell2table(sca,"VariableNames",["Customer ID","Charging Level", ...
    "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);
scb = {'P2',1,minutes(sst),minutes(sp)};
sct = [sct;scb];
sct.("Customer ID") = string(sct.("Customer ID"));

sct = cell2table({'PX',0,minutes(0),minutes(0)},"VariableNames",["Customer ID","Charging Level", ...
    "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);

% approach2_sct = table(cidca,lca,stca,dtca)

% scenario_details = table(cidca,lca, ...
%     stca,dtca, ...
%     'VariableNames',["Customer ID","Charging Level", ...
%     "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);