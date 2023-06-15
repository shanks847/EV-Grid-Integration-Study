MeasurementTime = datetime({'2015-12-18 08:03:05';'2015-12-18 10:03:17';'2015-12-18 12:03:13'});
Temp = [1;2;3];
Pressure = [1;1;1];
WindSpeed = [2;3;4];
TT_A = timetable(MeasurementTime,Temp,Pressure,WindSpeed)

MeasurementTime = datetime({'2015-12-18 08:03:15';'2015-12-18 10:02:17';'2015-9-18 12:03:13'});
Temp = [1;2;3];
Pressure = [1;1;1];
WindSpeed = [2;3;4];
TT_B = timetable(MeasurementTime,Temp,Pressure,WindSpeed)

%% Testing adding contents of two tables
table2array(TT_A) + table2array(TT_B)

%% Converting table addition to a timetable
array2timetable(table2array(TT_A) + table2array(TT_B),'RowTimes',MeasurementTime)

%% Renaming elements
array2timetable(table2array(TT_A) + table2array(TT_B),'RowTimes',MeasurementTime,'VariableNames',["X1","X2","X3"])

%% Changing to more user friendly time format
TIMES = [minutes(1214),minutes(124),minutes(1000)]
array2timetable(table2array(TT_A) + table2array(TT_B),'RowTimes',TIMES,'VariableNames',["X1","X2","X3"])