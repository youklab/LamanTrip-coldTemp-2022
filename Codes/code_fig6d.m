figure(1)
clf
cur_pos = get(gcf,'position');
cur_w = 400;
cur_h = 250;
set(gcf,'units','pixels','position',[cur_pos(1),cur_pos(2),cur_w,cur_h]);
hold on

% increments in temperatures of 0.1C
Ts = (5+30-0.1):-0.1:0;

n_cells = 100000;
ROS = 3.2 * 0.985 ^ (300); 
DtT = [];
dt1c = [];
for (i=1:length(Ts))
	% select temperature
    T = Ts(i);
    
    % decrease [ROS] by 1.5% for every 0.1C
    ROS = ROS * (1/0.985); 
    
    % sample minimum doubling times and delays from model
    [dtmin dtmin_samples dtdelay] = sample_times(T, ROS, n_cells);
    
    % compute total doubling times
    Dtfull_contr = dtmin + dtdelay;
    
    % assume that cells beyond the 99-th percentile cannot replicate
    DtT = [DtT prctile(Dtfull_contr,99)]; 
    
    % show some doubling times at 1C estimated from model
    if (T == 1) 
       dt1c = Dtfull_contr(1:50);
    end
end

% plot longest possible doubling time as function of temperature
plot(Ts,log10(DtT),'-','Color',[1.0 0.7 0.0],'LineWidth',2);


Ts = 0:1:40;
Dtmin = [];
for (i=1:length(Ts))
    T = Ts(i);
    
    % sample minimum doubling times and delays from model
    [dtmin dt_samples dtdelay] = sample_times(T, 0, n_cells);
    Dtmin = [Dtmin dtmin];
end

% plot shortest possible doubling time as function of temperature
plot(Ts,log10(Dtmin),'-','Color',[0.8 0.4 0.4],'LineWidth',2);
rangecut=[-1.5 4];

% experimentally measured doubling times at given temperatures
xval_contr = [1 3.95 5.02 6.14 7.33 8.33 9.33 10.33 14.14 30];
pop_data_1C = dt1c;
data_1C = [26.7	17.9	42.7	22.0 34.8	18.0	13.9	38.7					34.8			34.8			];
data_4C = [14.44056626	13.75292025 15.20059606	16.04507362 16.04507362	13.75292025 18.05070783	41.25876075	18.05070783	20.62938037];
data_5C = [7.600298032	7.805711493	8.494450742 6.41802945	7.044178664	8.022536812 7.220283131	7.805711493	8.022536812 7.220283131	5.662967161	12.55701414 7.220283131	6.144921813	4.979505607 6.27850707	6.563893755	15.20059606 6.876460125	8.75185834	11.55245301];
data_6C = [3.397780297	1.729409133	1.622535535	1.65035043 3.319670405	2.155308397	1.938331042	1.52810225 3.397780297	2.13934315	1.851354649	1.496431737 3.008451305	2.048307271	1.578203963	1.622535535 2.724635144	2.310490602	2.75058405	2.803993449	2.625557502	2.468472865 2.555852436	2.511402828	2.348059555	2.803993449	2.447553604	2.917286113 2.699171264	2.601903831	2.601903831	2.888113252	2.75058405	2.859518072 2.625557502	2.724635144	2.601903831	2.601903831	2.533432677	3.105498121];
data_7C = [1.964702893	1.631702402	1.65035043	1.569626768	2.077779318	2.274104923 1.912657783		1.604507362	1.504225652	1.761044666	2.019659617 1.938331042	1.604507362	1.604507362	1.496431737	1.561142299	2.256338478 1.863298872	1.688955118	1.569626768	1.536230453	1.729409133	];
data_8C = [1.123779476	1.119423741	0.885924311	0.851950812 1.155245301	1.098141921	0.94382786	0.820486719 1.132593432	1.110812789	0.992478781	0.778467184 1.102333302	1.077654199	0.985704182	1.178821736 1.155245301	1.123779476	1.081690357	1.02779831	0.969165521	1.16927662 1.289336273	1.16927662	0.928653779	1.119423741	1.188523972	1.146076687 1.29511805	1.193435228	0.972428704	1.193435228	1.02779831	1.183652972 1.115101642	1.098141921	1.183652972	1.178821736	1.031469019	1.128169239];
data_9C = [1.024153636	0.899723755	0.762035159	0.837134276	0.789101982	0.969165521 1.009829809	0.94382786	0.746282494	0.780571149	0.766077786	0.851950812 1.013373071	0.925677324	0.709610136	0.74054186	0.69930103	1.006311238 1.020534718	0.905364656	0.674792816	0.752112826	0.674792816	1.318773175 ];
data_10C = [0.625132739	0.602946399	0.500539558	0.512986368 0.640379879	0.57994242	0.522262794	0.516657111 0.582280898	0.589410868	0.536824025	0.523208923 0.638963109	0.574177585	0.543900801	0.531880894];
data_14C = [0.33196704	0.271184343	0.299286347	0.280399345	0.266431112	0.254235322 0.338980429	0.300219673	0.25513368	0.316679085	0.266677124	0.243107176 0.333115715	0.284823792	0.321258426	0.292912095	0.270676031	0.237509314 0.31772423	0.316679085	0.302103897	0.290847256	0.26816279	0.279855935 ];
data_10C = [data_10C     0.74054186	0.780571149	0.8570069 0.832309295	0.731167912	1.330927766 0.707870895	0.811267768	1.024153636 0.576469711	1.093982293	1.054055932     0.883215062	1.020534718	1.077654199 0.820486719	0.979021441	1.146076687 0.820486719	0.937699108	1.073648049 0.842015525	0.851950812	0.832309295];
data_30C = [0.064535157	0.063779581	0.059497055	0.065210393	0.067898961	0.060685808	0.060676902	0.066944603	0.061191117	0.058310776	0.069855224	0.061454104	0.064544784	0.06841111	0.059075944	0.065557423	0.067816162	0.062019062	0.069960412	0.070135515	0.06163236	0.068287061	0.066613173	0.062339935];
data_5C_GSH = [2.75049434	3.073727	3.287569894 2.701974735	2.547117781	3.301336316 3.188829217	3.336188032	3.344192729];
data_10C_GSH = [0.588210438	0.595487269	0.461359944 0.57994242	0.589410868	0.442962155 0.594261986	0.601690261	0.452682328 0.599193621	0.565188503	0.594261986 0.656389376	0.617118216	0.503155619 0.641802945	0.615802399	0.585824189 0.681158786	0.651944301	0.57762265 0.621099624	0.631972265	0.535828062 ];

% scatter plot of observed doubling times
data = {log10(pop_data_1C)  log10(data_4C) log10(data_5C) log10(data_6C) log10(data_7C) log10(data_8C) log10(data_9C) log10(data_10C) log10(data_14C) log10(data_30C)};
UnivarScatter(data,'Width',0.5,'RangeCut',rangecut,'PointSize',80,'xval',xval_contr,'Color',[0.0 0.4 0.8]);
UnivarScatter({log10(data_1C) log10(data_5C_GSH) log10(data_10C_GSH)},'Width',0.5,'RangeCut',rangecut,'PointSize',40,'xval',[1 5.02 10.33],'Color',[0.4 0.8 0.4]);

% figure layout
font_name = 'Arial';
font_size_tick = 14;
font_size_label = 14;
set(get(gca,'XAxis'),'FontSize', font_size_tick, 'FontName', font_name);
set(get(gca,'YAxis'),'FontSize', font_size_tick, 'FontName', font_name);
set(gca, 'Layer', 'top');
xlabel('Temperature (C)', 'FontName', font_name, 'FontSize',font_size_label);
ylabel('Doubling time (days)', 'FontName', font_name, 'FontSize',font_size_label);
set(gca, 'TickLength', [0.025, 0.025]); 
set(gca, 'LineWidth', 1);
set(gca, 'YMinorTick','Off');
set(gca, 'XMinorTick','Off');
set(gca,'Ytick',[-2 -1 0 1 2 3 4]);
set(gca,'Xtick',[0 10 20 30]);
set(gca,'YtickLabel',{'10^{-2}','10^{-1}',' 10^0',' 10^1',' 10^2',' 10^3',' 10^4'});
set(gca,'YLim',[-1.5 4]);
set(gca,'XLim',[0 31]);



function [dtmin dtmin_samples dtdelay] = sample_times(T, R, n_cells)
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