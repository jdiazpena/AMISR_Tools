% AMISR 2012
close all
clear 

fileNameStr = '20120122.001_bc_5min-Ne.h5';

data=AMISRdatafetch(fileNameStr);

[xx,yy,zz,xr,yr,zr]=AMISR3DinterpInit_bc(data);
MintimeStr='01/24/2012 10:30:00';
MaxtimeStr='01/24/2012 14:00:00';

mindesiretime=datenum(MintimeStr);
minindex=find(abs((data.timenum-mindesiretime))==min(abs(data.timenum-mindesiretime)));
maxdesiretime=datenum(MaxtimeStr);
maxindex=find(abs((data.timenum-maxdesiretime))==min(abs(data.timenum-maxdesiretime)));
timevector=minindex:maxindex;

sgrid=size(xx);

Neinterptime=zeros(length(timevector),sgrid(1),sgrid(2),sgrid(3));

az=60;
el=11;
xcut=50;  
ycut=100;
zcut=[50 150 200 250 300 350];

AMISRplotBeamsPattern(data)
% AMISRplotBeams3D(data,timeStr)

for i=1:2
    [Neinterp,Teinterp,Tiinterp,index]=AMISR3Dinterp(xx,yy,zz,xr,yr,zr,data,data.timestr(timevector(i),:));
    Neinterptime(i,:,:,:)=Neinterp;
    disp(['Finished Interpolation ', num2str(i),' of ', num2str(length(timevector))])
    timeStr=['RISR ','Ne ',data.timestr(timevector(i),1:17)];
    AMISR3Display(xx,yy,zz,xr,yr,zr,Neinterp,data,index,xcut,ycut,zcut,timeStr,az,el,[1 1 1],1);
    disp(['Finished Plotting Interpolation ', num2str(i),' of ', num2str(length(timevector))])
end
save AMISRdata5min.mat data xx yy zz xr yr zr timevector Neinterptime az el xcut ycut zcut
