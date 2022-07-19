function plot_for_referee(saveFlag)
tic;

% Macros
AUtoRsol = 215.032;
val_AU = 0.09;
val_Rsun = val_AU*AUtoRsol;

% Data
% 8+8
filename_original = strcat('../data/Fig2/Window_A1_0.09.txt');
M_original=load(filename_original);
I_13_original        = cos((pi/180).*M_original(:,1));
max_e_1_original     = M_original(:,2);
max_I_13_original    = M_original(:,3);
min_I_13_original    = M_original(:,4);

% 10+6
filename_referee = strcat('../data/referee_report/Window_A1_0.09.txt');
M_referee=load(filename_referee);
I_13_referee        = cos((pi/180).*M_referee(:,1));
max_e_1_referee     = M_referee(:,2);
max_I_13_referee    = M_referee(:,3);
min_I_13_referee    = M_referee(:,4);

% Plot
color1 = [0    0.4470    0.7410];
color2 = [0.9290    0.6940    0.1250];
fs=16;
sz=5.0;
solar=char(9737);
stringRsun=['L_{\rm{2,min}} [R_',solar,']'];  
alphaNum = 0.5;


clf

t=tiledlayout(2,1);

nexttile
hold on

scatter(I_13_original,val_Rsun.*(1-max_e_1_original).*calculateRocheRadius(1,1).*1.32,sz,color1,'Filled')
scatter(I_13_referee,val_Rsun.*(1-max_e_1_referee).*calculateRocheRadius(1,1).*1.32,sz,color2,'Filled')

legend( '8+8',...
        '10+6',...
        'location','north',...
        'box','off')

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

i_range_heavy_original=patch([(I_13_original); flip(I_13_original)],[(min_I_13_original); flip(max_I_13_original)],color1,'EdgeColor','none');
set(i_range_heavy_original,'FaceAlpha',alphaNum);

i_range_heavy_referee=patch([(I_13_referee); flip(I_13_referee)],[(min_I_13_referee); flip(max_I_13_referee)],color2,'EdgeColor','none');
set(i_range_heavy_referee,'FaceAlpha',alphaNum);

legend( '8+8',...
        '10+6',...
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

% Save
if saveFlag
    print(gcf,strcat('../plots/png/plot_for_referee.png'),'-dpng','-r300');
    saveas(gcf,strcat('../plots/pdf/plot_for_referee.pdf'))
end

toc;
end