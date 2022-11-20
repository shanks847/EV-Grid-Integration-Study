
%% Assigning dummy data for testing

start = 690; %dummy data - 11:30 PM
duration = 40; % 40 minutes of charging


%% Importing Downsampled Load Data - Downsampling done in python
% See <incl filename>
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Time", "Var2", "PAvgSingleCustomer", "Var4"];
opts.SelectedVariableNames = ["Time", "PAvgSingleCustomer"];
opts.VariableTypes = ["datetime", "string", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var4"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var4"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Time", "InputFormat", "yyyy-MM-dd HH:mm:ss");

% Import the data
downsampledcbl = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\downsampled_cbl.csv", opts);
downsampledcbl(1,:) = []
clear opts
idx = 1:286
downsampledcbl = addvars(downsampledcbl,idx')
downsampledcbl = renamevars(downsampledcbl,'Var3','Index')
%% Testing Base Load Aggregation

base_load = downsampledcbl; %test base load data
charging_level = 1; %test charing level

%determining charging index start
start_idx = ceilDiv(start,5);
dur = ceilDiv(duration,5);

if charging_level == 1
    charger_power = 1920/1000;
else
    charger_power = 6600/1000;
end

for row=start_idx:(dur+start_idx)
    %disp('\nBEFORE BLAGG:')
    %base_load(row,:).PAvgSingleCustomer
    %base_load(row,["PAvgSingleCustomer","Index"])
    base_load(row,:).PAvgSingleCustomer = base_load(row,:).PAvgSingleCustomer + charger_power;
    %disp('\nAFTER BLAGG:')
    %base_load(row,:).PAvgSingleCustomer
end
%% Disaggregating Load into hourly utilization profile
P_profs = zeros(1,24);
%this will be refined down into a function later
for i=0:23
    if i == 0 
        P_profs(1,1) = base_load(1,:).PAvgSingleCustomer;
    elseif i==23
        P_profs(1,24) = base_load(height(base_load)-9,:).PAvgSingleCustomer;
    else
        P_profs(1,i+1) = base_load(( ((i)*(12))+1 ),:).PAvgSingleCustomer;
    end
end
%% Generate random samples of customers based on a penetration level
total_num_customers = 220; %this can be altered for future studies

%specifying penetration level
pen_level = 0.1;
num_ev_customers = pen_level*length(total_customers);

%specifying random customers that have EVs based on penetration level
ev_customer_IDs = randsample(total_num_customers,num_ev_customers);

%level of charging is a uniform distribution, each customer is assigned a
%particular level of charging
customer_charging_levels = randi(2,1,num_ev_customers);


%% Import base loads for all customers

%[!]NOTE : THIS ASSUMES there exists a column of data for each in
%total_num_customers

opts = delimitedTextImportOptions("NumVariables", num_ev_customers+1);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

var_names = ["Time"];
var_types = ["datetime"];
%creating a list
for i=1:total_num_customers
    var_names = horzcat(var_names,strcat("P",string(i)));
    var_types = horzcat(var_types,"double");
end

% Specify column names and types
opts.VariableNames = var_names;
opts.VariableTypes = var_types;

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Time", "InputFormat", "yyyy-MM-dd HH:mm:ss");

% Import the data
customerutilizationxformed = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\customer_utilization_xformed.csv", opts);
clear opts

%% Specify distributions for level 1 start times and durations
level1_start_times = makedist("Normal",877.50,294.90);
level1_durations = makedist("GeneralizedPareto",'theta',-94.34,'sigma',114.34,'k',2.02);

%% Specify distributions for level 2 start times and durations
level2_start_times = makedist("Normal",916.60,302.02);
level2_durations = makedist("GeneralizedPareto",'theta',16.92,'sigma',3.08,'k',0.55);
%% Generate a matrix showing EV Customers and their charging events
%generating a matrix of customer IDs, level IDs, starting time, duration
scenario_start_times = zeros(num_ev_customers,1);
scenario_durations = zeros(num_ev_customers,1);

for i=1:num_ev_customers
    if customer_charging_levels(i) == 1
        scenario_start_times(i) = level1_start_times.random();
        scenario_durations(i) = level1_durations.random();
        while scenario_durations(i) < 0
            scenario_durations(i) = level1_durations.random();
        end
    else
        scenario_start_times(i) = level2_start_times.random();
        scenario_durations(i) = level2_durations.random();
        while scenario_durations(i) < 0
            scenario_durations(i) = level2_durations.random();
        end
    end
end

scenario_data = table(ev_customer_IDs,customer_charging_levels', ...
    scenario_start_times,scenario_durations, ...
    'VariableNames',["Customer ID","Charging Level", ...
    "Start Time(Minutes from 00:00 AM)","Duration(Minutes)"]);
%% Modify Base Loads of selected Customers

%% Generate new CSV containing modified base loads with other residential loads

%% Testing 

