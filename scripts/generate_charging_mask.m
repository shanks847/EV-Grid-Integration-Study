function [charging_mask,scenario_start_time,scenario_duration] = generate_charging_mask(charger_level, varargin)
%GENERATE_CHARGING_MASK creates a charging mask for the specified level
%   Detailed explanation goes here

% Create an input parser object
parser = inputParser;

% Define the required input
addRequired(parser, 'charger_level');

% Define the optional inputs
default_custom_start_distribution = 0;  
default_custom_duration_distribution = 0;
%default_custom_charging_level = 0;
addOptional(parser, 'custom_args', {default_custom_start_distribution, ...
    +default_custom_duration_distribution});

% Parse the inputs
parse(parser, charger_level, varargin{:});

% Unpack the optional inputs
customArgs = parser.Results.custom_args;
custom_start_distribution = customArgs{1};
custom_duration_distribution = customArgs{2};
%custom_charging_level = customArgs{3};


% generate EV Charging scenarios for selected customers
% Either 1 or 2 corresponding to LEVEL 1 charging and LEVEL 2 charging respectively
%charging_level = charger_level; % doing this so I can accommodate higher powers

% Probability distribution of charging start times
start_distribution = 0;

% Probability distribution of charging duration
duration_distribution = 0;

%This is the kW rating of the charger
%charging_level = 0;

if nargin > 2
    % custom probability distribution for start times
    start_distribution = custom_start_distribution;

    % custom probability distribution for charging duration
    duration_distribution = custom_duration_distribution;

    %charging_level = custom_charging_level;

    disp('[!] Custom parameters chosen')

else
    if charger_level == 1
        start_distribution = makedist("Normal",877.50,294.90);

        duration_distribution = makedist("GeneralizedPareto",'theta',-94.34, ...
            'sigma',114.34,'k',2.02);

        %charging_level = 1.92;

    elseif charger_level == 2

        start_distribution = makedist("Normal",916.60,302.02);

        duration_distribution = makedist("GeneralizedPareto", ...
            'theta',16.92,'sigma',3.08,'k',0.55);

        %charging_level = 6.6;

    else
        disp("[X] Unsupported charging level selected")
    end
        
end

%make a charging scenario, rounding minutes to multipless of 5 to improve stability
scenario_start_time = 5*round(start_distribution.random()/5); %generating scenario start time from start time distribution
scenario_duration = 5*round(duration_distribution.random()/5); %generating scenario start time from start time distribution

scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
charging_mask = timerange(minutes(scenario_start_time),scenario_end_time);  %creating mask to isolate period of charging so there values can be modified
%modified_customer_loads = customer_base_loads_tt;  %initializing the modified load table to the base load table



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
        scenario_duration = 5*round(duration_distribution.random()/5);
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