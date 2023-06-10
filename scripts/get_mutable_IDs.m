function [mutable_IDs] = get_mutable_IDs(tf_list_path)
%GET_MUTABLE_IDs Generate IDs exclusive of non-lighting transformers and
%R,B phases of the closed deltas

% Read the Excel file into a table with preserved headers
data = readtable(tf_list_path, 'Sheet', 1, 'VariableNamingRule', 'preserve');

% Get the column index of "TF Power" and "Loading"
tfPowerColIndex = find(strcmp(data.Properties.VariableNames, 'TF Power'));
loadingColIndex = find(strcmp(data.Properties.VariableNames, 'Loading'));

% Initialize the lists for TF Power values without suffix and ending with "R"
mutable_IDs = {};


% Iterate over the rows and check the Loading column
for i = 1:215
    loadingValue = data{i, loadingColIndex};
    
    % Check if the Loading value is nonzero
    if loadingValue ~= 0
        tfPowerValue = data{i, tfPowerColIndex};
        mutable_IDs = [mutable_IDs; tfPowerValue];
     end
end


end