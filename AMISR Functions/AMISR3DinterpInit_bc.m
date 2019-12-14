function [xx, yy, zz, xr, yr, zr]=AMISR3DinterpInit_bc(data)

zr=data.beamalt/1000;
zr(zr<0)=NaN;
for i=1:length(data.beamdata) %beam number
    zr(:,i)=inpaint_nans(zr(:,i));
end
zrize=size(zr);

az=data.beamdata(2,:);
el=data.beamdata(3,:);
kx = sind(az) .* cosd(el);
ky = cosd(az) .* cosd(el);
rr=zr./sind(el);
xr = rr.*kx;
yr = rr.*ky;

for i=1:length(data.beamdata) %beam number
    xr(:,i)=inpaint_nans(xr(:,i));
    yr(:,i)=inpaint_nans(yr(:,i));
    zr(:,i)=inpaint_nans(zr(:,i));
end

yrmin=floor(min(min(yr)));
yrmax=ceil(max(max(yr)));
xrmin=floor(min(min(xr)));
xrmax=ceil(max(max(xr)));
zrmax=ceil(max(max(zr)));
zrmin=floor(min(min(yr)));


N1=meandistance(yr);
N2=meandistance(xr);
N3=meandistance(zr);
yrv=yrmin:0.5:yrmax;
xrv=xrmin:0.5:xrmax;
zrv=zrmin:0.5:zrmax;

yr=reshape(yr,[zrize(1)*zrize(2),1]);
xr=reshape(xr,[zrize(1)*zrize(2),1]);
zr=reshape(zr,[zrize(1)*zrize(2),1]);

for i=1:length(yr)
    indexyr=find(abs(yrv-yr(i))==min(abs(yrv-yr(i))));
    yr(i)=yrv(indexyr);
    
    indexxr=find(abs(xrv-xr(i))==min(abs(xrv-xr(i))));
    xr(i)=xrv(indexxr);
    
    indexzr=find(abs(zrv-zr(i))==min(abs(zrv-zr(i))));
    zr(i)=zrv(indexzr);
end
[xx, yy, zz]=meshgrid(xrv,yrv,zrv);



