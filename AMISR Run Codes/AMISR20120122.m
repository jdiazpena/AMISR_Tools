% AMISR 2012
close all
clear 

% fileNameStr = '20120122.001_lp_5min.h5';
fileNameStr = '20120122.001_lp_2min-fitcal.h5';

data=AMISRdatafetch(fileNameStr,'lp');

factor=[1.2,4/5,0.60];

[xx,yy,zz,xr,yr,zr]=AMISR3DinterpInit(data,factor);
MintimeStr='01/24/2012 09:00:00';
MaxtimeStr='01/24/2012 14:00:00';

mindesiretime=datenum(MintimeStr);
minindex=find(abs((data.timenum-mindesiretime))==min(abs(data.timenum-mindesiretime)));
maxdesiretime=datenum(MaxtimeStr);
maxindex=find(abs((data.timenum-maxdesiretime))==min(abs(data.timenum-maxdesiretime)));
timevector=minindex:maxindex;

sgrid=size(xx);

Neinterptime=zeros(length(timevector),sgrid(1),sgrid(2),sgrid(3));
Teinterptime=zeros(length(timevector),sgrid(1),sgrid(2),sgrid(3));
Tiinterptime=zeros(length(timevector),sgrid(1),sgrid(2),sgrid(3));

az=60;
el=11;
xcut=100;  
ycut=200;
zcut=[200 250 300 350 400 450 500 550 600];
error=1/3;
altitudecut=inf; %in meters, always look at sumary plots to find this first and add one bin

xlimit=[-150 450];
ylimit=[0 750];
zlimit=[0 800];
altlimit=zlimit;
savefigbool=[1 0];
variableplot=1;
% savedirectory='D:\Google Drive\Matlab\Figures\';
savedirectory='D:\JMDP\Google Drive\Matlab\Figures\New Figures Paper\';
fontsize=10;

AMISRplotBeamsPattern(data)
% AMISRplotBeams3D(data,timeStr)

for i=1:length(timevector)
    [Neinterp,Teinterp,Tiinterp,index]=AMISR3Dinterp(xx,yy,zz,xr,yr,zr,data,...
                                                    data.timestr(timevector(i),:),error,altitudecut);
    Neinterptime(i,:,:,:)=Neinterp;
    Teinterptime(i,:,:,:)=Teinterp;
    Tiinterptime(i,:,:,:)=Tiinterp;
    disp(['Finished Interpolation ', num2str(i),' of ', num2str(length(timevector))])
    timeStr=['RISRN ','Ne ',data.timestr(timevector(i),1:20)];
    AMISR3Display(xx,yy,zz,xr,yr,zr,Neinterp,data,index,...
                xcut,ycut,zcut,xlimit,ylimit,zlimit,altlimit,...
                timeStr,az,el,error,savefigbool,variableplot,savedirectory,fontsize);
    disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
    close all
end
save AMISR2mind033LP.mat data xx yy zz xr yr zr timevector Neinterptime Teinterptime Tiinterptime az el xcut ycut zcut





