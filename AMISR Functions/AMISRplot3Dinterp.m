function AMISRplot3Dinterp(data,timeStr)

% timeStr='01/24/2012 12:07:00';
desiretime=datenum(timeStr);
index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));


lats=data.beamlat;
lons=data.beamlon;
alts=data.beamalt/1000;


for i=1:42 %beam number
    alts(:,i)=inpaint_nans(alts(:,i));
    %Ne(:,i)=inpaint_nans(Ne(:,i));
    lons(:,i)=inpaint_nans(lons(:,i));
    lats(:,i)=inpaint_nans(lats(:,i));
end

altsize=size(alts);

% lats=reshape(lats,[altsize(1)*altsize(2),1]);
% lons=reshape(lons,[altsize(1)*altsize(2),1]);
% alts=reshape(alts,[altsize(1)*altsize(2),1]);
% Ne=reshape(squeeze(Ne(:,:,index)),[altsize(1)*altsize(2),1]);

az=data.beamdata(2,:);
el=data.beamdata(3,:);
range=data.beamrange/1000;
kx = sind(az) .* cosd(el);
ky = cosd(az) .* cosd(el);
kz = sind(el);
zr = data.beamalt/1000;
rr=zr./sind(el);
xr = rr.*kx;
yr = rr.*ky;

for i=1:42 %beam number
    xr(:,i)=inpaint_nans(xr(:,i));
    yr(:,i)=inpaint_nans(yr(:,i));
    zr(:,i)=inpaint_nans(zr(:,i));
end

xrp=reshape(xr,[altsize(1)*altsize(2),1]);
yrp=reshape(yr,[altsize(1)*altsize(2),1]);
zrp=reshape(zr,[altsize(1)*altsize(2),1]);

% scatter3(lats,lons,alts,15,Ne,'filled')

% scatter3(lats(1,:),lons(1,:),alts(1,:),15,Ne(1,:,index),'filled')
% for i=2:altsize(1)
%     scatter3(lats(i,:),lons(i,:),alts(i,:),15,Ne(i,:,index),'filled')
% end


lons=xr;
lats=yr;
alts=zr;

latmin=floor(min(min(lats)));
latmax=ceil(max(max(lats)));
lonmin=floor(min(min(lons)));
lonmax=ceil(max(max(lons)));
altmax=ceil(max(max(alts)));
altmin=floor(min(min(lats)));

% N=50;
% N2=50;
N1=meandistance(lats);
N2=meandistance(lons);
N3=meandistance(alts);
latv=latmin:N1:latmax;
lonv=lonmin:N2:lonmax;
altv=altmin:N3/2:altmax;

lats=reshape(lats,[altsize(1)*altsize(2),1]);
lons=reshape(lons,[altsize(1)*altsize(2),1]);
alts=reshape(alts,[altsize(1)*altsize(2),1]);

for i=1:length(lats)
    indexlat=find(abs(latv-lats(i))==min(abs(latv-lats(i))));
    lats(i)=latv(indexlat);
    
    indexlon=find(abs(lonv-lons(i))==min(abs(lonv-lons(i))));
    lons(i)=lonv(indexlon);
    
    indexalt=find(abs(altv-alts(i))==min(abs(altv-alts(i))));
    alts(i)=altv(indexalt);
end

Ne=data.Ne;
Ne=squeeze(Ne(:,:,index));
Ne=reshape(Ne,[altsize(1)*altsize(2),1]);
Nep=log10(Ne);


%scatter3(lats,lons,alts,15,'filled','k')

[xx, yy, zz]=meshgrid(latv,lonv,altv);
F = scatteredInterpolant([lats lons alts],Nep,'natural','none');
vq = F(xx,yy,zz);


figure
%scatter3(data.lat0,data.lon0,data.alt0/1000,10,'filled','k')
scatter3(0,0,data.alt0/1000,10,'filled','k')
hold on
scatter3(yrp,xrp,zrp,15,Nep,'filled')
xlabel('Km North')
ylabel('Km East')
zlabel('Altitude')
h=slice(xx,yy,zz,vq,0,-100,[220 250 280 310 340 400 450 500]);
hold on
set(h,'edgecolor','none')
set(gca, 'YDir','reverse')
%set(gca,'ColorScale','log')

hc=colorbar;
colormap('jet');
% title(hc,cLabel);
hc.Label.String = 'Density';
set(hc,'LineWidth',1.5)
caxis([10 11.5]);

% zlim([200 600])
% xlim([latmin 79])
% ylim([lonmin -80])
