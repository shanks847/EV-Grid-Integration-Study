%% Testing flat base generation
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
        mutable_IDs = [mutable_IDs, tfPowerValue];
     end
end

flat_profiles = []

timerange = 0:5:1425

%for each mutuable ID, generate some zeros
for i=1:numel(mutable_IDs)
    flat_profiles = [flat_profiles, {zeros(numel(timerange),1)}];
end

%varnames = ['Time',mutable_IDs]

flat_base_load = timetable(minutes(timerange(:)),flat_profiles{:}, ...
    'VariableNames',mutable_IDs')
