function [charging_mask,scenario_start_time,scenario_duration] = generate_charging_mask_itr4(charger_level)
%GENERATE_CHARGING_MASK creates a charging mask for the specified level
%   Detailed explanation goes here


% Probability distribution of charging start times
start_distribution = 0;

% Probability distribution of charging duration
duration_distribution = 0;





% Import the file
charging_events_path = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\misc\charging_events.mat";
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

    %charging_level = 1.92;

elseif charger_level == 2

    start_distribution = makedist("Normal",916.60,302.02);

    %duration_distribution = gmdistribution([20,80],[69,30]);
    duration_distribution = fitdist(data, 'Kernel', 'Kernel', 'normal');
    %charging_level = 6.6;

else
    disp("[X] Unsupported charging level selected")
end


%make a charging scenario, rounding minutes to multipless of 5 to improve stability
scenario_start_time = 5*round(start_distribution.random()/5);
scenario_end_time = 0;
scenario_duration = 0;




if charger_level == 2
    %tmp = gmdistribution([20,80],[69,30]).random();
    %scenario_duration = abs(5*round(tmp(randi(2,1))/5));
    scenario_duration =  5*round(duration_distribution.random()/5);
    scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
end


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
        %tmp = gmdistribution([20,80],[69,30]).random();
        %scenario_duration = 5*round(tmp(randi(2,1))/5);
        scenario_duration =  5*round(duration_distribution.random()/5);
        if (scenario_duration < 240 && scenario_duration >= 20)
            break
        else
            continue
        end
    end
end

scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
charging_mask = timerange(minutes(scenario_start_time),scenario_end_time,'closed'); %make a charging scenario, rounding minutes to multiples of 5 to improve stability
scenario_start_time = minutes(scenario_start_time);
scenario_duration = minutes(scenario_duration);

scenario_start_time.Format = 'hh:mm';
scenario_duration.Format = 'hh:mm';
end