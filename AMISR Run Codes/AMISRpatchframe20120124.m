% Plots of Ne, Te and pedersen conductivity using AMISR data and MSIS, IRI
% provided by Michael Hirsch. Should be updated to be a function


clear
close all

% load AMISR2mind033LP.mat
load AMISRold2min
zaxis=squeeze(zz(1,1,:));
xaxis=squeeze(xx(1,:,1));
yaxis=squeeze(yy(:,1,1));

% backgroundstate



posvector=[ 30, 500; 30, 470; 20, 450; 27, 450; 35, 430; 30, 430; 40, 410;
            40, 390; 30, 380; 30, 360; 35, 330; 40, 310; 10, 290; 05, 200;
            -5, 180; 50, 180; 100, 150; 100, 120; 100, 100; 100, 90; 100, 70; 160, 40];
a=1;

timeplots=['24-Jan-2012 10:52:30';
    '24-Jan-2012 10:54:30';
    '24-Jan-2012 10:56:30';
    '24-Jan-2012 10:58:30';
    '24-Jan-2012 11:00:30';
    '24-Jan-2012 11:02:30';
    '24-Jan-2012 11:04:30';
    '24-Jan-2012 11:06:30';
    '24-Jan-2012 11:08:30';
    '24-Jan-2012 11:10:30';
    '24-Jan-2012 11:12:30';
    '24-Jan-2012 11:14:30';
    '24-Jan-2012 11:16:30';
    '24-Jan-2012 11:18:30';
    '24-Jan-2012 11:20:30';
    '24-Jan-2012 11:22:30';
    '24-Jan-2012 11:24:30';
    '24-Jan-2012 11:26:30';
    '24-Jan-2012 11:28:30';
    '24-Jan-2012 11:30:30';
    '24-Jan-2012 11:32:30';
    '24-Jan-2012 11:34:30';];

% posvector=[ 21, 433; 
%             21, 410;    
%             21, 410; 
%             26, 375; 
%             26, 375; 
%             50, 331; 
%             35, 320;
%             21, 302; 
%             21, 302; 
%             10, 285; 
%             10, 285; 
%             10, 255; 
%             20, 215; 
%             60, 142;
%             93, 54; 
%             93, 55;
%             120, 40; 
%             120, 40;
%             120, 40;
%             120, 40;
%             120, 40;
%             120, 40;
%             120, 40;];
% a=1;
% 
% timeplots=['24-Jan-2012 10:54:30';
%     '24-Jan-2012 10:56:30';
%     '24-Jan-2012 10:58:30';
%     '24-Jan-2012 11:00:30';
%     '24-Jan-2012 11:02:30';
%     '24-Jan-2012 11:04:30';
%     '24-Jan-2012 11:06:30';
%     '24-Jan-2012 11:08:30';
%     '24-Jan-2012 11:10:30';
%     '24-Jan-2012 11:12:30';
%     '24-Jan-2012 11:14:30';
%     '24-Jan-2012 11:16:30';
%     '24-Jan-2012 11:18:30';
%     '24-Jan-2012 11:20:30';
%     '24-Jan-2012 11:22:30';
%     '24-Jan-2012 11:24:30';
%     '24-Jan-2012 11:26:30';
%     '24-Jan-2012 11:28:30';
%     '24-Jan-2012 11:30:30';
%     '24-Jan-2012 11:32:30';
%     '24-Jan-2012 11:34:30';
%     '24-Jan-2012 11:36:30';
%     '24-Jan-2012 11:38:30';];


% posvector=[ 22   419;
%             30   400;
%             45   385;
%             45   385;
%             50   370;
%             50   355;
%             55   320;
%             60   310;
%             60   310;
%             65   285;
%             70   270;
%             70   265;
%             72   240;
%             93   220;
%            136   156;
%            164   142;
%            192   112;];
% a=1;
% 
% timeplots=['24-Jan-2012 10:52:30';
%     '24-Jan-2012 10:54:30';
%     '24-Jan-2012 10:56:30';
%     '24-Jan-2012 10:58:30';
%     '24-Jan-2012 11:00:30';
%     '24-Jan-2012 11:02:30';
%     '24-Jan-2012 11:04:30';
%     '24-Jan-2012 11:06:30';
%     '24-Jan-2012 11:08:30';
%     '24-Jan-2012 11:10:30';
%     '24-Jan-2012 11:12:30';
%     '24-Jan-2012 11:14:30';
%     '24-Jan-2012 11:16:30';
%     '24-Jan-2012 11:18:30';
%     '24-Jan-2012 11:20:30';
%     '24-Jan-2012 11:22:30';
%     '24-Jan-2012 11:24:30';];



datavector=AMISREvectorFetch('20120122.001_lp_5min-vvelsLat-geo-300sec.h5');
index=length(datavector.Emaglat)/2+1;
Emagpos=datavector.Emag(index,:)';
Timevstr=datavector.timestr;
Timevnum=datavector.timenum;


% Background state
xcut=100;  
ycut=200;
BackTime='24-Jan-2012 11:08:30';

    yindex=find(abs((ycut-yaxis))==min(abs(ycut-yaxis)));
    xindex=find(abs((xcut-xaxis))==min(abs(xcut-xaxis)));
    Necut=squeeze(Neinterptime(:,yindex,xindex,:));
    Tecut=squeeze(Teinterptime(:,yindex,xindex,:));
    Ticut=squeeze(Tiinterptime(:,yindex,xindex,:));

    timenum=data.timenum(timevector);
    timeindex=find(abs((timenum-datenum(BackTime)))==min(abs((timenum-datenum(BackTime)))));
    NeB=Necut(timeindex,:);
    TeB=Tecut(timeindex,:);
    

sigmaPint=0;       
for i=1:length(posvector)
    xcut=posvector(i,1);  
    ycut=posvector(i,2);
    
    yindex=find(abs((ycut-yaxis))==min(abs(ycut-yaxis)));
    xindex=find(abs((xcut-xaxis))==min(abs(xcut-xaxis)));
    Necut=squeeze(Neinterptime(:,yindex,xindex,:));
    Tecut=squeeze(Teinterptime(:,yindex,xindex,:));
    Ticut=squeeze(Tiinterptime(:,yindex,xindex,:));
    stepalt=mean(zaxis(2:end)-zaxis(1:end-1));

    timenum=data.timenum(timevector);
    timestr=data.timestr(timevector,:);
    
    time=timeplots(i,:);
    glat=data.lat0;
    glon=data.lon0;
    altkmrange=[zaxis(1) zaxis(end) stepalt];
    alt_km=zaxis;
    
    iono1 = iri2016(datenum(time), glat, glon,altkmrange);
    iono1=fixiono(iono1);
    
    iriData.nOI=iono1.nO';
    iriData.nNOI=iono1.nNO';
    iriData.nO2I=iono1.nO2';
    iriData.nNI=iono1.nN';
    iriData.nHI=(iono1.nH)';
    iriData.nHeI=(iono1.nHe)';
    iriData.Te=iono1.Te';
    iriData.Ti=iono1.Ti';
    iriData.Ne=iono1.Ne';
    iriData.totalIonDensity=(iono1.nO+iono1.nNO+iono1.nO2+iono1.nN+(iono1.nH)+(iono1.nHe))';

    F107A=90.34;
    F107=131.5;
    APH=5;
    
    for j = 1:length(alt_km)
        atmos(j) = msise00(datenum(time), glat, glon, F107A, F107, APH, alt_km(j)); %#ok<SAGROW>    
    end

    nO=[atmos.nO];
    nN2=[atmos.nN2];
    nO2=[atmos.nO2];
    nH=[atmos.nH];
    nHe=[atmos.nHe];
    AltTemp=[atmos.Tn];
    totalNumberDensity = nO+nN2+nO2+nH+nHe+[atmos.nAr]+[atmos.nO]+[atmos.nOanomalous];

    msisData.O=nO;
    msisData.N2=nN2;
    msisData.O2=nO2;
    msisData.H=nH;
    msisData.He=nHe;
    msisData.AltTemp=AltTemp';
    msisData.totalNumberDensity=totalNumberDensity;

    timeindex=find(abs((timenum-datenum(time)))==min(abs((timenum-datenum(time)))));
    Ne=Necut(timeindex,:);
    Ne=10.^(Ne);
    Te=Tecut(timeindex,:);
    Ti=Ticut(timeindex,:);
    [data1,input1]=get_conductivity_v3(zaxis,Te',Ne,glat,glon,datenum(time),0,0,'all',0,iriData,msisData);
    
    altitude1=alt_km(2:end);
    altitude2=alt_km(1:end-1);
    sigmap=real(data1.pedersonConductivity(2:end));
    sigmap(isnan(sigmap))=0;

    deltaalt=(altitude1-altitude2)*1e3;
    sigmaPint=sigmap.*deltaalt;
    sigmaP180down(i)=sum(sigmaPint(altitude1<=180));
    sigmaP180up(i)=sum(sigmaPint(altitude1>180));
    hintegrated=sum(sigmaPint);
    
    timeindexvect=find(abs((Timevnum-datenum(time)))==min(abs((Timevnum-datenum(time)))));
    Emagfinal=Emagpos(timeindexvect);
    joule=Emagfinal^2.*hintegrated;
    
    jouleplot(i)=joule;
    hintegratedplot(i)=hintegrated;
    timeplot(i)=datenum(time);
    densityplot(i,:)=log10(Ne);
    teplot(i,:)=Te;
    pedplot(i,:)=log10(data1.pedersonConductivity);

%     fig=figure;
%     subplot(1,3,1)
%     plot(log10(Ne),alt_km,'k','linewidth',1)
%     xlim([10 11.5])
%     ylim([120 600])
%     hold on
%     grid on
%     ylabel('Altitude [Km]');
%     title('log_{10}(Ne)')
%     subplot(1,3,2)
%     plot(Te,alt_km, 'k','linewidth',1)
%     ylim([120 600]) 
%     xlim([600 3000])
%     hold on
%     grid on
%     title('Te')
%     subplot(1,3,3)
%     plot(log10(data1.pedersonConductivity),alt_km, 'k','linewidth',1)
%     ylim([120 600])
%     xlim([-6.5 -4])
%     hold on
%     grid on
%     title('log_{10}(\sigma_P)')
%     suptitle([datestr(time) , '; \Sigma_P=', num2str(hintegrated),'; \Sigma_P|E|^2=', num2str(joule,'%10.4e')])
%     
%     fig.PaperUnits='inches';
%     fig.PaperPosition = [0 0 6 4];
%     timestrfinal=datestr(time);
%     timeStr=strrep(timestrfinal,' ','_');
%     timeStr=strrep(timeStr,':','_');
%     savestr=['AMISR_LINE_' timeStr];
% %     savestr=num2str(i);
%     myFolder = 'C:\SDStorage\Google Drive\Matlab\Figures\';
%     print(fig,[myFolder savestr],'-dpng','-r300','-opengl')
     
end

for i=1
    xcut=posvector(i,1);  
    ycut=posvector(i,2);
    
    yindex=find(abs((ycut-yaxis))==min(abs(ycut-yaxis)));
    xindex=find(abs((xcut-xaxis))==min(abs(xcut-xaxis)));
    Necut=squeeze(Neinterptime(:,yindex,xindex,:));
    Tecut=squeeze(Teinterptime(:,yindex,xindex,:));
    Ticut=squeeze(Tiinterptime(:,yindex,xindex,:));
    stepalt=mean(zaxis(2:end)-zaxis(1:end-1));

    timenum=data.timenum(timevector);
    timestr=data.timestr(timevector,:);
    
    time=timeplots(i,:);
    glat=data.lat0;
    glon=data.lon0;
    altkmrange=[zaxis(1) zaxis(end) stepalt];
    alt_km=zaxis;
    
    iono1 = iri2016(datenum(time), glat, glon,altkmrange);
    iono1=fixiono(iono1);
    
    iriData.nOI=iono1.nO';
    iriData.nNOI=iono1.nNO';
    iriData.nO2I=iono1.nO2';
    iriData.nNI=iono1.nN';
    iriData.nHI=(iono1.nH)';
    iriData.nHeI=(iono1.nHe)';
    iriData.Te=iono1.Te';
    iriData.Ti=iono1.Ti';
    iriData.Ne=iono1.Ne';
    iriData.totalIonDensity=(iono1.nO+iono1.nNO+iono1.nO2+iono1.nN+(iono1.nH)+(iono1.nHe))';

    F107A=90.34;
    F107=131.5;
    APH=5;
    
    for j = 1:length(alt_km)
        atmos(j) = msise00(datenum(time), glat, glon, F107A, F107, APH, alt_km(j)); %#ok<SAGROW>    
    end

    nO=[atmos.nO];
    nN2=[atmos.nN2];
    nO2=[atmos.nO2];
    nH=[atmos.nH];
    nHe=[atmos.nHe];
    AltTemp=[atmos.Tn];
    totalNumberDensity = nO+nN2+nO2+nH+nHe+[atmos.nAr]+[atmos.nO]+[atmos.nOanomalous];

    msisData.O=nO;
    msisData.N2=nN2;
    msisData.O2=nO2;
    msisData.H=nH;
    msisData.He=nHe;
    msisData.AltTemp=AltTemp';
    msisData.totalNumberDensity=totalNumberDensity;

    timeindex=find(abs((timenum-datenum(time)))==min(abs((timenum-datenum(time)))));
    Ne=Necut(timeindex,:);
    Ne=10.^(Ne);
    Te=Tecut(timeindex,:);
    Ti=Ticut(timeindex,:);
    [data1,input1]=get_conductivity_v3(zaxis,TeB',10.^NeB,glat,glon,datenum(time),0,0,'all',0,iriData,msisData);
    
    altitude1=alt_km(2:end);
    altitude2=alt_km(1:end-1);
    sigmap=real(data1.pedersonConductivity(2:end));
    sigmap(isnan(sigmap))=0;

    deltaalt=(altitude1-altitude2)*1e3;
    sigmaPint=sigmap.*deltaalt;
    hintegrated=sum(sigmaPint);
    
    timeindexvect=find(abs((Timevnum-datenum(time)))==min(abs((Timevnum-datenum(time)))));
    Emagfinal=Emagpos(timeindexvect);
    joule=Emagfinal^2.*hintegrated;
    
    jouleplotb=joule;
    hintegratedplotb=hintegrated;
    timeplotb=datenum(time);
    densityplotb=log10(Ne);
    teplotb=Te;
    pedplotb=log10(data1.pedersonConductivity);
end

line1=1:7;
line2=8:15;
line3=16:21;
% line1=1:6;
% line2=7:12;
% line3=13:17;
cm = colormap(autumn(3*21));
fontsize=12;

fig1=figure;
ax1=subplot(1,3,1);
    for i=[line1,line2,line3]
            plot(densityplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
            hold on
    end
    plot(NeB,alt_km,'linewidth',1,'Color', 'k')
    xlim([10 11.5])
    ylim([120 600])
    grid on
    ylabel('Altitude [Km]');
    xlabel('log_{10}(m^{-3})')
    title('log_{10}(Ne)','fontsize',fontsize)
 
    ax2=subplot(1,3,2);
    for i=[line1,line2,line3]
            plot(teplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
            hold on
    end
    plot(TeB,alt_km,'linewidth',1,'Color', 'k')
    ylim([120 600]) 
    xlim([600 3000])
    grid on
    title('Te','fontsize',fontsize)
    xlabel('K^o')
 ax3=subplot(1,3,3);
    for i=[line1,line2,line3]
            plot(pedplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
            hold on
    end
    plot(pedplotb,alt_km,'linewidth',1,'Color', 'k')
    ylim([120 600])
    xlim([-6.5 -4])
    grid on
    title('log_{10}(\sigma_P)','fontsize',fontsize)
    xlabel('log_{10}(S/m)')
    
    set(ax1,'fontsize',fontsize);
    set(ax2,'fontsize',fontsize);
    set(ax3,'fontsize',fontsize);
    
    fig1.PaperUnits='inches';
    fig1.PaperPosition = [0 0 8.5 7];
    print(fig1,'HeatingTimeSeries','-dpng','-r300','-opengl')
    
fontsize=15;
    
fig2=figure;
plot(timeplot,sigmaP180down,'r','LineWidth',2)
hold on
plot(timeplot,sigmaP180up,'k','LineWidth',2)
ax = gca;
grid on

legend('\Sigma_P Below 180 km','\Sigma_P Above 180 km','Location','northwest','fontsize',10)
xlabel('Time UT','fontsize',fontsize)
ylabel('S','fontsize',fontsize)
title('RISRN \Sigma_P for 24-Jan-2012','fontsize',fontsize)
set(ax,'fontsize',fontsize);

ticks=12;

timeticks=linspace(timeplot(1),timeplot(end),ticks);
timeticksstr=datestr(timeticks);
timeticksstrfinal=timeticksstr(:,13:17);

xticks(ax,timeticks);
xticklabels(ax,timeticksstrfinal)

xlim([timeplot(4) timeplot(end)])

    fig2.PaperUnits='inches';
    fig2.PaperPosition = [0 0 9.5 3];
    print(fig2,'SIGMAP','-dpng','-r300','-opengl')
    
    
fig2=figure;
plot(timeplot,jouleplot.*1e3,'k','LineWidth',2)
hold on
ax = gca;
grid on
legend('\Sigma_P|E|^2','Location','northwest','fontsize',fontsize)
xlabel('Time UT','fontsize',fontsize)
ylabel('mW/m^2','fontsize',fontsize)
title('RISRN Heating for 24-Jan-2012','fontsize',fontsize)
set(ax,'fontsize',fontsize);

ticks=12;

timeticks=linspace(timeplot(1),timeplot(end),ticks);
timeticksstr=datestr(timeticks);
timeticksstrfinal=timeticksstr(:,13:17);

xticks(ax,timeticks);
xticklabels(ax,timeticksstrfinal)

xlim([timeplot(4) timeplot(end)])

    fig2.PaperUnits='inches';
    fig2.PaperPosition = [0 0 9.5 2.5];
    print(fig2,'Joule','-dpng','-r300','-opengl')

    
%     fig2=figure;
%     subplot(1,3,1)
%     for i=line2
%             plot(densityplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
%             hold on
%     end
%     xlim([10 11.5])
%     ylim([120 600])
%     grid on
%     ylabel('Altitude [Km]');
%     title('log_{10}(Ne)')
%     subplot(1,3,2)
%     for i=line2
%             plot(teplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
%             hold on
%     end
%     ylim([120 600]) 
%     xlim([600 3000])
%     grid on
%     title('Te')
%     subplot(1,3,3)
%     for i=line2
%             plot(pedplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
%             hold on
%     end
%     ylim([120 600])
%     xlim([-6.5 -4])
%     hold on
%     grid on
%     title('log_{10}(\sigma_P)')
%     
%     fig3=figure;
%     subplot(1,3,1)
%     for i=line3
%             plot(densityplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
%             hold on
%     end
%     xlim([10 11.5])
%     ylim([120 600])
%     grid on
%     ylabel('Altitude [Km]');
%     title('log_{10}(Ne)')
%     subplot(1,3,2)
%     for i=line3
%             plot(teplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
%             hold on
%     end
%     ylim([120 600]) 
%     xlim([600 3000])
%     grid on
%     title('Te')
%     subplot(1,3,3)
%     for i=line3
%             plot(pedplot(i,:),alt_km,'linewidth',1,'Color', cm(3*i,:))
%             hold on
%     end
%     ylim([120 600])
%     xlim([-6.5 -4])
%     hold on
%     grid on
%     title('log_{10}(\sigma_P)')
%     suptitle([datestr(time) , '; \Sigma_P=', num2str(hintegrated),'; \Sigma_P|E|^2=', num2str(joule,'%10.4e')])
    
%     fig.PaperUnits='inches';
%     fig.PaperPosition = [0 0 6 4];
%     timestrfinal=datestr(time);
%     timeStr=strrep(timestrfinal,' ','_');
%     timeStr=strrep(timeStr,':','_');
%     savestr=['AMISR_LINE_' timeStr];
% %     savestr=num2str(i);
%     myFolder = 'C:\SDStorage\Google Drive\Matlab\Figures\';
%     print(fig,[myFolder savestr],'-dpng','-r300','-opengl')