function AMISRplotBeams3D(data,timeStr)

fontsize=12;

%timeStr='01/24/2012 12:07:00';
desiretime=datenum(timeStr);
index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));

Ne=data.Ne;
Ne=squeeze(Ne(:,:,index));
Ne(Ne<0)=NaN;
dNe=data.dNe;
dNe=squeeze(dNe(:,:,index));
Ne(dNe./Ne>0.7)=NaN;
Ne=log10(Ne);

cLabel='Density log10 /m^3';

alts=data.beamalt/1000;
for i=1:size(data.beamdata,2) %beam number
    alts(:,i)=inpaint_nans(alts(:,i));
end
altsize=size(alts);



az=data.beamdata(2,:);
el=data.beamdata(3,:);
range=data.beamrange/1000;
kx = sind(az) .* cosd(el);
ky = cosd(az) .* cosd(el);
kz = sind(el);
zr = alts;
rr=zr./sind(el);
xr = rr.*kx;
yr = rr.*ky;

for i=1:size(data.beamdata,2) %beam number
    xr(:,i)=inpaint_nans(xr(:,i));
    yr(:,i)=inpaint_nans(yr(:,i));
    zr(:,i)=inpaint_nans(zr(:,i));
end

xr=reshape(xr,[altsize(1)*altsize(2),1]);
yr=reshape(yr,[altsize(1)*altsize(2),1]);
zr=reshape(zr,[altsize(1)*altsize(2),1]);
Ne=reshape(Ne,[altsize(1)*altsize(2),1]);

figure
scatter3(0,0,data.alt0/1000,10,'filled','k')
ax=gca;
hold on
scatter3(yr,xr,zr,15,Ne,'filled')
ylabel('East of RISR-N [km]')
xlabel('North of RISR-N [km]')
zlabel('Altitude [km]')

hc=colorbar;
colormap('jet');
title(hc,cLabel);
caxis([10 11.5]);
set(ax,'Ydir','reverse')
set(ax,'fontsize',fontsize)
