function [modified_customer_IDs] = get_modified_customer_ID(tf_descs)
%declaring variable to hold prefixed IDs
modified_customer_IDs = [];

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