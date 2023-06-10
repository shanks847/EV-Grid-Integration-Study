function [charging_mask,scenario_start_time,scenario_duration] = generate_charging_mask_lut_approach(chargers_being_used,lut_path,idx)
%GENERATE_CHARGING_MASK creates a charging mask for the specified level
%   Detailed explanation goes here

%determine charger level

start_times = 0;
durations = 0;


%based on charger level, load approp lookup tables
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
scenario_end_time = scenario_start_time + scenario_duration;
charging_mask = timerange(scenario_start_time,scenario_end_time,'closed'); %make a charging scenario, rounding minutes to multiples of 5 to improve stability
%scenario_start_time = minutes(scenario_start_time);
%scenario_duration = minutes(scenario_duration);
scenario_start_time.Format = 'hh:mm';
scenario_duration.Format = 'hh:mm';

end