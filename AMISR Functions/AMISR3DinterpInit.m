function [xx, yy, zz, xr, yr, zr]=AMISR3DinterpInit(data,factor)

zr=data.beamalt/1000;
zr(zr<0)=NaN;
for i=1:length(data.beamdata) %beam number
    zr(:,i)=inpaint_nans(zr(:,i),3);
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
    xr(:,i)=inpaint_nans(xr(:,i),3);
    yr(:,i)=inpaint_nans(yr(:,i),3);
    zr(:,i)=inpaint_nans(zr(:,i),3);
end


% rowdim=max(sum(zr(:,:)<altitudecut));
% zr=zr(1:rowdim,:);
% yr=yr(1:rowdim,:);
% xr=xr(1:rowdim,:);

yrmin=floor(min(min(yr)));
yrmax=ceil(max(max(yr)));
xrmin=floor(min(min(xr)));
xrmax=ceil(max(max(xr)));
zrmax=ceil(max(max(zr)));
zrmin=floor(min(min(zr)));

N1=meandistance(xr);
N2=meandistance(yr);
N3=meandistance(zr);

xrv=linspace(xrmin,xrmax,ceil((xrmax-xrmin)/(N1*factor(1))));
yrv=linspace(yrmin,yrmax,ceil((yrmax-yrmin)/(N2*factor(2))));
zrv=linspace(zrmin,zrmax,ceil((zrmax-zrmin)/(N3*factor(3))));

zrize=size(zr);
yr=reshape(yr,[zrize(1)*zrize(2),1]);
xr=reshape(xr,[zrize(1)*zrize(2),1]);
zr=reshape(zr,[zrize(1)*zrize(2),1]);

% for i=1:length(yr)
%     indexyr=find(abs(yrv-yr(i))==min(abs(yrv-yr(i))));
%     yr(i)=yrv(indexyr);
%     
%     indexxr=find(abs(xrv-xr(i))==min(abs(xrv-xr(i))));
%     xr(i)=xrv(indexxr);
%     
%     indexzr=find(abs(zrv-zr(i))==min(abs(zrv-zr(i))));
%     zr(i)=zrv(indexzr);
% end

aux=input(['Grid size will be: ' num2str(length(yrv)) 'x' num2str(length(xrv)) 'x' num2str(length(zrv))]);

[xx, yy, zz]=meshgrid(xrv,yrv,zrv);



