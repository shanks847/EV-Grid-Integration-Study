clc
clear all

balanced_eba_hres_path = "C:\Users\shank\Local Desktop\EV-Grid-Integration-Study\data\balanced loads\balanced_eba_hres.csv";
%balanced_eba_hres_path = "C:\Users\Shankar Ramharack\OneDrive - The University of the West Indies, St. Augustine\Desktop\EV-Grid-Integration-Study\data\balanced loads\balanced_eba_hres.csv";


%% Load Balanced Euclidean Barycenter Averaged Load Profiles
opts = delimitedTextImportOptions("NumVariables", 507);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Time", "P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P25", "P26", "P27", "P28", "P29", "P30", "P31", "P32", "P33", "P34", "P35", "P36", "P37", "P38", "P39", "P40", "P41", "P42", "P43", "P44", "P45", "P46", "P47", "P48", "P49", "P50", "P51", "P52", "P53", "P54", "P55", "P56", "P57", "P58", "P59", "P60", "P61", "P62", "P63", "P64", "P65", "P66", "P67", "P68", "P69", "P70", "P71", "P72", "P73", "P74", "P75", "P76", "P77", "P78", "P79", "P80", "P81", "P82", "P83", "P84", "P85", "P86", "P87", "P88", "P89", "P90", "P91", "P92", "P93", "P94", "P95", "P96", "P97", "P98", "P99", "P100", "P101", "P102", "P103", "P104", "P105", "P106", "P107", "P108", "P109", "P110", "P111", "P112", "P113", "P114", "P115", "P116", "P117", "P118", "P119", "P120", "P121", "P122", "P123", "P124", "P125", "P126", "P127", "P128", "P129", "P130", "P131", "P132", "P133", "P134", "P135", "P136", "P137", "P138", "P139", "P140", "P141", "P142", "P143", "P144", "P145", "P146", "P147", "P148", "P149", "P150", "P151", "P152", "P153", "P154", "P155", "P156", "P157", "P158", "P159", "P160", "P161", "P162", "P163", "P164", "P165", "P166", "P167", "P168", "P169", "P170", "P171", "P172", "P173", "P174", "P175", "P176", "P177", "P178", "P179", "P180", "P181", "P182", "P183", "P184", "P185", "P186", "P187", "P188", "P189", "P190", "P191", "P192", "P193", "P194", "P195", "P196", "P197", "P198", "P199", "P200", "P201", "P202", "P203", "P204", "P205", "P206", "P207", "P208", "P209", "P210", "P211", "P212", "P213", "P214", "P215", "P10R", "P10B", "P25R", "P25B", "P33R", "P33B", "P34R", "P34B", "P43R", "P43B", "P53R", "P53B", "P54R", "P54B", "P63R", "P63B", "P64R", "P64B", "P65R", "P65B", "P73R", "P73B", "P115R", "P115B", "P163R", "P163B", "P182R", "P182B", "P198R", "P198B", "P202R", "P202B", "P207R", "P207B", "P212R", "P212B", "P215R", "P215B", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13", "Q14", "Q15", "Q16", "Q17", "Q18", "Q19", "Q20", "Q21", "Q22", "Q23", "Q24", "Q25", "Q26", "Q27", "Q28", "Q29", "Q30", "Q31", "Q32", "Q33", "Q34", "Q35", "Q36", "Q37", "Q38", "Q39", "Q40", "Q41", "Q42", "Q43", "Q44", "Q45", "Q46", "Q47", "Q48", "Q49", "Q50", "Q51", "Q52", "Q53", "Q54", "Q55", "Q56", "Q57", "Q58", "Q59", "Q60", "Q61", "Q62", "Q63", "Q64", "Q65", "Q66", "Q67", "Q68", "Q69", "Q70", "Q71", "Q72", "Q73", "Q74", "Q75", "Q76", "Q77", "Q78", "Q79", "Q80", "Q81", "Q82", "Q83", "Q84", "Q85", "Q86", "Q87", "Q88", "Q89", "Q90", "Q91", "Q92", "Q93", "Q94", "Q95", "Q96", "Q97", "Q98", "Q99", "Q100", "Q101", "Q102", "Q103", "Q104", "Q105", "Q106", "Q107", "Q108", "Q109", "Q110", "Q111", "Q112", "Q113", "Q114", "Q115", "Q116", "Q117", "Q118", "Q119", "Q120", "Q121", "Q122", "Q123", "Q124", "Q125", "Q126", "Q127", "Q128", "Q129", "Q130", "Q131", "Q132", "Q133", "Q134", "Q135", "Q136", "Q137", "Q138", "Q139", "Q140", "Q141", "Q142", "Q143", "Q144", "Q145", "Q146", "Q147", "Q148", "Q149", "Q150", "Q151", "Q152", "Q153", "Q154", "Q155", "Q156", "Q157", "Q158", "Q159", "Q160", "Q161", "Q162", "Q163", "Q164", "Q165", "Q166", "Q167", "Q168", "Q169", "Q170", "Q171", "Q172", "Q173", "Q174", "Q175", "Q176", "Q177", "Q178", "Q179", "Q180", "Q181", "Q182", "Q183", "Q184", "Q185", "Q186", "Q187", "Q188", "Q189", "Q190", "Q191", "Q192", "Q193", "Q194", "Q195", "Q196", "Q197", "Q198", "Q199", "Q200", "Q201", "Q202", "Q203", "Q204", "Q205", "Q206", "Q207", "Q208", "Q209", "Q210", "Q211", "Q212", "Q213", "Q214", "Q215", "Q10R", "Q10B", "Q25R", "Q25B", "Q33R", "Q33B", "Q34R", "Q34B", "Q43R", "Q43B", "Q53R", "Q53B", "Q54R", "Q54B", "Q63R", "Q63B", "Q64R", "Q64B", "Q65R", "Q65B", "Q73R", "Q73B", "Q115R", "Q115B", "Q163R", "Q163B", "Q182R", "Q182B", "Q198R", "Q198B", "Q202R", "Q202B", "Q207R", "Q207B", "Q212R", "Q212B", "Q215R", "Q215B"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Time", "InputFormat", "yyyy-MM-dd HH:mm:ss");


balanced_eba_hres = readtable(balanced_eba_hres_path,opts);

customer_ids = opts.VariableNames;
customer_ids = customer_ids(2:length(customer_ids));
clear opts

customer_base_loads = balanced_eba_hres;
customer_base_loads_tstep = minutes(minutes(customer_base_loads(2,1).Time - customer_base_loads(1,1).Time)); %calculating the timestep based on the values of the table
customer_power_data = customer_base_loads(:,2:size(customer_base_loads,2)); %isolating the power readings of the original table
customer_base_loads_st = minutes(minute(customer_base_loads(1, 1).Time)); %start time of the utilization data
customer_base_loads_tt = table2timetable(customer_power_data,'TimeStep',customer_base_loads_tstep,'StartTime',customer_base_loads_st);
num_feeder_customers = 2400;

parfor plvl=1:4
    penetration_level = plvl*5/100;
    chargers_being_used = "MIX"; % Takes on either:"1", "2" OR "MIX"


    itr_limit = 1000;
    [averaged_loads,scn_details] = get_monte_carlo_scenario(num_feeder_customers,penetration_level, ...
        chargers_being_used,customer_base_loads_tt);

    fprintf("[+]Iteration 1\n")
    for n=1:itr_limit-1
        fprintf("[+]Iteration %d \n",n+1)

        [tmp_tbl,tmp_scn_details] = get_monte_carlo_scenario(num_feeder_customers,penetration_level, ...
            chargers_being_used,customer_base_loads_tt);

        averaged_loads = array2timetable(table2array(tmp_tbl) + table2array(averaged_loads), ...
            'RowTimes',tmp_tbl.Properties.RowTimes,'VariableNames', ...
            tmp_tbl.Properties.VariableNames);
    end

    %%
    averaged_loads = array2timetable((table2array(averaged_loads) ...
        ./itr_limit), 'RowTimes',averaged_loads.Properties.RowTimes, ...
        'VariableNames', averaged_loads.Properties.VariableNames);
    averaged_loads_T = rows2vars(averaged_loads,'VariableNamingRule','preserve');



    % %% Writing output
    tmp_emtp_data_pen_lvl = append('IMPS-CHARGING_LVL_',chargers_being_used);
    tmp_emtp_data_pen_lvl = append(tmp_emtp_data_pen_lvl,'_PEN_LVL_');
    tmp_emtp_data_pen_lvl = append(tmp_emtp_data_pen_lvl,num2str(penetration_level));
    fname_emtp = append(tmp_emtp_data_pen_lvl,'.csv');
    writetable(averaged_loads_T,fname_emtp);
    fprintf('PENETRATION LEVEL = %d, LEVEL %s',plvl,chargers_being_used)
    averaged_loads
end


parfor plvl=1:4
    penetration_level = plvl*5/100;
    chargers_being_used = "1"; % Takes on either:"1", "2" OR "MIX"


    itr_limit = 1000;
    [averaged_loads,scn_details] = get_monte_carlo_scenario(num_feeder_customers,penetration_level, ...
        chargers_being_used,customer_base_loads_tt);

    fprintf("[+]Iteration 1\n")
    for n=1:itr_limit-1
        fprintf("[+]Iteration %d \n",n+1)

        [tmp_tbl,tmp_scn_details] = get_monte_carlo_scenario(num_feeder_customers,penetration_level, ...
            chargers_being_used,customer_base_loads_tt);

        averaged_loads = array2timetable(table2array(tmp_tbl) + table2array(averaged_loads), ...
            'RowTimes',tmp_tbl.Properties.RowTimes,'VariableNames', ...
            tmp_tbl.Properties.VariableNames);
    end

    %%
    averaged_loads = array2timetable((table2array(averaged_loads) ...
        ./itr_limit), 'RowTimes',averaged_loads.Properties.RowTimes, ...
        'VariableNames', averaged_loads.Properties.VariableNames);
    averaged_loads_T = rows2vars(averaged_loads,'VariableNamingRule','preserve');



    % %% Writing output
    tmp_emtp_data_pen_lvl = append('IMPS-CHARGING_LVL_',chargers_being_used);
    tmp_emtp_data_pen_lvl = append(tmp_emtp_data_pen_lvl,'_PEN_LVL_');
    tmp_emtp_data_pen_lvl = append(tmp_emtp_data_pen_lvl,num2str(penetration_level));
    fname_emtp = append(tmp_emtp_data_pen_lvl,'.csv');
    writetable(averaged_loads_T,fname_emtp);
    fprintf('PENETRATION LEVEL = %d, LEVEL %s',plvl,chargers_being_used)
    averaged_loads
end


parfor plvl=1:4
    penetration_level = plvl*5/100;
    chargers_being_used = "2"; % Takes on either:"1", "2" OR "MIX"


    itr_limit = 1000;
    [averaged_loads,scn_details] = get_monte_carlo_scenario(num_feeder_customers,penetration_level, ...
        chargers_being_used,customer_base_loads_tt);

    fprintf("[+]Iteration 1\n")
    for n=1:itr_limit-1
        fprintf("[+]Iteration %d \n",n+1)

        [tmp_tbl,tmp_scn_details] = get_monte_carlo_scenario(num_feeder_customers,penetration_level, ...
            chargers_being_used,customer_base_loads_tt);

        averaged_loads = array2timetable(table2array(tmp_tbl) + table2array(averaged_loads), ...
            'RowTimes',tmp_tbl.Properties.RowTimes,'VariableNames', ...
            tmp_tbl.Properties.VariableNames);
    end

    %%
    averaged_loads = array2timetable((table2array(averaged_loads) ...
        ./itr_limit), 'RowTimes',averaged_loads.Properties.RowTimes, ...
        'VariableNames', averaged_loads.Properties.VariableNames);
    averaged_loads_T = rows2vars(averaged_loads,'VariableNamingRule','preserve');



    % %% Writing output
    tmp_emtp_data_pen_lvl = append('IMPS-CHARGING_LVL_',chargers_being_used);
    tmp_emtp_data_pen_lvl = append(tmp_emtp_data_pen_lvl,'_PEN_LVL_');
    tmp_emtp_data_pen_lvl = append(tmp_emtp_data_pen_lvl,num2str(penetration_level));
    fname_emtp = append(tmp_emtp_data_pen_lvl,'.csv');
    writetable(averaged_loads_T,fname_emtp);
    fprintf('PENETRATION LEVEL = %d, LEVEL %s',plvl,chargers_being_used)
    averaged_loads
end