clear all
clc

charging_events_path = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\misc\charging_events.mat";
pen20_data = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\misc\pen20data.mat";
data_path = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\misc\lookup_tables.mat";

newData1 = load('-mat', pen20_data);

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end


%% Creating a list of start times and durations for each level
max_pen_lvl = 0.2;
max_customers = 2400;
num_of_customers = max_customers * max_pen_lvl;
mixed_idxs =  newData1.scenario_details.("Charging Level");

%Arrays to hold timestamps at start of charging
start_timestamps_level_1 = [];
start_timestamps_level_2 = [];
start_timestamps_level_mix = [];

%Arrays to hold duration of charging
duration_timestamps_level_1 = [];
duration_timestamps_level_2 = [];
duration_timestamps_mix = [];




%% Populating start and duration time collections

%poulatuing start time and duration lists for each level but discard the mask
%since it can't be stored
[tmp_cmask,tmp_st,tmp_dur] = generate_charging_mask(1,charging_events_path);
for x=1:num_of_customers
    [tmp_l1_cmask,tmp_l1_st,tmp_l1_dur] = generate_charging_mask(1, ...
        charging_events_path);
    [tmp_l2_cmask,tmp_l2_st,tmp_l2_dur] = generate_charging_mask(2, ...
        charging_events_path);
    [tmp_mix_cmask,tmp_mix_st,tmp_mix_dur] = generate_charging_mask(mixed_idxs(x),charging_events_path);


    start_timestamps_level_1 = [start_timestamps_level_1, tmp_l1_st];
    start_timestamps_level_2 = [start_timestamps_level_2, tmp_l2_st];
    start_timestamps_level_mix = [start_timestamps_level_mix, tmp_mix_st];


    duration_timestamps_level_1 = [duration_timestamps_level_1, tmp_l1_dur];
    duration_timestamps_level_2 = [duration_timestamps_level_2, tmp_l2_dur];
    duration_timestamps_mix = [duration_timestamps_mix, tmp_mix_dur];
end


% start_times = table(start_timestamps_level_1',start_timestamps_level_2', ...
%     start_timestamps_level_mix','VariableNames',["Level 1 Start Times", ...
%     "Level 2 Start Times", "Mixed Start Times"]);
% 
% durations = table(duration_timestamps_level_1',duration_timestamps_level_2', ...
%     duration_timestamps_mix','VariableNames',["Level 1 Durations", ...
%     "Level 2 Durations","Mixed Durations"]);


save(data_path,'-mat')

%% Create basecode for a function that can use LUT for generating charging event
% INPUTS - charging_level, index_of_customer, pen_level