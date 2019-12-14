function data=AMISRdatafetch_bc(fileNameStr)


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

data.beamalt=h5read(fileNameStr,'/NeFromPower/Altitude');
data.beamrange=h5read(fileNameStr,'/NeFromPower/Range');
data.NeMod=h5read(fileNameStr,'/NeFromPower/Ne_Mod');
data.Ne=h5read(fileNameStr,'/NeFromPower/Ne_NoTr');


Time= (h5read(fileNameStr,'/Time/UnixTime'));
dt = datetime( Time(1,:), 'ConvertFrom', 'posixtime' );
data.timestr=datestr( dt );
data.timenum=datenum( data.timestr );

data.type=3;