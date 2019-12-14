% tracking method

% load AMISRdata2mind033LP.mat

    close all
    RadarHeight=300;
    Interp=Neinterptime;
    error=0.005;
    
    
    xmark=21;
    ymark=360;

    timeradar=data.timenum(timevector);
    timeplot=datenum('24-Jan-2012 11:36:30');
    
    indexplot=find(abs((timeradar-timeplot))==min(abs(timeradar-timeplot)));

    xaxis=squeeze(xx(1,:,1));
    yaxis=squeeze(yy(:,1,1));
    zaxis=squeeze(zz(1,1,:));

    interplot=squeeze(Interp(indexplot,:,:,:));

    indexheightcut=find(abs((zaxis-RadarHeight))==min(abs(zaxis-RadarHeight)));
    interplot=squeeze(interplot(:,:,indexheightcut));
    
    figure
    contour(squeeze(xx(:,:,1)), squeeze(yy(:,:,1)),interplot,10,'LineWidth',1,'Clipping','on');
    hold on
    grid on
    plot(xmark,ymark,'kp','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
    caxis([10 11.5])
    colormap(jet)
    cbar = colorbar('location','WestOutside');
    xlabel('Km East of RISRN','fontsize',10)
    ylabel('Km North of RISRN','fontsize',10)
    xlim([-60 350])
    ylim([-25 450])
    title(datestr(timeradar((indexplot))))
    
    xcoordindex=find(abs(xmark-xaxis)==min(abs(xmark-xaxis)));
    xcoord=xaxis(xcoordindex)
    
    ycoordindex=find(abs(ymark-yaxis)==min(abs(ymark-yaxis)));
    ycoord=yaxis(ycoordindex)
    
    
    xscat=squeeze(xx(:,:,1));
    yscat=squeeze(yy(:,:,1));
    
    xscat=reshape(xscat,[size(xscat,1)*size(xscat,2) 1]);
    yscat=reshape(yscat,[size(yscat,1)*size(yscat,2) 1]);
    dataplot=reshape(interplot,[size(interplot,1)*size(interplot,2) 1]);
    
    figure
    scatter(xscat, yscat,15,dataplot,'filled');
    hold on
    caxis([10 11.5])
    grid on
    plot(xmark,ymark,'kp','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
    colormap(jet)
    cbar = colorbar('location','WestOutside');
    xlabel('Km East of RISRN','fontsize',10)
    ylabel('Km North of RISRN','fontsize',10)
    xlim([-60 350])
    ylim([-25 450])
    title(datestr(timeradar((indexplot))))
    
    figure
    h2=pcolor(squeeze(xx(:,:,1)), squeeze(yy(:,:,1)),interplot);
    hold on
    set(h2,'edgecolor','none')
    grid on
    plot(xmark,ymark,'kp','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
    caxis([10 11.5])
    colormap(jet)
    cbar = colorbar('location','WestOutside');
    xlabel('Km East of RISRN','fontsize',10)
    ylabel('Km North of RISRN','fontsize',10)
    xlim([-60 350])
    ylim([-25 450])
    title(datestr(timeradar((indexplot))))
    
%     Ne=interplot(ycoordindex,xcoordindex)
    Ne=[11.25];
    
    indexscatter=find(dataplot>=11.15);
    
    
    figure
    scatter(xscat(indexscatter), yscat(indexscatter),15,dataplot(indexscatter),'filled');
    hold on
    caxis([10 11.5])
    plot(xmark,ymark,'kp','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
    colormap(jet)
    cbar = colorbar('location','WestOutside');
    xlabel('Km East of RISRN','fontsize',10)
    ylabel('Km North of RISRN','fontsize',10)
    xlim([-60 350])
    ylim([-25 450])
    title(datestr(timeradar((indexplot))))