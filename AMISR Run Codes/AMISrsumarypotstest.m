close all
clear 

fileNameStr = '20151012.001_lp_3min-cal.h5';

data=AMISRdatafetch_lp(fileNameStr,'lp');

ticks=8;

row=5;
error=inf;
figure
for i=1:15
    time=data.timenum;

    Ne=data.Ne;
    Ne(Ne<0)=NaN;
    dNe=data.dNe;
    Ne(dNe./Ne>error)=NaN;
    Ne=log10(Ne);

    alt=data.beamalt;

    pNe=squeeze(Ne(:,i,:));

    [X,Y]=meshgrid(time,alt(:,i)/1000);	
    
    subplot(5,3,i)

    h=pcolor(X,Y,pNe);
    ax1 = gca;
    drawnow; pause(0.1);
    shading flat;
    set(gca,'Layer','top')
    hold on;
    colormap(jet)
    caxis([10 12])
    title(['Beam ' num2str(i)])
    timeticks=linspace(time(1),time(end),ticks);
    timeticksstr=datestr(timeticks);
    timeticksstrfinal=timeticksstr(:,13:17);
    xticks(ax1,timeticks);
    xticklabels(ax1,timeticksstrfinal)
end

figure
for i=16:30
    time=data.timenum;

    Ne=data.Ne;
    Ne(Ne<0)=NaN;
    dNe=data.dNe;
    Ne(dNe./Ne>error)=NaN;
    Ne=log10(Ne);

    alt=data.beamalt;

    pNe=squeeze(Ne(:,i,:));

    [X,Y]=meshgrid(time,alt(:,i)/1000);	
    
    subplot(5,3,i-15)

    h=pcolor(X,Y,pNe);
    ax1 = gca;
    drawnow; pause(0.1);
    shading flat;
    set(gca,'Layer','top')
    hold on;
    colormap(jet)
    caxis([10 12])
    title(['Beam ' num2str(i)])
    timeticks=linspace(time(1),time(end),ticks);
    timeticksstr=datestr(timeticks);
    timeticksstrfinal=timeticksstr(:,13:17);
    xticks(ax1,timeticks);
    xticklabels(ax1,timeticksstrfinal)
end

figure
for i=31:45
    time=data.timenum;

    Ne=data.Ne;
    Ne(Ne<0)=NaN;
    dNe=data.dNe;
    Ne(dNe./Ne>error)=NaN;
    Ne=log10(Ne);

    alt=data.beamalt;

    pNe=squeeze(Ne(:,i,:));

    [X,Y]=meshgrid(time,alt(:,i)/1000);	
    
    subplot(5,3,i-30)

    h=pcolor(X,Y,pNe);
    ax1 = gca;
    drawnow; pause(0.1);
    shading flat;
    set(gca,'Layer','top')
    hold on;
    colormap(jet)
    caxis([10 12])
    title(['Beam ' num2str(i)])
    timeticks=linspace(time(1),time(end),ticks);
    timeticksstr=datestr(timeticks);
    timeticksstrfinal=timeticksstr(:,13:17);
    xticks(ax1,timeticks);
    xticklabels(ax1,timeticksstrfinal)
end

figure
for i=46:50
    time=data.timenum;

    Ne=data.Ne;
    Ne(Ne<0)=NaN;
    dNe=data.dNe;
    Ne(dNe./Ne>error)=NaN;
    Ne=log10(Ne);

    alt=data.beamalt;

    pNe=squeeze(Ne(:,i,:));

    [X,Y]=meshgrid(time,alt(:,i)/1000);	
    
    subplot(5,1,i-45)

    h=pcolor(X,Y,pNe);
    ax1 = gca;
    drawnow; pause(0.1);
    shading flat;
    set(gca,'Layer','top')
    hold on;
    colormap(jet)
    caxis([10 12])
    title(['Beam ' num2str(i)])
    timeticks=linspace(time(1),time(end),ticks);
    timeticksstr=datestr(timeticks);
    timeticksstrfinal=timeticksstr(:,13:17);
    xticks(ax1,timeticks);
    xticklabels(ax1,timeticksstrfinal)
end

fileNameStr = '20151012.001_ac_5min-cal.h5';

data=AMISRdatafetch_lp(fileNameStr,'ac');

ticks=8;

figure
for i=1:3
    time=data.timenum;

    Ne=data.Ne;
    Ne(Ne<0)=NaN;
    dNe=data.dNe;
    Ne(dNe./Ne>error)=NaN;
    Ne=log10(Ne);

    alt=data.beamalt;

    pNe=squeeze(Ne(:,i,:));

    [X,Y]=meshgrid(time,alt(:,i)/1000);	
    
    subplot(3,1,i)

    h=pcolor(X,Y,pNe);
    ax1 = gca;
    drawnow; pause(0.1);
    shading flat;
    set(gca,'Layer','top')
    hold on;
    colormap(jet)
    caxis([10 12])
    title(['Beam ' num2str(i)])
    timeticks=linspace(time(1),time(end),ticks);
    timeticksstr=datestr(timeticks);
    timeticksstrfinal=timeticksstr(:,13:17);
    xticks(ax1,timeticks);
    xticklabels(ax1,timeticksstrfinal)
end