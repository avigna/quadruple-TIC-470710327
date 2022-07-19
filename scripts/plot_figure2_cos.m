function plot_figure2_cos(val_AU,saveFlag)
tic;

% Macros
AUtoRsol = 215.032;
val_Rsun = val_AU*AUtoRsol;

% Data
% Observational data: https://arxiv.org/pdf/2202.06964
i_measured = 16.8;
i_measured_max = i_measured+4.2;
i_measured_min = i_measured-1.4;

% Simulated data: ../data/Fig2/
filename = strcat('../data/Fig2/Window_A1_',num2str(val_AU),'.txt');
M=load(filename);

I_13        = cos((pi/180).*M(:,1));    % 1.Initial I_13 [Degrees]
max_e_1     = M(:,2);                   % 2.Maximum eccentricity e_1
max_I_13    = M(:,3);                   % 3.Maximum of I_13 [Degrees]
min_I_13    = M(:,4);                   % 4.Minimum of I_13 [Degrees]
max_e_2     = M(:,5);                   % 5.Maximum eccentricity e_2
max_I_23    = M(:,6);                   % 6.Maximum of I_23 [Degrees]
min_I_23    = M(:,7);                   % 7.Minimum of I_23 [Degrees]

AnalyticalEmax = load('../data/Fig2/AnalyticalEmax.txt');
cos_i_analytical_e_max  = cos(pi.*AnalyticalEmax(:,1)./180);
e_max                   = AnalyticalEmax(:,2);

RZAMS8          = 3.2931; % Obtained from COMPAS SSE (https://compas.science/)
RTAMS8          = 9.2691; % Obtained from COMPAS SSE (https://compas.science/)

% Plot
color1 = [0    0.4470    0.7410];
color2 = [    0.8500    0.3250    0.0980];
fs=16;
fs2=18;
sz=5.0;
solar=char(9737);
stringRsun=['L_{\rm{2,min}} [R_',solar,']'];  
alphaNum = 0.5;


clf

t=tiledlayout(2,1);

nexttile
hold on

minNuc_1 = 42.2686;
maxNuc_1 = 64.2147;

minNuc_2 = 122.141;
maxNuc_2 = 141.721;

minDyn = maxNuc_1;
maxNuc = minNuc_2;

long_merger_region_1  =   fill(cos((pi/180).*[minNuc_1 maxNuc_1 maxNuc_1 minNuc_1]),[0 0 20 20],'k','EdgeColor','none','HandleVisibility','off');
set(long_merger_region_1,'FaceAlpha',0.3);
long_merger_region_2  =   fill(cos((pi/180).*[minNuc_2 maxNuc_2 maxNuc_2 minNuc_2]),[0 0 20 20],'k','EdgeColor','none','HandleVisibility','off');
set(long_merger_region_2,'FaceAlpha',0.3);

early_merger_region  =   fill(cos((pi/180).*[minDyn maxNuc maxNuc minDyn]),[0 0 20 20],'k','EdgeColor','none','HandleVisibility','off');
set(early_merger_region,'FaceAlpha',alphaNum);

height = 11;
text(-0.725,height,'$\tau_{\rm{long}}$','Color','w','interpreter','latex','fontsize',fs2,'FontWeight','bold')
text(-0.05,height,'$\tau_{\rm{short}}$','Color','w','interpreter','latex','fontsize',fs2,'FontWeight','bold')
text(0.55,height,'$\tau_{\rm{long}}$','Color','w','interpreter','latex','fontsize',fs2,'FontWeight','bold')

scatter(I_13,val_Rsun.*(1-max_e_1).*calculateRocheRadius(1,1).*1.32,sz,color1,'Filled')
plot(cos_i_analytical_e_max,val_Rsun.*(1-e_max).*calculateRocheRadius(1,1).*1.32,'Color',color1,'LineWidth',1)
scatter(I_13,val_Rsun.*(1-max_e_2).*calculateRocheRadius(1,1).*1.32,sz,color2,'Filled')

yline(RTAMS8,'--k','LineWidth',2)
yline(RZAMS8,':k','LineWidth',2)

ylabel(stringRsun)
ax1=gca;
ax1.XTick = [-1:0.2:1];
ax1.XTickLabel = [];
ax1.YLim=[0 12];
ax1.YTick=[0:2:12];
ax1.FontSize=fs;
ax1.FontName='Times New Roman';
ax1.XAxisLocation = 'top';
box on

nexttile
hold on

observed_inclination=fill([-1 1 1 -1],[i_measured_min i_measured_min i_measured_max i_measured_max],'k','EdgeColor','none');
set(observed_inclination,'FaceAlpha',0.7);


i_range_heavy=patch([(I_13); flip(I_13)],[(min_I_13); flip(max_I_13)],color1,'EdgeColor','none');
set(i_range_heavy,'FaceAlpha',0.5);

i_range_light=patch([I_13; flip(I_13)],[min_I_23; flip(max_I_23)],color2,'EdgeColor','none');
set(i_range_light,'FaceAlpha',0.5);

legend( 'TIC 470710327',...
        '8+8',...
        '6+6',...
        'location','northeast',...
        'box','off')

xlabel('cos(i_{8+8,initial}/deg)')
ylabel('i [deg]')
ax2=gca;
ax2.YLim=[0 180];
ax2.XTick = [-1:0.2:1];
ax2.FontSize=fs;
ax2.FontName='Times New Roman';
box on

t.TileSpacing = 'compact';
t.Padding = 'compact';

if saveFlag
    print(gcf,strcat('../plots/png/figure2_cos.png'),'-dpng','-r300');
    saveas(gcf,strcat('../plots/pdf/figure2_cos.pdf'))
end

toc;
end