function [pre_overflow_mask,post_overflow_mask,scenario_start_time,scenario_duration] = generate_charging_mask(charger_level,charging_events_path)
%GENERATE_CHARGING_MASK creates a charging mask for the specified level
%   Detailed explanation goes here


% Probability distribution of charging start times
start_distribution = 0;

% Probability distribution of charging duration
duration_distribution = 0;


% Import the file
newData1 = load('-mat', charging_events_path);

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end

% Define your list of data
data = newData1.l2_durs;


if charger_level == 1
    start_distribution = makedist("Normal",877.50,294.90);

    duration_distribution = makedist("GeneralizedPareto",'theta',-94.34, ...
        'sigma',114.34,'k',2.02);

elseif charger_level == 2

    start_distribution = makedist("Normal",916.60,302.02);

    duration_distribution = fitdist(data, 'Kernel', 'Kernel', 'normal');

else
    disp("[X] Unsupported charging level selected")
end


%make a charging scenario, rounding minutes to multipless of 5 to improve stability
scenario_start_time = 5*round(start_distribution.random()/5);
scenario_duration =  5*round(duration_distribution.random()/5);
scenario_end_time = 0;

%constraining the start time to be less than 24 hours but greater than 0
%DISCLAIMER: THIS WORK DOES NOT CONSIDER SCENARIOS STARTING AT THE
%TRANSITION INTO THE NEXT DAY
while  (scenario_start_time > 1440 || scenario_start_time <20)
    scenario_start_time = 5*round(start_distribution.random()/5);
    if (scenario_start_time < 1440 && scenario_start_time >0)
        break
    else
        continue
    end
end

if charger_level == 1
    %constraining the duration to be less than 24 hours but greater than 20
    %minutes
    while  (scenario_duration > 840 || scenario_duration<20)
        scenario_duration = 5*round(duration_distribution.random()/5);
        if (scenario_duration < 840 && scenario_duration >= 20)
            break
        else
            continue
        end
    end
else
    %constraining the duration to be less than 4 hours but greater than 20
    %minutes
    while  (scenario_duration > 240 || scenario_duration < 20)
        scenario_duration =  5*round(duration_distribution.random()/5);
        if (scenario_duration < 240 && scenario_duration >= 20)
            break
        else
            continue
        end
    end
end

%scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
%charging_mask = timerange(minutes(scenario_start_time),scenario_end_time,'closed'); %make a charging scenario, rounding minutes to multiples of 5 to improve stability
scenario_start_time = minutes(scenario_start_time);
scenario_duration = minutes(scenario_duration);

scenario_start_time.Format = 'hh:mm';
scenario_duration.Format = 'hh:mm';


%splitting overflow to the front of the profile
end_of_day = minutes(1440);
start_of_day = minutes(0);
end_of_day.Format = 'hh:mm';
start_of_day.Format = 'hh:mm';

time_left = end_of_day - scenario_start_time;

if time_left < scenario_duration
    pre_overflow_mask = timerange(scenario_start_time,end_of_day,'closed');
    overflow = start_of_day + (scenario_duration - time_left);
    post_overflow_mask = timerange(start_of_day,overflow,'closed');

else
    scenario_end_time = scenario_start_time + scenario_duration;
    pre_overflow_mask = timerange(scenario_start_time,scenario_end_time,'closed');
    post_overflow_mask = timerange(minutes(0),minutes(0));
end


end