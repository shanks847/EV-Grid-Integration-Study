function plot_load_agg_overlay(base_load, modified_load,CID,charging_mask)

% customer_info_split = strsplit(customer_ID, 'C');
% tf_ID = customer_info_split(1);
% CID = customer_info_split(2);

%modified_load = renamevars(modified_load,,);

stackedplot(base_load{charging_mask,CID},modified_load{charging_mask, ...
    CID},"CombineMatchingNames",true)

end