figure(1)
clf
cur_pos = get(gcf,'position');
cur_w = 400;
cur_h = 250;
set(gcf,'units','pixels','position',[cur_pos(1),cur_pos(2),cur_w,cur_h]);
hold on

n_cells = 250;
T=5.02;

% sample model without added GSH, plot doubling time as function of [ROS]
R = 3.2;
[dtmin dtmin_samples dtdelay_contr ROS] = sample_times(T, R, n_cells);
plot(ROS, dtmin_samples+dtdelay_contr,'.','Color',[0.4 0.4 0.8]);

% sample model with added GSH, plot doubling time as function of [ROS]
R = 0.35;
[dtmin dtmin_samples dtdelay_contr ROS] = sample_times(T, R, n_cells);
plot(ROS, dtmin_samples+dtdelay_contr,'.','Color',[0.4 0.8 0.4]);

% figure layout
set(gca,'YLim',[-1 20]);
set(gca,'XLim',[-3 6]);
font_name = 'Arial';
font_size_tick = 14;
font_size_label = 14;
set(get(gca,'XAxis'),'FontSize', font_size_tick, 'FontName', font_name);
set(get(gca,'YAxis'),'FontSize', font_size_tick, 'FontName', font_name);
set(gca, 'Layer', 'top');
xlabel('[ROS] (a.u.)', 'FontName', font_name, 'FontSize',font_size_label);
ylabel('Doubling time (days)', 'FontName', font_name, 'FontSize',font_size_label);
set(gca, 'TickLength', [0.025, 0.025]); 
set(gca, 'LineWidth', 1);
set(gca, 'YMinorTick','Off');
set(gca, 'XMinorTick','Off');



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