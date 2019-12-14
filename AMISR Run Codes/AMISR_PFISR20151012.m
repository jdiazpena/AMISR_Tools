% PFISR 2015
close all
clear 

fileNameStr = '20151012.001_ac_5min-cal.h5';
% fileNameStr = '20151012.001_lp_3min-cal.h5';

data=AMISRdatafetch_lp(fileNameStr);
% [xx,yy,zz,xr,yr,zr]=AMISR3DinterpInit(data);

AMISRplotBeamsPattern(data)
timeStr='10/12/2015 09:30:00';
AMISRplotBeams3D(data,timeStr)


% MintimeStr='01/24/2012 10:30:00';
% MaxtimeStr='01/24/2012 14:00:00';
% 
% mindesiretime=datenum(MintimeStr);
% minindex=find(abs((data.timenum-mindesiretime))==min(abs(data.timenum-mindesiretime)));
% maxdesiretime=datenum(MaxtimeStr);
% maxindex=find(abs((data.timenum-maxdesiretime))==min(abs(data.timenum-maxdesiretime)));
% timevector=minindex:maxindex;
% 
% sgrid=size(xx);
% 
% Neinterptime=zeros(length(timevector),sgrid(1),sgrid(2),sgrid(3));
% Teinterptime=zeros(length(timevector),sgrid(1),sgrid(2),sgrid(3));
% Tiinterptime=zeros(length(timevector),sgrid(1),sgrid(2),sgrid(3));
% 
% az=60;
% el=11;
% xcut=100;  
% ycut=200;
% zcut=[200 250 300 350 400 450];
% 
% AMISRplotBeamsPattern(data)
% % AMISRplotBeams3D(data,timeStr)
% 
% for i=1:length(timevector)
%     [Neinterp,Teinterp,Tiinterp,index]=AMISR3Dinterp(xx,yy,zz,xr,yr,zr,data,data.timestr(timevector(i),:));
%     Neinterptime(i,:,:,:)=Neinterp;
%     Teinterptime(i,:,:,:)=Teinterp;
%     Tiinterptime(i,:,:,:)=Tiinterp;
%     disp(['Finished Interpolation ', num2str(i),' of ', num2str(length(timevector))])
%     timeStr=['RISR ','Ne ',data.timestr(timevector(i),1:17)];
%     AMISR3Display(xx,yy,zz,xr,yr,zr,Neinterp,data,index,xcut,ycut,[200 250 300 350 400 450],timeStr,az,el,[1 0],1,'D:\JMDP\Google Drive\Matlab\Figures\',10);
%     disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
%     close all
% end
% save AMISRdata2d033.mat data xx yy zz xr yr zr timevector Neinterptime Teinterptime Tiinterptime az el xcut ycut zcut