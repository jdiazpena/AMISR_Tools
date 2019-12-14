function data=AMISRdatafetch(fileNameStr)


% fileNameStr = '20120122.001_lp_5min.h5';
% % timeMinStr='01/24/2012 11:00:00';
% % timeMaxStr='01/24/2012 13:00:00';

data.lat0=h5read(fileNameStr,'/Site/Latitude');
data.lon0=h5read(fileNameStr,'/Site/Longitude');
data.mlat0=h5read(fileNameStr,'/Site/MagneticLatitude');
data.mlon0=h5read(fileNameStr,'/Site/MagneticLongitude');
data.alt0=h5read(fileNameStr,'/Site/Altitude');


data.beamdata=h5read(fileNameStr,'/BeamCodes');
data.beamlat=h5read(fileNameStr,'/Geomag/Latitude');
data.beamlon=h5read(fileNameStr,'/Geomag/Longitude');
data.beamaglat=h5read(fileNameStr,'/Geomag/MagneticLatitude');
data.beamaglon=h5read(fileNameStr,'/Geomag/MagneticLongitude');

data.beamalt=h5read(fileNameStr,'/FittedParams/Altitude');
data.beamrange=h5read(fileNameStr,'/FittedParams/Range');


data.Ne=h5read(fileNameStr,'/FittedParams/Ne');
data.fits=h5read(fileNameStr,'/FittedParams/Fits');
T_i=data.fits(2,1,:,:,:);
data.Ti=reshape(T_i,size(T_i,3),size(T_i,4),size(T_i,5));
T_e=data.fits(2,end,:,:,:);
data.Te=reshape(T_e,size(T_e,3),size(T_e,4),size(T_e,5));
V_los=data.fits(4,1,:,:,:);
data.vlos=reshape(V_los,size(V_los,3),size(V_los,4),size(V_los,5));

data.errors=h5read(fileNameStr,'/FittedParams/Errors');
dT_i=data.errors(2,1,:,:,:);
data.dTi=reshape(dT_i,size(dT_i,3),size(dT_i,4),size(dT_i,5));
dT_e=data.errors(2,2,:,:,:);
data.dTe=reshape(dT_e,size(dT_e,3),size(dT_e,4),size(dT_e,5));
dV_los=data.errors(4,1,:,:,:);
data.dvlos=reshape(dV_los,size(dV_los,3),size(dV_los,4),size(dV_los,5));

data.dNe=h5read(fileNameStr,'/FittedParams/dNe');


Time= (h5read(fileNameStr,'/Time/UnixTime'));
dt = datetime( Time(1,:), 'ConvertFrom', 'posixtime' );
data.timestr=datestr( dt );
data.timenum=datenum( data.timestr );

% desiretime=datenum(timeMinStr);
% data.indexi=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));
% 
% desiretime=datenum(timeMaxStr);
% data.indexe=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));
