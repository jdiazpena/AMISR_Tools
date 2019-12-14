
function AMISRplotBeamsPattern(data)

rs=90-(data.beamdata(3,:));
%thetas=data.beamdata(2,:)*pi/180.0-26*pi/180;
thetas=data.beamdata(2,:)*pi/180.0;

figure
polarscatter(thetas,rs, 'MarkerEdgecolor','r','MarkerFaceColor','r')
rlim([0 65])
pax = gca;
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
pax.RAxisLocation = 180;
pax.RTick = [0 10 20 30 40 50 60];
pax.RTickLabel = {'90','80','70','60','50','40','30'};


beamn=1:1:length(data.beamdata(1,:));
beamn=beamn';
text(thetas, rs,num2str(beamn), 'FontSize',10,'Color', 'k')


