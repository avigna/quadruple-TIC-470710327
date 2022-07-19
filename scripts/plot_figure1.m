function plot_figure1(val_AU,saveFlag)
tic;

% Macros
AUtoRsol = 215.032;

% Data
% Observational data: https://arxiv.org/pdf/2202.06964
i_measured = 16.8;
i_measured_max = i_measured+4.2;
i_measured_min = i_measured-1.4;

% Simulated data: ../data/Fig1/
filename = strcat('../data/Fig1/Evolution_A1_',num2str(val_AU),'.txt');
M=load(filename);

time    = M(:,1);           % 1.Time [Years]
e1      = M(:,2);           % 2.Eccentricity of 8+8 (Binary 1) e_1
a1      = M(:,3).*AUtoRsol; % 3.Semimajor axis of 8+8 (Binary 1) a_1 [AU]
i13     = M(:,4);           % 4.Inclination angle of 8+8 (Binary 1) I_13 [Degrees]
e2      = M(:,5);           % 5.Eccentricity of 6+6 (Binary 2) e_2
a2      = M(:,6).*AUtoRsol; % 6.Semimajor axis of 6+6 (Binary 2) a_2 [AU]
i23     = M(:,7);           % 7.Inclination angle of 6+6 (Binary 2) I_23 [Degrees]
ap1     = a1.*(1-e1);
ap2     = a2.*(1-e2);

RZAMS8          = 3.2931; % Obtained from COMPAS SSE (https://compas.science/)
RTAMS8          = 9.2691; % Obtained from COMPAS SSE (https://compas.science/)

% Plot
color1 = [0         0.4470    0.7410];
color2 = [0.8500    0.3250    0.0980];
   
fs=16;
lw=1.;
solar=char(9737);
stringRsun=['a_{p} [R_',solar,']'];  
xLims = [0 100];


clf
t=tiledlayout(2,1);

nexttile
hold on
plot(time,ap1,'Color',color1,'Linewidth',lw)
plot(time,ap2,'Color',color2,'Linewidth',lw)
plot(time,ap1.*calculateRocheRadius(1,1).*1.32,'k','Linewidth',lw)
yline(RTAMS8,'--','Color','k','Linewidth',2)
yline(RZAMS8,':','Color','k','Linewidth',2)
ylabel(stringRsun)
legend( '8+8',...
        '6+6',...
        'L_{2,8+8}',...
        'R_{8,max}',...
        'R_{8,ZAMS}',...        
        'location','northeast')
ax=gca;
ax.XTickLabel=[];
ax.XLim=xLims;
ax.YLim=[0, 20];
ax.FontSize=fs;
ax.FontName='Times New Roman';
box on


nexttile
hold on

observed_inclination=fill([0 180 180 0],[i_measured_min i_measured_min i_measured_max i_measured_max],'k','EdgeColor','none');
set(observed_inclination,'FaceAlpha',0.7);

plot(time,i13,'Color',color1,'Linewidth',lw,'HandleVisibility','off')
plot(time,i23,'Color',color2,'Linewidth',lw,'HandleVisibility','off')

legend( 'TIC 470710327',...
        'location','northeast',...
        'box','off')

ylim([0 90])
xlabel('time [yr]')
ylabel('i [deg]')
ax=gca;
ax.XLim=xLims;
ax.FontSize=fs;
ax.FontName='Times New Roman';
box on

t.TileSpacing = 'compact';
t.Padding = 'compact';

if saveFlag
    print(gcf,strcat('../plots/png/figure1.png'),'-dpng','-r300');
    saveas(gcf,strcat('../plots/pdf/figure1.pdf'))
end

toc;
end