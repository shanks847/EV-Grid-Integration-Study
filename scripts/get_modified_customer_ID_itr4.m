function [modified_customer_IDs] = get_modified_customer_ID_itr4(tf_details_filepath)
%declaring variable to hold prefixed IDs
modified_customer_IDs = [];
opts = spreadsheetImportOptions("NumVariables", 4);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:D254";

% Specify column names and types
opts.VariableNames = ["TFPowerID", "TFCapacity", "NumberOfCustomers", "Loading"];
opts.VariableTypes = ["string", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "TFPowerID", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "TFPowerID", "EmptyFieldRule", "auto");
% Import the data
tf_descs = readtable(tf_details_filepath, opts, "UseExcel", false);


%% Clear temporary variables
clear opts

%iterate through transformer detail
for x=1:size(tf_descs,1)
    %grab transformer power variable ID, this is the parent TF ID
    tf_P_ID = tf_descs{x,"TFPowerID"};

    if tf_descs{x,"Loading"} == 1
        %generate prefixed strings using parent tf ID
        for i=1:tf_descs{:,"NumberOfCustomers"}
            
            %creating prefixed string for the ith cutomer
            customer_i = append(append(tf_P_ID,"C"),num2str(i));
    
            %appending to tf_customer list
            modified_customer_IDs = [modified_customer_IDs,customer_i];
    
        end
    end
end
end