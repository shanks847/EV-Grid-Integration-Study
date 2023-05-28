% Create a timetable with three variables: P1, P2, and P3
timeRange = 0:1425;
timetableData = table('Size', [numel(timeRange), 3], 'VariableTypes', {'double', 'double', 'double'}, 'VariableNames', {'P1', 'P2', 'P3'});

% Generate random values for each variable
TF.P1 = randi([12, 15], numel(timeRange), 1); %load data for transformer 1
TF.P2 = randi([12, 15], numel(timeRange), 1); %load data for transformer 2
TF.P3 = randi([12, 15], numel(timeRange), 1); %load data for transformer 3

% Create a timetable object
timetableObject = timetable(minutes(timeRange(:)), timetableData);

% Display the timetable
disp(timetableObject);
%% Generating sample masks
cmask1_time_rng = 0:5:15;
cmask2_time_rng = 5:5:15;
cmask3_time_rng = 15:5:20;
cmask4_time_rng = 25:5:30;
base_series_rng = 0:5:1425;


cmask1_data = randi([10,20],numel(cmask1_time_rng), 1)
cmask2_data = randi([10,20],numel(cmask2_time_rng), 1)
cmask3_data = randi([10,20],numel(cmask3_time_rng), 1)
cmask4_data = randi([10,20],numel(cmask4_time_rng), 1)
base_series_data = zeros(numel(base_series_rng),1)

cmask1_timetable = timetable(minutes(cmask1_time_rng(:)), cmask1_data)
cmask2_timetable = timetable(minutes(cmask2_time_rng(:)), cmask2_data)
cmask3_timetable = timetable(minutes(cmask3_time_rng(:)), cmask3_data)
cmask4_timetable = timetable(minutes(cmask4_time_rng(:)), cmask4_data)
base_series_timetable = timetable(minutes(base_series_rng(:)), base_series_data)

%% Addding sample masks to base series - TEST PASSED
base_series_timetable{minutes(cmask4_time_rng),"base_series_data"} = base_series_timetable{minutes(cmask4_time_rng),"base_series_data"} + cmask4_timetable{:,1} 

%% Sampling new customer IDs - TEST PASSED

opts = spreadsheetImportOptions("NumVariables", 4);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:D7";

% Specify column names and types
opts.VariableNames = ["TFPowerID", "TFCapacity", "NumberOfCustomers", "Loading"];
opts.VariableTypes = ["string", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "TFPowerID", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "TFPowerID", "EmptyFieldRule", "auto");

% Import the data
tf_descs = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\dummy_data\transformer_customer_detail.xlsx", opts, "UseExcel", false);

% Clear temporary variables
clear opts

customers_with_tf_prefix = get_modified_customer_ID(tf_descs);

% Define the number of samples you want to draw
num_feeder_customers = 6;
penetration_level = 0.25;
num_ev_customers = round(penetration_level*num_feeder_customers);
numSamples = num_ev_customers;

% Generate random indices
randomIndices = randperm(numel(customers_with_tf_prefix), numSamples);

% Sample from the string array using the random indices
ev_customer_IDs = customers_with_tf_prefix(randomIndices);

% Display the sampled strings
disp(ev_customer_IDs);

%% Modifying Base Loads using Disaggregated Customer Profiles and Modified Indicies


