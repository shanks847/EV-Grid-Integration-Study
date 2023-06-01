% Set the number of bootstrap samples
num_samples = 2400;



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


% Estimate the PDF using kernel density estimation
kde = fitdist(data, 'Kernel', 'Kernel', 'normal');

% Generate points for the x-axis
x = linspace(min(data) - 1, max(data) + 1, 100);

% Evaluate the PDF
y = pdf(kde, x);


fig = figure();
fontsize(fig,14,"points")

% Plot the PDF
plot(x, y);
xlabel('Value');
ylabel('Density');
title('Probability Density Function');
grid on;

