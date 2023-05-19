%function [aggregated_customer_load,load_profiles] = base_load_aggregation(customer_base_load,charging_level,start_time,duration)
function [event_details,modified_cutils] = base_load_aggregation(start_distribution,duration_distribution, scenario_clevel, customer_ID, cutilres_tt)
%BASE_LOAD_AGGREGATION  Adds power contribution from a randomized charging
%event to the base load of a customer
%start_distribution - PDF of start times for the charging level of that
%customer
%duration_distribution - PDF of charging periods for the charging level of that
%customer
%customer_charging_levels - the pdf of charging levels customers can have
%customer_ID - The ID of the EV customer
%cutilres_tt - The table containing all the base loads of the
%distribution area


%specifying charging level based on generated scenario for customer
charging_level = 0;
if scenario_clevel == 1
    charging_level = 1.92;
else
    charging_level = 6.6;
end

%make a charging scenario
sst = start_distribution.random(); %generating scenario start time from start time distribution
sp = duration_distribution.random(); %generating scenario duration from duration distribution

scenario_end_time = minutes(sst) + minutes(sp);
charging_mask = timerange(minutes(sst),scenario_end_time); %creating mask to isolate period of charging so there values can be modified

modified_cutils = cutilres_tt;

%make a charging scenario
sst = 5*round(start_distribution.random()/5); %generating scenario start time from start time distribution
sp = 5*round(duration_distribution.random()/5);
while  (sp > 1440 || sp<0)
    sp = 5*round(duration_distribution.random()/5);
    if (sp < 1440 && sp>0)
        break
    else
        continue
    end
end

while  (sst > 1440 || sst <0)
    sst = 5*round(start_distribution.random()/5);
    if (sst < 1440 && sst >0)
        break
    else
        continue
    end
end
scenario_end_time = minutes(sst) + minutes(sp);
%rounding minutes to multiples of 5 to improve stability
charging_mask = timerange(minutes(sst),scenario_end_time); %creating mask to isolate period of charging so there values can be modified

%import base load
num_timestamps = size(modified_cutils(charging_mask,customer_ID),1);
% disp("==================== Base Load Before (REDUCED TO AREA OF MASK) ====================")
% modified_cutils(charging_mask,customer_ID)
modified_cutils{charging_mask,[customer_ID]} = modified_cutils{charging_mask,[customer_ID]} + ones(num_timestamps,1)*charging_level;
% disp("==================== Base Load After (REDUCED TO AREA OF MASK) ====================")
% modified_cutils(charging_mask,customer_ID)

event_details = {customer_ID,scenario_clevel,minutes(sst),minutes(sp)};
% disp("DISTRIBUTION SAMPLE")
% sp
% disp("COVERTED TO MINUTES")
% sp

end