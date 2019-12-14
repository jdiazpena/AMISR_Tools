%spetrm test
fileNameStr = '20120122.001_lp_gated_acfs.h5';
data=h5read(fileNameStr,'/LP/GatedSpectra/Data');
f=h5read(fileNameStr,'/LP/GatedSpectra/Freqs');
r=h5read(fileNameStr,'/LP/GatedSpectra/Range');
r=r/1000;
[X,Y]=meshgrid(f,r);

Time= (h5read(fileNameStr,'/Time/UnixTime'));
dt = datetime( Time(1,:), 'ConvertFrom', 'posixtime' );
timestr=datestr( dt );
timenum=datenum(timestr );

fileNameStr = '20120122.001_lp_5min.h5';
radardata=AMISRdatafetch(fileNameStr);
el=radardata.beamdata(3,:);
zr=340;
%rr=zr./sind(el);

desiretime='24-Jan-2012 12:46:35';

desiretime=datenum(desiretime);
index=find(abs((timenum-desiretime))==min(abs(timenum-desiretime)));
% indexalt=find(abs((r-rr))==min(abs(r-rr)));


figure
hold on
for i=[42]
    elev=el(i);
    rr=zr./sind(elev);
    indexalt=find(abs((r-rr))==min(abs(r-rr)));
    plot(f,data(indexalt,:,i,index))
end
legend('1','2','3','7','8','9','13','14','15')
xlabel('Frequency (kHz)')
ylabel('Amplitude')
title('Beam spectra at 340km')
grid on

% figure
% subplot(1,2,1)
% a=(squeeze(data(:,:,i,index)));
% p=pcolor(X,Y,a);
% title(['Beam ', num2str(i)])
% colormap('jet')
% colorbar
% xlabel('Freq')
% ylabel('Range')
% set(p,'edgecolor','none')
% 
% subplot(1,2,2)
% a=(squeeze(data(:,:,i,index)));
% p=pcolor(X,Y,a);
% title(['Beam ', num2str(i)])
% colormap('jet')
% colorbar
% xlabel('Freq')
% ylabel('Range')
% set(p,'edgecolor','none')
% set(gca,'ColorScale','log')


