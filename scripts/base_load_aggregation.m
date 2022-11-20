%function [aggregated_customer_load,load_profiles] = base_load_aggregation(customer_base_load,charging_level,start_time,duration)
function [aggregated_customer_load,hourly_loads] = base_load_aggregation(start,duration,level,base_load)
%BASE_LOAD_AGGREGATION  Adds power contribution from a randomized charging
%event to the base load of a customer
%start - charging start time
%duration - duration of charging event
%base_load - base residential load of customer

%determining charging index start
start_idx = ceilDiv(start,5)
dur = ceilDiv(duration,5)



%aggregated_customer_load = customer_base_load + ev_load;
aggregated_customer_load = x+y


















end