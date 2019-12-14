function [Neinterp, Teinterp, Tiinterp, index]=AMISR3Dinterp(xx,yy,zz, xr, yr, zr, data,timeStr,error,altcut)

% 0 erorr means use all the data

% timeStr='01/24/2012 12:07:00';
desiretime=datenum(timeStr);
index=find(abs((data.timenum-desiretime))==min(abs(data.timenum-desiretime)));

% error=1/3;

%% Ne Interpolation
Ne=data.Ne;
Ne=squeeze(Ne(:,:,index));
Ne(Ne<0)=NaN;

if error~=0
    dNe=data.dNe;
    dNe=squeeze(dNe(:,:,index));
    Ne(dNe./Ne>error)=NaN;
end

Ne=log10(Ne);

for i=1:length(data.beamdata) %beam number
    Ne(:,i)=inpaint_nans(Ne(:,i),3);
end

Ne(data.beamalt/1000>altcut)=NaN;

Ne=reshape(Ne,[size(Ne,1)*size(Ne,2),1]);

FNe = scatteredInterpolant([xr yr zr],Ne,'natural','none');
NeI = FNe(xx,yy,zz);

Neinterp=NeI;


if data.type ~= 3
%% Te Interpolation

    Te=data.Te;
    Te=squeeze(Te(:,:,index));
    if error~=0
        dTe=data.dTe;
        dTe=squeeze(dTe(:,:,index));
        Te(dTe./Te>error)=NaN;
    end 
    Te(Te<0)=NaN;

    for i=1:length(data.beamdata) %beam number
        Te(:,i)=inpaint_nans(Te(:,i),3);
    end

    Te=reshape(Te,[size(Te,1)*size(Te,2),1]);

    FTe = scatteredInterpolant([xr yr zr],Te,'natural','none');
    TeI = FTe(xx,yy,zz);

    Teinterp=TeI;

%% Ti Interpolation
    Ti=data.Ti;
    Ti=squeeze(Ti(:,:,index));
    if error~=0
        dTi=data.dTi;
        dTi=squeeze(dTi(:,:,index));
        Ti(dTi./Ti>error)=NaN;
    end 
    Ti(Ti<0)=NaN;

    for i=1:length(data.beamdata) %beam number
        Ti(:,i)=inpaint_nans(Ti(:,i),3);
    end

    Ti=reshape(Ti,[size(Ti,1)*size(Ti,2),1]);

    FTi = scatteredInterpolant([xr yr zr],Ti,'natural','none');
    TiI = FTi(xx,yy,zz);

    Tiinterp=TiI;
else
    Tiinterp=0;
    Teinterp=0;
end





% h=slice(xx,yy,zz,vq,0,-100,[220 250 280 310 340 400 450 500]);
% hold on
% set(h,'edgecolor','none')
% set(gca, 'YDir','reverse')
% %set(gca,'ColorScale','log')
% 
% hc=colorbar;
% colormap('jet');
% % title(hc,cLabel);
% hc.Label.String = 'Density';
% set(hc,'LineWidth',1.5)
% caxis([10 11.5]);

% zlim([200 600])
% xlim([latmin 79])
% ylim([lonmin -80])
