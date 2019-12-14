function AMISR3DisplaylargeP(XX,YY,ZZ,XR,YR,ZR,INTERPVAR,RADARDATA,INDEXPLOT,LONCUT,LATCUT,...
    ALTCUT,XLIMIT,YLIMIT,ZLIMIT,ALTLIMIT,TIMESTRTITLE,AZ,EL, ERROR,SAVEFIGBOOL,VARIABLEPLOT,SAVEDIRECTORY,FONTSIZE)
%north: 1 is north, 0 is south
%east' 1 is east, 0 is west
%VARIABLEPLOT: 1=Ne, 2=Te, 3=Ti;



if VARIABLEPLOT==1 %Ne
    Ne=RADARDATA.Ne;
    Ne=squeeze(Ne(:,:,INDEXPLOT));
    Ne(Ne<0)=NaN;
    dNe=RADARDATA.dNe;
    dNe=squeeze(dNe(:,:,INDEXPLOT));
    Ne(dNe./Ne>ERROR)=NaN;
    Ne=log10(Ne);

    Nesize=size(Ne);
    scatterRADARDATA=reshape(Ne,[Nesize(1)*Nesize(2),1]);
    strName='Ne';
    titlestr='log10(Ne)';
end
if VARIABLEPLOT==2 %Te
    Te=RADARDATA.Te;
    Te=squeeze(Te(:,:,INDEXPLOT));
    dTe=RADARDATA.dTe;
    dTe=squeeze(dTe(:,:,INDEXPLOT));
    Te(dTe./Te>ERROR)=NaN;
    Te(Te<0)=NaN;
    scatterRADARDATA=reshape(Te,[size(Te,1)*size(Te,2),1]);
    strName='Te';
    titlestr='Te (K)';
end
if VARIABLEPLOT==3 %Ti
    Ti=RADARDATA.Ti;
    Ti=squeeze(Ti(:,:,INDEXPLOT));
    dTi=RADARDATA.dTi;
    dTi=squeeze(dTi(:,:,INDEXPLOT));
    Ti(dTi./Ti>ERROR)=NaN;
    Ti(Ti<0)=NaN;
    scatterRADARDATA=reshape(Ti,[size(Ti,1)*size(Ti,2),1]);
    strName='Ti';
    titlestr='Ti (K)';
end

if RADARDATA.radar==91
    siteStr='RISR-N';
end
if RADARDATA.radar==92
    siteStr='RISR-C';
end
if RADARDATA.radar==61
    siteStr='PFISR';
end



xaxis=squeeze(XX(1,:,1));
yaxis=squeeze(YY(:,1,1));


yINDEXPLOT=find(abs((LATCUT-yaxis))==min(abs(LATCUT-yaxis)));
xINDEXPLOT=find(abs((LONCUT-xaxis))==min(abs(LONCUT-xaxis)));
xcut=(INTERPVAR(:,xINDEXPLOT,:));
ycut=(INTERPVAR(yINDEXPLOT,:,:));



fig=figure;
XX2=squeeze(XX(yINDEXPLOT,:,:));
ZZ2=squeeze(ZZ(yINDEXPLOT,:,:));
ax(1)=subplot(7,1,[1 2]);
hold on
pos=get(ax(1),'Position');
set(ax(1), 'Position',pos -[0.02 -0.04 0 pos(4)-0.18]);
h2=pcolor(XX2,ZZ2,squeeze(ycut));
title({[TIMESTRTITLE 'UT [MLT=' num2str(RADARDATA.mlt(INDEXPLOT)) ']'];[strName,' at ', num2str(LATCUT), ' km north of ' siteStr]},'FONTSIZE',FONTSIZE)
xlabel(['East of ' siteStr ' [Km]'],'FONTSIZE',FONTSIZE)
ylabel('Altitude [Km]','FONTSIZE',FONTSIZE)
set(h2,'edgecolor','none')
grid on
xlim(XLIMIT)
ylim(ZLIMIT)
if VARIABLEPLOT==1
    caxis([10 11.5]);
end
if VARIABLEPLOT==2
    caxis([0 2500]);
end
if VARIABLEPLOT==3
    caxis([500 2500]);
end

YY1=squeeze(YY(:,xINDEXPLOT,:));
ZZ1=squeeze(ZZ(:,xINDEXPLOT,:));
ax(3)=subplot(7,1,[6 7]);
hold on
set(ax(3), 'Position', get(ax(3),'Position')-[0.02 0.076 0.0 0.0]);
h2=pcolor(YY1,ZZ1,squeeze(xcut));
xlabel(['North of ' siteStr ' [Km]'],'FONTSIZE',FONTSIZE)
ylabel('Altitude [Km]','FONTSIZE',FONTSIZE)
title({[strName,' at ', num2str(LONCUT), ' km east of RISR-N']},'FONTSIZE',FONTSIZE)
set(h2,'edgecolor','none')
grid on
xlim(YLIMIT)
ylim(ZLIMIT)
if VARIABLEPLOT==1
    caxis([10 11.5]);
end
if VARIABLEPLOT==2
    caxis([0 2500]);
end
if VARIABLEPLOT==3
    caxis([500 2500]);
end

ax(2)=subplot(7,1,[3 4 5]);
hold on
scatter3(0,0,RADARDATA.alt0/1000,10,'filled','k')
scatter3(XR,YR,ZR,15,scatterRADARDATA,'filled')
h1=slice(XX,YY,ZZ,INTERPVAR,[],[],ALTCUT,'nearest');
view(AZ,EL)
pos=get(ax(2),'pos');
set(ax(2), 'Position', pos-[0.01 (pos(2)-0.338) 0.01 -0.02]);
ylabel('North [Km]','FONTSIZE',FONTSIZE)
xlabel('East [Km]','FONTSIZE',FONTSIZE)
zlabel('Altitude [Km]','FONTSIZE',FONTSIZE)
set(h1,'edgecolor','none')
set(gca, 'YDir','reverse')
grid on
%set(gca,'ColorScale','log')
if VARIABLEPLOT==1
    caxis([10 11.5]);
end
if VARIABLEPLOT==2
    caxis([0 2500]);
end
if VARIABLEPLOT==3
    caxis([500 2500]);
end
xlim(XLIMIT)
ylim(YLIMIT)
zlim(ALTLIMIT)

set(ax(1),'FONTSIZE',FONTSIZE);
set(ax(2),'FONTSIZE',FONTSIZE);
set(ax(3),'FONTSIZE',FONTSIZE);

hc=colorbar;
colormap('jet');
title(hc,titlestr);
if VARIABLEPLOT==1
    set(hc,'Ticks',linspace(10,11.5,6))
end
set(hc, 'Position', [.9 0.02 .0581/3 .91],'FONTSIZE',FONTSIZE)

TIMESTRTITLE=strrep(TIMESTRTITLE,' ','_');
TIMESTRTITLE=strrep(TIMESTRTITLE,':','_');

if SAVEFIGBOOL(2)==1
    print(fig,[SAVEDIRECTORY,TIMESTRTITLE],'-fillpage','-dpdf','-r300','-opengl')
end
if SAVEFIGBOOL(1)==1
    fig.PaperUnits='inches';
    fig.PaperPosition = [0 0 6 8];
    print(fig,[SAVEDIRECTORY,'Full3D_' TIMESTRTITLE],'-dpng','-r300','-opengl')
end

% zlim([200 600])
% xlim([latmin 79])
% ylim([lonmin -80])