%% Plot AMISR data 
close all
clear

load AMISR20151015Meghan.mat

variable=1;

az=60;
el=11;
xcut=0;  
ycut=0;
zcut=[200 250 300 350 400 450];

% for i=1:length(timevector)
%     desiretime=datenum(data.timestr(timevector(i),:));
%     index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));
%     Neinterp=squeeze(Neinterptime(i,:,:,:));
%     Teinterp=squeeze(Teinterptime(i,:,:,:));
%     Tiinterp=squeeze(Tiinterptime(i,:,:,:));
%     timeStr=['RISR ','Ne ',data.timestr(timevector(i),1:17)];
%     AMISR3Display(xx,yy,zz,xr,yr,zr,Neinterp,data,index,xcut,ycut,zcut,timeStr,az,el,[1 0],variable,'D:\JMDP\Google Drive\Matlab\Figures\Te\',10);
%     disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
%     close all
% end

    zcut=[340];
    xlimit=[-100 250];
    ylimit=[-150 250];
    zlimit=[0 500];

    i=65;
    desiretime=datenum(data.timestr(timevector(i),:));
    index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));
    Neinterp=squeeze(Neinterptime(i,:,:,:));
    Teinterp=squeeze(Teinterptime(i,:,:,:));
    Tiinterp=squeeze(Tiinterptime(i,:,:,:));
    timeStr=['PFISR ','Ne ',data.timestr(timevector(i),1:17)];
    AMISR3Display(xx,yy,zz,xr,yr,zr,Neinterp,data,index,xcut,ycut,zcut,xlimit,ylimit,zlimit,timeStr,az,el,[0 0],variable,'D:\JMDP\Google Drive\Matlab\Figures\Te\',10);
    disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])