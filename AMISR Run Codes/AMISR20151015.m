% AMISR 2015 Meghan
close all
clear 

fileNameStr = '20151012.001_lp_3min-cal.h5';
data=AMISRdatafetch(fileNameStr,'lp');

altitudecut=inf; %in meters, always look at sumary plots to find this first and add one bin
factor=[1,1,1];

[xx,yy,zz,xr,yr,zr]=AMISR3DinterpInit(data,factor);
MintimeStr='12-Oct-2015 05:38:33';
MaxtimeStr='12-Oct-2015 11:56:58';

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
xcut=0;  
ycut=45;
zcut=100:50:450;

xlimit=[-200 250];
ylimit=[-100 200];
zlimit=[100 450];
altlimit=zlimit;
    
error=0;

AMISRplotBeamsPattern(data)
% AMISRplotBeams3D(data,timeStr)

for i=1:length(timevector)
    [Neinterp,Teinterp,Tiinterp,index]=AMISR3Dinterp(xx,yy,zz,xr,yr,zr,data,data.timestr(timevector(i),:),error,altitudecut);
    Neinterptime(i,:,:,:)=Neinterp;
    Teinterptime(i,:,:,:)=Teinterp;
    Tiinterptime(i,:,:,:)=Tiinterp;
    disp(['Finished Interpolation ', num2str(i),' of ', num2str(length(timevector))])
    timeStr=['PFISR ','Ne ',data.timestr(timevector(i),1:20)];
    AMISR3Display(xx,yy,zz,xr,yr,zr,Neinterp,data,index,xcut,ycut,zcut,xlimit,ylimit,zlimit,altlimit,timeStr,az,el,error+inf,[1 0],1,'D:\Google Drive\Matlab\Figures\',10);
    disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
    close all
end
save AMISR20151015Meghan.mat data xx yy zz xr yr zr timevector Neinterptime Teinterptime Tiinterptime az el xcut ycut zcut


