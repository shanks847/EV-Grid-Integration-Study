function plot_load_agg_overlay(base_load, modified_load,customer_ID,charging_mask)

customer_info_split = strsplit(customer_ID, 'C');
tf_ID = customer_info_split(1);
CID = customer_info_split(2);

modified_load = renamevars(modified_load,modified_load.Properties.VariableNames, ...
    base_load.Properties.VariableNames);

stackedplot(base_load{charging_mask,tf_ID},modified_load{charging_mask, ...
    tf_ID},"CombineMatchingNames",true)

end