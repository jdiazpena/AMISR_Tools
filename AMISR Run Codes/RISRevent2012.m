%RISR event managment data
clear
close all

labelsize=14;
arrowcolor1='black';
arrowcolor2='black';
StartTime = datenum(2012,01,24,12,05,00);
EndTime = datenum(2012,01,24,12,10,00);

datafile = '20120122.001_lp_5min.h5';
[Vx,Vy,Vi,dVi,Xr,Yr,T1,T2,utime,bco]=VlosAMISR(StartTime,EndTime,datafile);
t=T1;


%%Geographic latitude and longitude of Resolute bay
lat0=h5read(datafile,'/Site/Latitude');
lon0=h5read(datafile,'/Site/Longitude');
RE=6370;

radarheight=340;
opticalheight=280;


l=size(utime);
mtime = zeros(l(1),l(2));

%Converting the time from unix time to matlab time
for i1 = 1:l(1)
    for i2 = 1:l(2)
        mtime(i1,i2) = datenum([1970 1 1 0 0 double(utime(i1,i2))]); 
    end
end

tidstr =  datestr(mtime(1,t));
    tidstrstop = datestr(mtime(1,t+1));
    radartime = str2num(tidstr(13:14))+str2num(tidstr(16:17))/60+str2num(tidstr(19:20))/3600;
    radartimestop = str2num(tidstrstop(13:14))+str2num(tidstrstop(16:17))/60+str2num(tidstrstop(19:20))/3600;
    radaryear = str2num(datestr(mtime(1,t),11));
    radarmonth = str2num(datestr(mtime(1,t),5));
    radarday = str2num(datestr(mtime(1,t),7));


%Getting the positions of the radar beams from the radar data
% Azimuth and elevation in degrees
az = bco(2,:);% * pi/180;
el = bco(3,:);% * pi/180;  

figure(1); 
clf;
colormap gray
shading flat
caxis([0,500])
set(gcf,'renderer','zbuffer')
xlim([-600,600])
ylim([-600,600])
hold on
plot(0,0,'kp','MarkerEdgeColor',arrowcolor1,'MarkerFaceColor',arrowcolor1,'MarkerSize',12);
fac=5;
good1=find(Vi>=0 & abs(dVi./Vi)<0.25);
good2=find(Vi<0 & abs(dVi./Vi)<0.25);
% good1=find(Vi>=0 & dVi<60);
% good2=find(Vi<0 & dVi<60);

quiver(Xr(good1),Yr(good1),Vx(good1,t-T1+1)/fac,Vy(good1,t-T1+1)/fac,...
    'color',arrowcolor1,'linewidth',1.5,'autoscale','off','MaxHeadSize',.7);
 quiver(Xr(good2),Yr(good2),Vx(good2,t-T1+1)/fac,Vy(good2,t-T1+1)/fac,...
     'color',arrowcolor2,'linewidth',1.5,'autoscale','off','MaxHeadSize',.7);
%Legend

quiver(300,500,500/fac,0/fac,'color',arrowcolor1,'linewidth',1.5,'autoscale','off','MaxHeadSize',.7);
text(250,450,'0.5 km/s','color',arrowcolor1,'fontsize',16);
grid on

latplot=[45 90];
lonplot=[-120 -60];

ticks=15;
maptype='conical'; %north or cilindrical
timetype='ut';
linestep=1;
ttick=60;
scale=750;

mapgenerator(maptype,latplot,lonplot)
[xmin,ymin] = mfwdtran(65,-105);
[xmax,ymax] = mfwdtran(90,-75);
[x0,y0] = mfwdtran(lat0,lon0);

[lat1, lon1]=kmtolatlon(lat0,lon0,Yr,Xr);
plot(x0,y0,'kp','MarkerEdgeColor',arrowcolor1,'MarkerFaceColor',arrowcolor1,'MarkerSize',6);

r0=90-lat0;
phi0=lon0;
x0=r0*cosd(phi0);
y0=r0*sind(phi0);


% for i=1:length(lat1)
% r1=90-lat1(i);
% phi1=lon1(i);
% x1=r1*cosd(phi1);
% y1=r1*sind(phi1);
% m=(y1-y0)/(x1-x0);
% v=-[sign(x1-x0)*m,sign(x1-x0)];
% v=v/norm(v);
% xf=v(2)+x1;
% yf=v(1)+y1;
% [latf, lonf]=cart2latlon(xf,yf);
% linem([lat1(i) latf],[lon1(i) lonf],'k')
% end

lat1=lat1(good2);
lon1=lon1(good2);
Vi=Vi(good2);
factor=200;

for i=1:length(lat1)
r1=90-lat1(i);
phi1=lon1(i);
x1=r1*cosd(phi1);
y1=r1*sind(phi1);
m=(y1-y0)/(x1-x0);
v=[sign(x1-x0)*m,sign(x1-x0)];
v=v.*Vi(i)/(norm(v)*factor);
xf=v(2)+x1;
yf=v(1)+y1;
[latf, lonf]=cart2latlon(xf,yf);
linem([lat1(i) latf],[lon1(i) lonf],'k')
%q=quiverm(lat1(i),lon1(i),latf-lat1(i),lonf-lon1(i),0);
end

scatterm(lat1,lon1,5,Vi,'filled')
colormap(jet)
hc=colorbar;
title(hc,'V (m/s)');



