function AMISR3DisplaySingle(xx,yy,zz,xrp,yrp,zrp...
                            ,interp,data,index,loncut,latcut,altcut,timeStr,...
                            az,el, savefig,variable, directory,fontsize)
%north: 1 is north, 0 is south
%east' 1 is east, 0 is west
%variable: 1=Ne, 2=Te, 3=Ti;

if variable==1 %Ne
    Ne=data.Ne;
    Ne=squeeze(Ne(:,:,index));
    Ne(Ne<0)=NaN;
    Ne=log10(Ne);

    Nesize=size(Ne);
    scatterdata=reshape(Ne,[Nesize(1)*Nesize(2),1]);
    strName='Ne';
    titlestr='log10(Ne)';
end
if variable==2 %Te
    Te=data.Te;
    Te=squeeze(Te(:,:,index));
    Te(Te<0)=NaN;
    scatterdata=reshape(Te,[size(Te,1)*size(Te,2),1]);
    strName='Te';
    titlestr='Te (K)';
end
if variable==3 %Ti
    Ti=data.Ti;
    Ti=squeeze(Ti(:,:,index));
    Ti(Ti<0)=NaN;
    scatterdata=reshape(Ti,[size(Ti,1)*size(Ti,2),1]);
    strName='Ti';
    titlestr='Ti (K)';
end



xaxis=squeeze(xx(1,:,1));

xindex=find(abs((loncut-xaxis))==min(abs(loncut-xaxis)));
xcut=(interp(:,xindex,:));


fig=figure;

yy1=squeeze(yy(:,xindex,:));
zz1=squeeze(zz(:,xindex,:));

h2=pcolor(yy1,zz1,squeeze(xcut));
hold on
ax(1)=gca;
xlabel('North of RISRN [Km]')
ylabel('Altitude [Km]')
% title({timeStr;[strName,' at ', num2str(loncut), ' km east of RISR-N']})
title(timeStr)

set(h2,'edgecolor','none')
grid on
ylim([50 750])
if variable==1
    caxis([10 11.5]);
end
if variable==2
    caxis([0 2500]);
end
if variable==3
    caxis([500 2500]);
end
xlim([25 710])
ylim([120 710])


set(ax(1),'fontsize',fontsize);

colormap('jet');

% hc=colorbar;
% % title(hc,titlestr);
% if variable==1
%     set(hc,'Ticks',linspace(10,11.5,6))
% end
% set(hc, 'Position', [.91 0.06 .0581/3 .9],'fontsize',8)

timeStr=strrep(timeStr,' ','_');
timeStr=strrep(timeStr,':','_');

if savefig(2)==1
    print(fig,[directory,timeStr],'-fillpage','-dpdf','-r300','-opengl')
end
if savefig(1)==1
    fig.PaperUnits='inches';
    fig.PaperPosition = [0 0 4 4];
    print(fig,[directory,timeStr],'-dpng','-r300','-opengl')
end

% zlim([200 600])
% xlim([latmin 79])
% ylim([lonmin -80])