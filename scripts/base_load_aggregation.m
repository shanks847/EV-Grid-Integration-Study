%function [aggregated_customer_load,load_profiles] = base_load_aggregation(customer_base_load,charging_level,start_time,duration)
function [aggregated_customer_load,load_profiles] = base_load_aggregation(x,y)
%BASE_LOAD_AGGREGATION Adds EV Charging Load to Residential Base Load
%   This function computes the total residential load from EV Charge
%   contributions. It does this by determinig the total power output
%   from a charging event based on the power rating at the level, start
%   time and duration of the charging event.
% charger_power = 0
% if charging_level == 1
%     charger_power = 1920
% else
%     charger_power = 6600
% 
% ev_load = 0;
load_profiles = 0:23
%aggregated_customer_load = customer_base_load + ev_load;
aggregated_customer_load = x+y
end