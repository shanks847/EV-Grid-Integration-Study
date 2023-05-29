tf_list_path = "C:/Users/Shankar Ramharack/OneDrive - The University of the West Indies, St. Augustine/Desktop/EV-Grid-Integration-Study/data/load_statistical_analysis/customers_from_disaggregation.xlsx";


% Getting PVAR IDs
% Read the Excel file into a table
closed_deltas = ["P33","P53"];
white_phases_with_open_deltas = arrayfun(@(X) ['P', num2str(X)], 1:215, 'UniformOutput', false);

%generating a sampling base of 5 minute intervals spanning one day
collection_period = 0:5:1425;

%generate columns of zeros for each element of pvarIDs
flat_profiles = [];

%for each mutuable ID, generate some zeros
for i=1:numel(mutable_IDs)
    flat_profiles = [flat_profiles, {zeros(numel(collection_period),1)}];
end

% Initialize the lists for TF Power values without suffix and ending with "R"
mutable_ids = get_mutable_IDs(tf_list_path)
flat_base = timetable(minutes(collection_period(:)),flat_profiles{:},'VariableNames',mutable_ids')

%% TESTING ADDITION ONTO A REGULAR TRANSFORMER
%create some example masks

%Need to write code to generate an auxilary flat_base containing customers

%%

% %iterate through charging masks
% for x=1:numel(charging_masks)
%     %check which transformer the customer belongs to [CHECK IF THE HEADERS
%     %OF THE CHARGING MASKS ARE THE MODIFIED CUSTOMER STRING]
%     tf_ID = charging_masks{x}.Properties.VariableNames{1};
% 
%     %add to that column, need to know if is closed delta when adding. Only
%     %adding to open deltas and closed deltas.
% 
%     if tf_ID is in open deltas set  
%        add mask to flat profile
%     elseif tf_ID in closed deltas
%             share load to flat profile R,W and B based on their weightings
%     end
% 
%     NOTE THE NON-LIGHTING TRANSFORMER SHOULD REMAIN AT BASELOAD
%     flat_base{charging_masks{x}.Time, tf_ID} = flat_base{...
%         charging_masks{x}.Time, tf_ID} + charging_masks{x}{:,1}; 
% 
%     %need to make accomodations to generate flat profile
% end
