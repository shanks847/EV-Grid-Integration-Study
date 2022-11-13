function [pd1,pd2,pd3] = createFit_l1_start_times_trunc(L1_start_times_mins_truncated)
%CREATEFIT    Create plot of datasets and fits
%   [PD1,PD2,PD3] = CREATEFIT(L1_START_TIMES_MINS_TRUNCATED)
%   Creates a plot, similar to the plot in the main distribution fitter
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with distributionFitter
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  3
%
%   See also FITDIST.

% This function was automatically generated on 13-Nov-2022 14:54:57

% Output fitted probablility distributions: PD1,PD2,PD3

% Data from dataset "L1_start_times_mins_truncated data":
%    Y = L1_start_times_mins_truncated

% Force all inputs to be column vectors
L1_start_times_mins_truncated = L1_start_times_mins_truncated(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "L1_start_times_mins_truncated data"
[CdfF,CdfX] = ecdf(L1_start_times_mins_truncated,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 1;
[~,BinEdge] = internal.stats.histbins(L1_start_times_mins_truncated,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','none','EdgeColor',[0.333333 0 0.666667],...
    'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Density')
LegHandles(end+1) = hLine;
LegText{end+1} = 'L1_start_times_mins_truncated data';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "Weibull"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('weibull',[ 1002.732063415, 3.983740371951])
pd1 = fitdist(L1_start_times_mins_truncated, 'weibull');
YPlot = pdf(pd1,XGrid);
hLine = plot(XGrid,YPlot,'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'Weibull';
%kstest(pd1,L1_start_times_mins_truncated)
%goodnessOfFit(pd1,L1_start_times_mins_truncated,'NRMSE')
% --- Create fit "Normal"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd2 = ProbDistUnivParam('normal',[ 906.8836088486, 258.519078389])
pd2 = fitdist(L1_start_times_mins_truncated, 'normal');
YPlot = pdf(pd2,XGrid);
hLine = plot(XGrid,YPlot,'Color',[0 0 1],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'Normal';
pd2
% --- Create fit "fit 3"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd3 = ProbDistUnivParam('stable',[ 1.999999852194, -0.9999998909, 182.8241787391, 906.96983958])
pd3 = fitdist(L1_start_times_mins_truncated, 'stable');
YPlot = pdf(pd3,XGrid);
hLine = plot(XGrid,YPlot,'Color',[0.666667 0.333333 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fit 3';

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
