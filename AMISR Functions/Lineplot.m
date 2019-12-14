%Line plot at the center of radar
% clear 
% close all

load AMISRdata.mat
xcut=100;  
ycut=200;

xaxis=squeeze(xx(1,:,1));
yaxis=squeeze(yy(:,1,1));
zaxis=squeeze(zz(1,1,:));

yindex=find(abs((ycut-yaxis))==min(abs(ycut-yaxis)));
xindex=find(abs((xcut-xaxis))==min(abs(xcut-xaxis)));
DataCut=squeeze(Neinterptime(:,yindex,xindex,:));
time=data.timenum(timevector);
figure
h=pcolor(time,zaxis,DataCut');
colormap jet
colorbar
caxis([10 11.5]);
set(h,'edgecolor','none')

% figure
% hold on
% for i=1:5:size(Neinterptime,1)
%     plot(cutData(i,:),zaxis)
% end