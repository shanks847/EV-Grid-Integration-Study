%function [aggregated_customer_load,load_profiles] = base_load_aggregation(customer_base_load,charging_level,start_time,duration)
function [event_details,modified_customer_loads] = base_load_aggregation( ...
    customer_ID,scenario_clevel, ...
    start_distribution, duration_distribution, ...
    customer_base_loads_tt,closed_delta_customers ...
    )
%BASE_LOAD_AGGREGATION  Adds power contribution from a randomized charging
%specifying charging level based on generated scenario for customer
charging_level = 0;
if scenario_clevel == 1
    charging_level = 1.92;
else
    charging_level = 6.6;
end

%make a charging scenario, rounding minutes to multiples of 5 to improve stability
scenario_start_time = 5*round(start_distribution.random()/5); %generating scenario start time from start time distribution
scenario_duration = 5*round(duration_distribution.random()/5); %generating scenario start time from start time distribution

scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
charging_mask = timerange(minutes(scenario_start_time),scenario_end_time);  %creating mask to isolate period of charging so there values can be modified
modified_customer_loads = customer_base_loads_tt;  %initializing the modified load table to the base load table

%% CREATING CHARGING SCNEARIO 

%constraining the duration to be less than 24 hours but greater than 0
while  (scenario_duration > 1440 || scenario_duration<0)
    scenario_duration = 5*round(duration_distribution.random()/5);
    if (scenario_duration < 1440 && scenario_duration>0)
        break
    else
        continue
    end
end

%constraining the start time to be less than 24 hours but greater than 0
%DISCLAIMER: THIS WORK DOES NOT CONSIDER SCENARIOS STARTING AT THE
%TRANSITION INTO THE NEXT DAY
while  (scenario_start_time > 1440 || scenario_start_time <0)
    scenario_start_time = 5*round(start_distribution.random()/5);
    if (scenario_start_time < 1440 && scenario_start_time >0)
        break
    else
        continue
    end
end

scenario_end_time = minutes(scenario_start_time) + minutes(scenario_duration);
charging_mask = timerange(minutes(scenario_start_time),scenario_end_time); %creating mask to isolate period of charging so there values can be modified

%%
num_timestamps = size(modified_customer_loads(charging_mask,customer_ID),1);
%disp("==================== Base Load Before (REDUCED TO AREA OF MASK) ====================")
%modified_customer_loads(charging_mask,customer_ID)


%% checking if customer is on a closed delta
customer_R_ID = "";
customer_B_ID = "";

if sum(ismember(closed_delta_customers,customer_ID)) >= 1

    %add 2/3 of the EV load to customer base load(on the system this is
    %the 2nd phase)
    %disp("==================== WHITE PHASE BASE LOAD =============")
    %customer_base_loads_tt{charging_mask,customer_ID}
    %disp("==================== WHITE PHASE MODIFIED LOAD =============")
    modified_customer_loads{charging_mask,customer_ID} = modified_customer_loads{ ...
    charging_mask,customer_ID} + ones(num_timestamps,1)*(2/3)*charging_level;
    %modified_customer_loads{charging_mask,customer_ID}

    %add 1/3 load to R, this is the 1st phase on the system
    customer_R_ID = append(customer_ID,"R"); %ID for customer R-Phase ID
    %disp("==================== RED PHASE BASE LOAD =============")
    %customer_base_loads_tt{charging_mask,customer_R_ID}

    modified_customer_loads{charging_mask,customer_R_ID} = modified_customer_loads{ ...
    charging_mask,customer_R_ID} + ones(num_timestamps,1)*(1/3)*charging_level;
    %disp("==================== RED PHASE MODIFIED LOAD =============")
    %modified_customer_loads{charging_mask,customer_R_ID}


    %add 1/3 load to B, this is the last phase on the system
    %disp("==================== BLACK PHASE BASE LOAD =============")
    customer_B_ID = append(customer_ID,"B"); %ID for customer B-Phase ID
    %customer_base_loads_tt{charging_mask,customer_B_ID}

    %disp("==================== BLACK PHASE MODIFIED LOAD =============")
    modified_customer_loads{charging_mask,customer_B_ID} = modified_customer_loads{ ...
    charging_mask,customer_B_ID} + ones(num_timestamps,1)*(1/3)*charging_level;
    %modified_customer_loads{charging_mask,customer_B_ID} 
    event_details = {customer_ID,scenario_clevel,minutes(scenario_start_time),minutes(scenario_duration)};
else
    event_details = {customer_ID,scenario_clevel,minutes(scenario_start_time),minutes(scenario_duration)};
end



end