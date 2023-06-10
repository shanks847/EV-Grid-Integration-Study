function [modified_customer_IDs,CD_TF_RBs,CD_TFC_RBs] = get_modified_customer_ID(tf_details_filepath,closed_deltas)
%declaring variable to hold prefixed IDs
modified_customer_IDs = [];
CD_TFC_RBs = []; %close delta customer level variables, eg. P115RC2
CD_TF_RBs = []; %closed delta transformer level variables eg. P115R

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

%changing to give R and B ids for closed delta customers

%iterate through transformer detail
for x=1:215
    %grab transformer power variable ID, this is the parent TF ID
    tf_P_ID = tf_descs{x,"TFPowerID"};

    if tf_descs{x,"Loading"} == 1
        %generate prefixed strings using parent tf ID
        if sum(ismember(closed_deltas,tf_P_ID)) >=1
            tf_P_ID_R = append(tf_P_ID,"R");
            tf_P_ID_B = append(tf_P_ID,"B");
            CD_TF_RBs = [CD_TF_RBs,tf_P_ID_R];
            CD_TF_RBs = [CD_TF_RBs,tf_P_ID_B];
        end
        for i=1:tf_descs{:,"NumberOfCustomers"}
            if sum(ismember(closed_deltas,tf_P_ID)) >=1
                customer_w = append(append(tf_P_ID,"C"),num2str(i));
                customer_r = append(append(tf_P_ID,"RC"),num2str(i));
                customer_b = append(append(tf_P_ID,"BC"),num2str(i));
                modified_customer_IDs = [modified_customer_IDs,customer_w];

                CD_TFC_RBs = [CD_TFC_RBs,customer_r];
                CD_TFC_RBs = [CD_TFC_RBs,customer_b];

                CD_TF_RBs = [CD_TF_RBs,customer_r];
                CD_TF_RBs = [CD_TF_RBs,customer_b];
            else
                %creating prefixed string for the ith cutomer
                customer_w = append(append(tf_P_ID,"C"),num2str(i));
                %appending to tf_customer list
                modified_customer_IDs = [modified_customer_IDs,customer_w];
            end
        end
    end
end