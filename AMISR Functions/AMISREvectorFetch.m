function data=AMISREvectorFetch(fileNameStr)

data.lat0=h5read(fileNameStr,'/Site/Latitude');
data.lon0=h5read(fileNameStr,'/Site/Longitude');
data.mlat0=h5read(fileNameStr,'/Site/MagneticLatitude');
data.mlon0=h5read(fileNameStr,'/Site/MagneticLongitude');
data.alt0=h5read(fileNameStr,'/Site/Altitude');

Time= (h5read(fileNameStr,'/Time/UnixTime'));
dt = datetime( Time(1,:), 'ConvertFrom', 'posixtime' );
data.timestr=datestr( dt );
data.timenum=datenum( data.timestr );

data.Emag=h5read(fileNameStr,'/VectorVels/Emag');
data.Emaglat=h5read(fileNameStr,'/VectorVels/MagneticLatitude');
data.dEmag=h5read(fileNameStr,'/VectorVels/errEmag');

