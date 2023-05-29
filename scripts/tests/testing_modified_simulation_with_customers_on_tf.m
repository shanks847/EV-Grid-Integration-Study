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


cmask1_data = randi([10,20],numel(cmask1_time_rng), 1);
cmask2_data = randi([10,20],numel(cmask2_time_rng), 1);
cmask3_data = randi([10,20],numel(cmask3_time_rng), 1);
cmask4_data = randi([10,20],numel(cmask4_time_rng), 1);
base_series_data = zeros(numel(base_series_rng),1);

cmask1_timetable = timetable(minutes(cmask1_time_rng(:)), cmask1_data);
cmask2_timetable = timetable(minutes(cmask2_time_rng(:)), cmask2_data);
cmask3_timetable = timetable(minutes(cmask3_time_rng(:)), cmask3_data);
cmask4_timetable = timetable(minutes(cmask4_time_rng(:)), cmask4_data);
base_series_timetable = timetable(minutes(base_series_rng(:)), base_series_data);
cmasks = {cmask1_timetable,cmask2_timetable,cmask3_timetable};
cmasks = [cmasks,{cmask4_timetable}]

%% Addding sample masks to base series - TEST PASSED
base_series_timetable{cmask4_timetable.Time,"base_series_data"} = base_series_timetable{cmask4_timetable.Time,"base_series_data"} + cmask4_timetable{:,1} 

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
num_feeder_customers = 6; %num of TFs on feeder supplying customer(s)
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

%Initialize a timetable with all zeros for each feeder customer. This
%should include closed delta cases as all R and B customers will be lumped
%onto PX_R & PX_B

num_tfs = num_feeder_customers; 
time_rng = 0:5:1425; 
P1 = zeros(numel(time_rng),1);
P2 = zeros(numel(time_rng),1);
P3 = zeros(numel(time_rng),1);
P4 = zeros(numel(time_rng),1);
P5 = zeros(numel(time_rng),1);
P6 = zeros(numel(time_rng),1);
tmpy = timetable(minutes(time_rng(:)),P1,P2,P3,P4,P5,P6);
%% Testing charging event generation
%
% tmpx = generate_charging_mask(1);
%TODO Find a better way to use relative paths when handling data

tf_list_path = "C:/Users/Shankar Ramharack/OneDrive - The University of the West Indies, St. Augustine/Desktop/EV-Grid-Integration-Study/data/load_statistical_analysis/customers_from_disaggregation.xlsx"


% Read the Excel file into a table with preserved headers
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

%% Set up the Import Options and import the data
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

% Import the data
base_loads = readtable("C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\balanced loads\balanced_eba_hres.csv", opts);
customer_IDs = opts.VariableNames(2:end)
clear opts
%% TESTING GENERATING CHARGING MASKS
generate_charging_mask(1)



%%
%create a timetable covering 1 day.

%generate columns of zeros for each element of pvarIDs

%iterate through charging masks
for x=1:numel(charging_masks)
    %check which transformer the customer belongs to
    tf_ID = charging_masks{x}.Properties.VariableNames{1};

    %add to that column
    flat_base{charging_masks{x}.Time, tf_ID} = flat_base{...
        charging_masks{x}.Time, tf_ID} + charging_masks{x}{:,1}; 
end
