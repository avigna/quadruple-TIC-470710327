function plot_figure3(saveFlag)
tic;

% Macros
AUtoRsol = 215.032;

% Data
% Simulated data: ../data/Fig3/
M=load('../data/Fig3/ContactFraction3.txt');

a1_AU           = M(:,1);           % 1.semimajor axis of 8+8 (Binary 1) a_1 [AU]
a1_Rsun         = a1_AU.*AUtoRsol;
fraction_short  = M(:,2);           % 2.Contact fraction (short)
fraction_long   = M(:,3);           % 3.Contact fraction (long)
beta            = M(:,4);           % 4.\beta

totalMass   = 16;
PeriodYrTicks    = sqrt((([5:5:40]./AUtoRsol).^3)./totalMass);
PeriodDayTicks   = round(PeriodYrTicks.*365,1);

RocheRadius8 = 8.7335;
limit_oscillations = 0.0664341*AUtoRsol;
limitForStability = 38;
indexOfInterest = find(a1_Rsun>=limit_oscillations-0.1);

% Plot
color1 = [0 0 0];
color3 = [145 30 180]./255; 


fs=16;
lw=1.5;
solar=char(9737);
stringRsun=['a_{8+8} [R_',solar,']'];  

clf
t = tiledlayout(1,1);
ax1 = axes(t);
hold on

ZAMSOverflow=fill([5 RocheRadius8 RocheRadius8 5],[0. 0.0 1. 1.],'k','EdgeColor','none','HandleVisibility','off');
set(ZAMSOverflow,'FaceAlpha',0.3);
textZAMSOverflow=text(6.75,0.3,'RLOF at ZAMS','Fontsize',fs,'Color','w','FontName','Times New Roman');
set(textZAMSOverflow,'Rotation',90);

shortRangeForces=fill([RocheRadius8 limit_oscillations limit_oscillations RocheRadius8],[0. 0.0 1. 1.],'k','EdgeColor','none','HandleVisibility','off');
set(shortRangeForces,'FaceAlpha',0.5);
textShortRangeForces=text(10.5,0.2,'tides damp oscillations','Fontsize',fs,'Color','w','FontName','Times New Roman');
set(textShortRangeForces,'Rotation',90);

unstableRegion=fill([limitForStability 43 43 limitForStability],[0. 0.0 1. 1.],'k','EdgeColor','none','HandleVisibility','off');
set(unstableRegion,'FaceAlpha',0.7);
textunstableRegion=text(40.5,0.7,'dynamically unstable','Fontsize',fs,'Color','w','FontName','Times New Roman');
set(textunstableRegion,'Rotation',270);

plot(ax1,a1_Rsun(indexOfInterest),fraction_long(indexOfInterest),'-','Color',color3,'Linewidth',lw)
plot(ax1,a1_Rsun(indexOfInterest),fraction_short(indexOfInterest),'--','Color',color3,'Linewidth',lw)

legend('\tau_{short}+\tau_{long}','\tau_{short}','box','on','Location','northeast')
xlabel(stringRsun,'FontSize',fs)
ylabel('$f$','FontSize',fs,'interpreter','latex')
ax1.XLim = [5 43];
ax1.YLim = [0 1.];
ax1.XColor = 'k';
ax1.YColor = color3;
ax1.FontSize = fs;
ax1.FontName='Times New Roman';


ax2 = axes(t);
plot(ax2,a1_Rsun,beta,'Color',color1,'Linewidth',lw)
ylabel('$\beta$','FontSize',fs,'interpreter','latex')
xlabel('P_{orb,8+8} [d]','FontSize',fs)
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.XLim = [5 43];
ax2.Color = 'none';
ax2.YColor = color1;
ax1.Box = 'off';
ax2.Box = 'off';
ax2.XTickLabel = [PeriodDayTicks];
ax2.YTick = [0.:0.2:1.3]
ax2.YLim = [0. 1.3];
ax2.FontSize = fs;
ax2.FontName='Times New Roman';

% Save
if saveFlag
    print(gcf,strcat('../plots/png/figure3.png'),'-dpng','-r300');
    saveas(gcf,strcat('../plots/pdf/figure3.pdf'))
end

toc;
end