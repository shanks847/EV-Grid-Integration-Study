%based on charger level, load approp lookup tables
clc

chargers_being_used = "1";
data_path = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\misc\lookup_tables.mat";
lut_path = data_path;
%idx=18; %no overflow
idx=10; %overflow present

if chargers_being_used == "1"
    start_times = load(lut_path,"start_timestamps_level_1");
    durations = load(lut_path, "duration_timestamps_level_1");

    start_times = start_times.start_timestamps_level_1;
    durations = durations.duration_timestamps_level_1;
elseif chargers_being_used == "2"
    
    start_times = load(lut_path,"start_timestamps_level_2");
    durations = load(lut_path, "duration_timestamps_level_2");

    start_times = start_times.start_timestamps_level_2;
    durations = durations.duration_timestamps_level_2;

else
    start_times = load(lut_path,"start_timestamps_level_mix");
    durations = load(lut_path, "duration_timestamps_mix");

    start_times = start_times.start_timestamps_level_mix;
    durations = durations.duration_timestamps_mix;
end

% start_times
scenario_start_time = start_times(idx);
scenario_duration = durations(idx);


%generate scn event details based on index and charger level
%scenario_end_time = scenario_start_time + scenario_duration;
%charging_mask = timerange(scenario_start_time,scenario_end_time,'closed'); %make a charging scenario, rounding minutes to multiples of 5 to improve stability


%scenario_start_time = minutes(scenario_start_time);
%scenario_duration = minutes(scenario_duration);


scenario_start_time.Format = 'hh:mm';
scenario_duration.Format = 'hh:mm';


%splitting overflow to the front of the profile
end_of_day = minutes(1440);
start_of_day = minutes(0);
end_of_day.Format = 'hh:mm';
start_of_day.Format = 'hh:mm';

time_left = end_of_day - scenario_start_time;

if time_left < scenario_duration
    pre_overflow_mask = timerange(scenario_start_time,end_of_day,'closed')
    overflow = start_of_day + (scenario_duration - time_left);
    post_overflow_mask = timerange(start_of_day,overflow,'closed')

else
    scenario_end_time = scenario_start_time + scenario_duration
    pre_overflow_mask = timerange(scenario_start_time,scenario_end_time,'closed')
end

