% PFISR velocity vectors data fetching
% Perp-North, Perp-East, Anti-Parallel)

close all
%fileNameStr='20170905.002_lp_1min-fitcal-vvelsLat-60sec.h5';
fileNameStr='20170905.002_lp_1min-fitcal-vvelsLat-60sec-geo.h5';
vvels=h5read(fileNameStr,'/VectorVels/Vest');
latitudes=h5read(fileNameStr,'/VectorVels/MagneticLatitude');
time=(h5read(fileNameStr,'/Time/UnixTime'));
slongitude=h5read(fileNameStr,'/Site/Longitude');
slatitude=h5read(fileNameStr,'/Site/Latitude');


dt = datetime( time(1,:), 'ConvertFrom', 'posixtime' );
timestr=datestr( dt );
timenum=datenum( timestr );

dataplot=squeeze(vvels(1,1,:));

timeMinStr='09/08/2017 15:00:00';
timeMaxStr='09/08/2017 20:00:00';
[initd, endd]=DMSPtimesi(timeMinStr,timeMaxStr,timenum);
indexes1=initd:1:endd;

eventtime=timenum(indexes1);
vvels=vvels(:,:,indexes1);
timeplot=timenum(indexes1);

[Bx1, By1, Bz1]= igrf(timeplot(1),slatitude,slongitude,200,'geodetic');
[Bx2, By2, Bz2]= igrf(timeplot(1),slatitude,slongitude,875,'geodetic');

%ratio=Bz1/Bz2;
ratio=1;

for i=1:12
    perpnorth=squeeze(vvels(1,i,:))*ratio;
    perpeast=squeeze(vvels(2,i,:))*ratio;
    figure
    plot(timeplot,perpnorth)
    hold on
    plot(timeplot,perpeast)
    label_time_axis(timeplot, true, 1/30, timeMinStr, timeMaxStr);
    grid on
end

max(max(vvels(1,:,:)))

