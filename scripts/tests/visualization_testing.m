%% Validating at the customer level -- REG. CONFIG
%Adding load for one of the selected customers who is not a closed delta
% test_subject = "P95C4";
% customer_base_loads_tt.Time.Format = 'hh:mm';
% 
% customer_info_split = strsplit(test_subject, 'C');
% tf_ID = customer_info_split(1);
% 
% %add power to a temporary variable and assign it as the mod val
% test_subject_modified_load = customer_base_loads_tt(:,tf_ID);
% test_subject_modified_load(:,tf_ID) = num2cell(test_subject_modified_load{ ...
%     :,tf_ID} + TF_CUSTOMER_flat_profiles_timetable{:,test_subject});
% 
% %plot base load in a light blue
% plot(customer_base_loads_tt(:,tf_ID),'Time',tf_ID,'Color',"#80B3FF")
% hAx=gca;
% set(hAx,'YGrid','on','XGrid','on')
% %set(hAx,'xminorgrid','on','yminorgrid','on')
% hold on
% 
% % %plot modified load in red
% plot(test_subject_modified_load,'Time',tf_ID,'Color','red','LineStyle','--')
% hold off

q=0;




%% Validating at the customer level -- CLOSED DELTA

% %test_subject = closed_delta_test_subject;
% test_subject =  "P53C11";
% customer_info_split = strsplit(test_subject, 'C');
% tf_ID = customer_info_split(1);
% CID = customer_info_split(2);
% 
% tf_ID_R = append(tf_ID,"R");
% tf_ID_B = append(tf_ID,"B");
% 
% customer_B_ID = append(tf_ID_B,"C");
% customer_B_ID = append(customer_B_ID,CID);
% 
% customer_R_ID = append(tf_ID_R,"C");
% customer_R_ID = append(customer_R_ID,CID);
% 
% red_base = customer_base_loads_tt(:,tf_ID_R);
% white_base = customer_base_loads_tt(:,tf_ID);
% black_base = customer_base_loads_tt(:,tf_ID_B);
% 
% 
% red_mod = red_base;
% white_mod = white_base;
% black_mod = black_base;
% 
% red_mod(:,tf_ID_R) = num2cell(red_base{ ...
%     :,tf_ID_R} + TF_CUSTOMER_flat_profiles_timetable{:,customer_R_ID});
% 
% white_mod(:,tf_ID) = num2cell(white_base{ ...
%     :,tf_ID} + TF_CUSTOMER_flat_profiles_timetable{:,test_subject});
% 
% 
% black_mod(:,tf_ID_B) = num2cell(black_base{ ...
%     :,tf_ID_B} + TF_CUSTOMER_flat_profiles_timetable{:,customer_B_ID});
% 
% % Create the figure and subplots
% figure;
% subplot(3, 1, 1);
% hold on;
% % Plot red_base and red_mod in the first subplot
% plot(red_base,'Time', tf_ID_R, 'color', "#FF0303", 'DisplayName', 'red\_base');
% plot(red_mod,'Time', tf_ID_R, 'color', "#227C70", 'DisplayName', 'red\_mod','LineStyle','--');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% grid on
% 
% subplot(3, 1, 2);
% hold on;
% % Plot white_base and white_mod in the second subplot
% plot(white_base,'Time', tf_ID, 'color', "#27E1C1", 'DisplayName', 'white\_base');
% plot(white_mod,'Time', tf_ID, 'color', "#227C70", 'DisplayName', 'white\_mod','LineStyle','--');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% grid on
% 
% subplot(3, 1, 3);
% hold on;
% % Plot black_base and black_mod in the third subplot
% plot(black_base,'Time', tf_ID_B, 'color', "#E7AB9A", 'DisplayName', 'black\_base');
% plot(black_mod,'Time', tf_ID_B, 'color', "#227C70", 'DisplayName', 'black\_mod','LineStyle','--');
% xlabel('Time');
% % Create ylabel
% ylabel('Power/kW');
% legend('Location', 'best');
% set(gca,'FontSize',18)
% 
% grid on
% % Adjust spacing between subplots
% sgtitle('Closed Delta Load Sharing during Charging Event');
% 
% hold off

q=0;

%% Validating at the TF level -- REG CONFIG
% %Adding load for one of the selected customers who is not a closed delta
%test_subject = ev_customer_IDs(1);
test_subject = "P212C8";
customer_base_loads_tt.Time.Format = 'hh:mm';

customer_info_split = strsplit(test_subject, 'C');
tf_ID = customer_info_split(1);
CID = customer_info_split(2);

%add power to a temporary variable and assign it as the mod val

%test_subject_modified_load = customer_base_loads_tt(:,tf_ID);

%plot base load in a light blue
plot(customer_base_loads_tt(:,tf_ID),'Time',tf_ID,'Color',"#80B3FF")
hAx=gca;
set(hAx,'YGrid','on','XGrid','on')
%set(hAx,'xminorgrid','on','yminorgrid','on')
hold on

plot(averaged_loads(:,tf_ID),'Time',tf_ID,'Color','red','LineStyle','--')
hold off

ylabel('Real Power/kW')
tstr = append('Loading on Transformer ',tf_ID)
title(tstr)


%% Validating at the TF level -- CLOSED DELTA
test_subject = "P33C4";
customer_info_split = strsplit(test_subject, 'C');
tf_ID = customer_info_split(1);
CID = customer_info_split(2);
tf_ID_R = append(tf_ID,"R");
tf_ID_B = append(tf_ID,"B");


red_base = customer_base_loads_tt(:,tf_ID_R);
white_base = customer_base_loads_tt(:,tf_ID);
black_base = customer_base_loads_tt(:,tf_ID_B);



% Create the figure and subplots
figure;
subplot(3, 1, 1);
hold on;
% Plot red_base and red_mod in the first subplot
plot(red_base,'Time', tf_ID_R, 'color', "#FF0303", 'DisplayName', 'red\_base');
plot(averaged_loads,'Time', tf_ID_R, 'color', "#227C70", 'DisplayName', 'red\_mod','LineStyle','--');
% Create ylabel
ylabel('Power/kW');
legend('Location', 'best');
set(gca,'FontSize',18)
grid on

subplot(3, 1, 2);
hold on;
% Plot white_base and white_mod in the second subplot
plot(white_base,'Time', tf_ID, 'color', "#27E1C1", 'DisplayName', 'white\_base');
plot(averaged_loads,'Time', tf_ID, 'color', "#227C70", 'DisplayName', 'white\_mod','LineStyle','--');
% Create ylabel
ylabel('Power/kW');
legend('Location', 'best');
set(gca,'FontSize',18)
grid on

subplot(3, 1, 3);
hold on;
% Plot black_base and black_mod in the third subplot
plot(black_base,'Time', tf_ID_B, 'color', "#E7AB9A", 'DisplayName', 'black\_base');
plot(averaged_loads,'Time', tf_ID_B, 'color', "#227C70", 'DisplayName', 'black\_mod','LineStyle','--');
xlabel('Time');
% Create ylabel
ylabel('Power/kW');
legend('Location', 'best');
set(gca,'FontSize',18)

grid on
% Adjust spacing between subplots
tstr = append('Loading on Closed Delta Transformer ',tf_ID)
sgtitle(tstr);
hold off