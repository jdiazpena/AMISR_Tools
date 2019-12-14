%plotcentralbeams

BeamsEW=19:1:24;
BeamsNS=[3 4 9 10 15 16 21 22 27 28 33 34 39 40];


timeStr='01/24/2012 12:07:00';
desiretime=datenum(timeStr);
index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));

Ne=data.Ne;
%Ne=log10(Ne);
Ne=squeeze(Ne(:,:,index));
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
    %Ne(:,i)=inpaint_nans(Ne(:,i));
end

%Ne=log10(Ne);

xrEW=xr(:,BeamsEW);
yrEW=yr(:,BeamsEW);
zrEW=zr(:,BeamsEW);
NeEW=Ne(:,BeamsEW);

xrNS=xr(:,BeamsNS);
yrNS=yr(:,BeamsNS);
zrNS=zr(:,BeamsNS);
NeNS=Ne(:,BeamsNS);

yrsize=size(yrEW);
yrEWp=reshape(yrEW,[yrsize(1)*yrsize(2),1]);
zrEWp=reshape(zrEW,[yrsize(1)*yrsize(2),1]);
NeEWp=reshape(NeEW,[yrsize(1)*yrsize(2),1]);

xrsize=size(xrNS);
xrNSp=reshape(xrNS,[xrsize(1)*xrsize(2),1]);
zrNSp=reshape(zrNS,[xrsize(1)*xrsize(2),1]);
NeNSp=reshape(NeNS,[xrsize(1)*xrsize(2),1]);


figure
scatter(xrNSp,zrNSp,50,log10(NeNSp),'filled','s')
hold on
hc=colorbar;
colormap('jet');
% title(hc,cLabel);
%set(gca,'ColorScale','log')
hc.Label.String = 'Density';
set(hc,'LineWidth',1.5)
caxis([10 11.5]);








% xrp=reshape(xr,[altsize(1)*altsize(2),1]);
% yrp=reshape(yr,[altsize(1)*altsize(2),1]);
% zrp=reshape(zr,[altsize(1)*altsize(2),1]);
% Nep=reshape(Ne,[altsize(1)*altsize(2),1]);
% Nep=log10(Nep);