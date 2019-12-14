clear
close all

initialTime='24-Jan-2012 10:28:58';
FinalTime='24-Jan-2012 13:59:10';

% load AMISR2mind033LP.mat
load AMISRold2min

xcut=100;  
% ycut=155;
ycut=200;
ticks=8;

xaxis=squeeze(xx(1,:,1));
yaxis=squeeze(yy(:,1,1));
zaxis=squeeze(zz(1,1,:));

yindex=find(abs((ycut-yaxis))==min(abs(ycut-yaxis)));
xindex=find(abs((xcut-xaxis))==min(abs(xcut-xaxis)));
DataCut=squeeze(Neinterptime(:,yindex,xindex,:));
Tecut=squeeze(Teinterptime(:,yindex,xindex,:));
Ticut=squeeze(Tiinterptime(:,yindex,xindex,:));

% Find closest time to desire interval
indexes=timevector;

% Set time and other variables for panel 11 (interpolated)
time=data.timenum(timevector);
% Set time and data for other panels (cardinals points)
Ne=data.Ne(:,:,timevector);
Ne(Ne<0)=NaN;
Ne=log10(Ne);
NeNorth=squeeze(Ne(:,1,:));
NeEast=squeeze(Ne(:,6,:));
NeSouth=squeeze(Ne(:,42,:));
NeWest=squeeze(Ne(:,37,:));




deltax=0.22;
fontsize=12;


% Plot Energy
fig=figure;
s1=subplot(3,1,1);
set(s1, 'Position', get(s1,'Position')-[0.05 0.025 -0.03 -0.055]);
originalSize1 = get(s1, 'Position');

h=pcolor(time,zaxis,DataCut');
hold on;
title('Ne at 100km East/150km North of RISR-N')
set(h,'EdgeColor','none'); 
ax1 = gca;
drawnow; pause(0.1);
yruler = ax1.YRuler;
yruler.Axle.Visible = 'off';
xruler = ax1.XRuler;
xruler.Axle.Visible = 'off';

shading flat;
set(ax1,'Layer','top')
caxis([10 11.5]);
colormap(jet)
y1=ylabel('Altitude (Km)','fontsize',fontsize);
ylim([140 600]);
cb1=colorbar;
ylabel(cb1,'log10(Ne)')
set(s1, 'Position', originalSize1);


% Plot ratios
s2=subplot(3,1,2);
set(s2, 'Position', get(s1,'Position')-[0 deltax+0.09 0 0]);
% h2=pcolor(time,squeeze(data.beamalt(:,1)/1000),NeNorth);
h2=pcolor(time,zaxis,Tecut');
hold on;
title('Electron Temperature')
ax2 = gca;
drawnow; pause(0.1);
yruler = ax2.YRuler;
yruler.Axle.Visible = 'off';
xruler = ax2.XRuler;
xruler.Axle.Visible = 'off';
shading flat;
set(ax2,'Layer','top')
caxis([0 2500]);
colormap(jet)
y2=ylabel('Altitude (Km)','fontsize',fontsize);
ylim([140 600]);






% Plot ratios

s3=subplot(3,1,3);
set(s3, 'Position', get(s2,'Position')-[0 deltax+0.09 0 0]);
originalSize3 = get(s3, 'Position');
% h3=pcolor(time,squeeze(data.beamalt(:,42)/1000),NeSouth);
h3=pcolor(time,zaxis,Ticut');
hold on;
ax3 = gca;
title('Ion Temperature')
drawnow; pause(0.1);
yruler = ax3.YRuler;
yruler.Axle.Visible = 'off';
xruler = ax3.XRuler;
xruler.Axle.Visible = 'off';
shading flat;
set(ax3,'Layer','top')
caxis([0 2500]);
colormap(jet)
y3=ylabel('Altitude (Km)','fontsize',fontsize);
cb2=colorbar('location','eastoutside');
ylabel(cb2,'T (K)')
set(s3, 'Position', originalSize3);
ylim([140 600]);



% %Plot Te
% s4=subplot(4,1,4);
% set(s4, 'Position', get(s3,'Position')-[0 deltax 0 0]);
% h4=pcolor(time,zaxis,DataCut');
% hold on;
% ax4 = gca;
% drawnow; pause(0.2);
% yruler = ax4.YRuler;
% yruler.Axle.Visible = 'off';
% xruler = ax4.XRuler;
% xruler.Axle.Visible = 'off';
% shading flat;
% set(ax4,'Layer','top')
% caxis([10 11.5]);
% colormap(jet)



% y4=ylabel('Temperature [K]','fontsize',fontsize);

txtHandle = text(-0.045, -0.07, 'UT','Units','normalized','FontSize',fontsize);
set(txtHandle, 'HorizontalAlignment','right','VerticalAlignment','middle');




% Get ylabel locations and set to the furthest one

y1pos=get(y1,'pos');
y2pos=get(y2,'pos');
y3pos=get(y3,'pos');
% y4pos=get(y4,'pos');
minx=max([y1pos(1),y2pos(1),y3pos(1)]);
set(y1,'Pos',[minx y1pos(2) y1pos(3)])
set(y2,'Pos',[minx y2pos(2) y2pos(3)])
set(y3,'Pos',[minx y3pos(2) y3pos(3)])



% axis for lonlat
set(ax1,'Units','normalized','fontsize',fontsize,'XColor','k','Color','w');
set(ax2,'Units','normalized','fontsize',fontsize,'XColor','k','Color','w');
set(ax3,'Units','normalized','fontsize',fontsize);


hpos=get(cb1,'Position');
set(cb1, 'Position', [hpos(1)-0.01 hpos(2) .0581/5 hpos(4)],'fontsize',12)
set(cb1,'Ticks',linspace(10,11.5,6))

hpos2=get(cb2,'Position');
set(cb2, 'Position', [hpos(1)-0.01 hpos2(2) .0581/5 hpos2(4)*2.15],'fontsize',12)
% set(cb2,'Ticks',linspace(10,11.5,6))


timem=time;
 % set limits and labels
set(ax1,'xlim',[min(timem) max(timem)]);
set(ax2,'xlim',[min(timem) max(timem)]);
set(ax3,'xlim',[min(timem) max(timem)]);



mintime=datenum('01/24/2012 10:00:00');
maxtime=datenum('01/24/2012 11:30:00');

set(ax1,'xlim',[mintime maxtime]);
set(ax2,'xlim',[mintime maxtime]);
set(ax3,'xlim',[mintime maxtime]);

timeticks=linspace(mintime,maxtime,ticks);
timeticksstr=datestr(timeticks);
timeticksstrfinal=timeticksstr(:,13:17);

% pticks=ticks;
% ti=pticks;
% cx=zeros([1,ti]);
% size2=length(timevector);
% 
% cx(1)=1;
% cx(end)=size2;
% 
% for i=2:ti
%     cx(i)=(1+(i-1)*round(size2/ti));
% end
% 
% tick1=timem(cx)';
% 
% 
% tick0=cell([1,ti]);
% for i=1:ti
%     stringaux=datestr(timem(cx(i)));
%     tick0{i}=stringaux(13:17);
% end
% 
xticks(ax1,timeticks);
xticklabels(ax1,[])
xticks(ax2,timeticks);
xticklabels(ax2,[])
xticks(ax3,timeticks);
xticklabels(ax3,timeticksstrfinal)


print(fig,'AMISR1Dcut','-fillpage','-dpdf','-r300','-opengl')
    fig.PaperUnits='inches';
    fig.PaperPosition = [0 0 8 9];
    print(fig,'AMISR1Dcut','-dpng','-r300','-opengl')


