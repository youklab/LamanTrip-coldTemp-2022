figure(1)
clf
cur_pos = get(gcf,'position');
cur_w = 400;
cur_h = 250;
set(gcf,'units','pixels','position',[cur_pos(1),cur_pos(2),cur_w,cur_h]);
hold on

n_cells = 50;
T=5.02;

% sample G1 durations without added GSH
% (choose R such that average G1 duration equals experimental observations)
R = 2.4;
[dtmin dtmin_samples dtdelay_contr_v1] = sample_times(T, R, n_cells);
[dtmin dtmin_samples dtdelay_contr_v2] = sample_times(T, R, n_cells);
[dtmin dtmin_samples dtdelay_contr_v3] = sample_times(T, R, n_cells);
dtdelay_contr_v1=dtdelay_contr_v1(dtdelay_contr_v1<6.25);
dtdelay_contr_v2=dtdelay_contr_v2(dtdelay_contr_v2<6.25);
dtdelay_contr_v3=dtdelay_contr_v1(dtdelay_contr_v1<6.25);
dtdelay_contr = [dtdelay_contr_v1 dtdelay_contr_v2 dtdelay_contr_v3];
avg_contr = [mean(dtdelay_contr_v1) mean(dtdelay_contr_v2) mean(dtdelay_contr_v3)];
std_contr = std(avg_contr,0,2)/sqrt(3);
avg_contr = mean(avg_contr)

% sample G1 durations with added GSH
R = 1.55;
[dtmin dtmin_samples dtdelay_gsh_v1] = sample_times(T, R, n_cells);
[dtmin dtmin_samples dtdelay_gsh_v2] = sample_times(T, R, n_cells);
[dtmin dtmin_samples dtdelay_gsh_v3] = sample_times(T, R, n_cells);
dtdelay_gsh_v1=dtdelay_gsh_v1(dtdelay_gsh_v1<6.25);
dtdelay_gsh_v2=dtdelay_gsh_v2(dtdelay_gsh_v2<6.25);
dtdelay_gsh_v3=dtdelay_gsh_v1(dtdelay_gsh_v1<6.25);
dtdelay_gsh = [dtdelay_gsh_v1 dtdelay_gsh_v2 dtdelay_gsh_v3];
avg_gsh = [mean(dtdelay_gsh_v1) mean(dtdelay_gsh_v2) mean(dtdelay_gsh_v3)];
std_gsh = std(avg_gsh,0,2)/sqrt(3);
avg_gsh = mean(avg_gsh)

% scatter plot of sampled G1 durations
rangecut = [-1 4];UnivarScatter({dtdelay_contr},'Width',0.5,'RangeCut',rangecut,'PointSize',40,'xval',[1],'Color',[0.0 0.4 0.8]);
rangecut = [-1 2];UnivarScatter({dtdelay_gsh},'Width',0.5,'RangeCut',rangecut,'PointSize',40,'xval',[2],'Color',[0.4 0.8 0.4]);

% error bar between samples
errorbar(1,avg_contr,std_contr,std_contr,'.-','Color',[0.8 0.2 0.2],'LineWidth',1);
errorbar(2,avg_gsh, std_gsh,std_gsh,'.-','Color',[0.8 0.2 0.2],'LineWidth',1);

% figure layout
set(gca,'YLim',[-0.25 6.25]);
set(gca,'XLim',[0.5 2.5]);
font_name = 'Arial';
font_size_tick = 14;
font_size_label = 14;
set(get(gca,'XAxis'),'FontSize', font_size_tick, 'FontName', font_name);
set(get(gca,'YAxis'),'FontSize', font_size_tick, 'FontName', font_name);
set(gca, 'Layer', 'top');
ylabel('% of cells', 'FontName', font_name, 'FontSize',font_size_label);
set(gca, 'TickLength', [0.025, 0.025]); 
set(gca, 'LineWidth', 1);
set(gca, 'YMinorTick','Off');
set(gca, 'XMinorTick','Off');
set(gca,'Xtick',[1 2]);
set(gca,'Ytick',[0 2 4 6 8 10]);



function [dtmin dtmin_samples dtdelay ROS] = sample_times(T, R, n_cells)
	% model parameters
    tau_min_T0 = 2.5;
    Tm = -10;
    T0 = 5.02;
    k=0.77236;
    a = 120.72;
    rg_T0 = 11.23;
    
    % compute exact and sample minimum doubling time
    eps = normrnd(0,1,1,n_cells);
    dtmin = tau_min_T0 * exp( k*a * (1/(T-Tm) - 1/(T0-Tm)) );
    dtmin_samples = (tau_min_T0 + eps) * exp( k*a * (1/(T-Tm) - 1/(T0-Tm)) );

    % compute [ROS] dependent delay
    ROS = normrnd(R,1,1,n_cells);
    dtdelay = (1/rg_T0) * exp(a * (1/(T-Tm) - 1/(T0-Tm)) + ROS);
end