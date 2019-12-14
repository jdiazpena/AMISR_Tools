%% Plot AMISR data 
% close all
% clear
% 
load AMISR2mind033LP.mat
close all
variable=1;

az=60;
el=11;
xcut=100;  
ycut=200;
% zcut=[200 250 300 350 400 450 500 550 600];
zcut=[150 250 350 450 550];

error=1/3;
altitudecut=inf; %in meters, always look at sumary plots to find this first and add one bin

xlimit=[-100 415];
ylimit=[25 710];
zlimit=[120 710];
altlimit=[100 550];
savefigbool=[1 0];
variableplot=1;
savedirectory='D:\Google Drive\Matlab\Figures\Paper2019\Single';
% savedirectory='D:\JMDP\Google Drive\Matlab\Figures\';
fontsize=12;



% AMISRplotBeamsPattern(data)



for i=65:1:67
    desiretime=datenum(data.timestr(timevector(i),:));
    index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));
    Neinterp=squeeze(Neinterptime(i,:,:,:));
    Teinterp=squeeze(Teinterptime(i,:,:,:));
    Tiinterp=squeeze(Tiinterptime(i,:,:,:));
    timeStr=[data.timestr(timevector(i),13:end)];
    
%     timeStr=['RISR ','Ne ',data.timestr(timevector(i),1:17)];

%     AMISR3DisplaySingle(xx,yy,zz,xr,yr,zr,Neinterp,data,index,...
%                            xcut,ycut,zcut,xlimit,ylimit,zlimit...
%                            ,altlimit,timeStr,az,el,[1 0],variable,...
%                            'D:\Google Drive\Matlab\Figures\',10);
    AMISR3DisplaySingle(xx,yy,zz,xr,yr,zr,Neinterp,data,index,...
                           xcut,ycut,zcut,timeStr,az,el,[1 0],variable,...
                           savedirectory,fontsize);

    disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
end
% 
% for i=1:length(timevector)
%     desiretime=datenum(data.timestr(timevector(i),:));
%     index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));
%     Neinterp=squeeze(Neinterptime(i,:,:,:));
%     Teinterp=squeeze(Teinterptime(i,:,:,:));
%     Tiinterp=squeeze(Tiinterptime(i,:,:,:));
%     timeStr=['RISR ','Ne ',data.timestr(timevector(i),1:end)];
%     AMISR3Display(xx,yy,zz,xr,yr,zr,Neinterp,data,index,...
%                 xcut,ycut,zcut,xlimit,ylimit,zlimit,altlimit,...
%                 timeStr,az,el,error,savefigbool,variableplot,savedirectory,fontsize);
%     disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
%     close all
% end

% for i=1:length(timevector)
%     desiretime=datenum(data.timestr(timevector(i),:));
%     index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));
%     Neinterp=squeeze(Neinterptime(i,:,:,:));
%     Teinterp=squeeze(Teinterptime(i,:,:,:));
%     Tiinterp=squeeze(Tiinterptime(i,:,:,:));
%     timeStr=['RISR ','Ne ',data.timestr(timevector(i),1:end)];
%     AMISR3DisplaylargeP(xx,yy,zz,xr,yr,zr,Neinterp,data,index,...
%                 xcut,ycut,zcut,xlimit,ylimit,zlimit,altlimit,...
%                 timeStr,az,el,error,savefigbool,variableplot,savedirectory,fontsize);
%     disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
%     close all
% end