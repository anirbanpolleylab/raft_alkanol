clear all;
close all;

data1=load('pos_r2_dppc_p_500-1000ns.dat');
data2=load('pos_r2_dopc_p_500-1000ns.dat');

Ndppc=340;
Ndopc=342;

Nframe=5005;

Un=[];
Dn=[];
for i=1:Nframe
down=data1([(i-1)*Ndppc+1:(i-1)*Ndppc+Ndppc/2],:);	% position of lower leaflet
up=data1([(i-1)*Ndppc+Ndppc/2+1:i*Ndppc],:);		% position of upper leaflet	
Un=[Un;up];
Dn=[Dn;down];
down=data2([(i-1)*Ndopc+1:(i-1)*Ndopc+Ndopc/2],:);	% position of lower leaflet
up=data2([(i-1)*Ndopc+Ndopc/2+1:i*Ndopc],:);		% position of upper leaflet	
Un=[Un;up];
Dn=[Dn;down];
end

data=[data1;data2];
x=data(:,1);
y=data(:,2);

LeftEdge=min(x);
RightEdge=max(x);
BtmEdge=min(y);
TopEdge=max(y);

ndiv=30; % number of bin

widthx=(RightEdge-LeftEdge)/(ndiv-1);
widthy=(TopEdge-BtmEdge)/(ndiv-1);


%%%%%%%%%%%%%% 2 components %%%%%%%%%%%%%%
[dmidx dmidy hu histo_up]=s3dhist(Un,ndiv,LeftEdge,widthx,BtmEdge,widthy);
[dmidx1 dmidy1 hl histo_down]=s3dhist(Dn,ndiv,LeftEdge,widthx,BtmEdge,widthy);
histo_up=histo_up./(Nframe);histo_down=histo_down./(Nframe);
histo_up=histo_up/(widthx*widthy);histo_down=histo_down/(widthx*widthy);
th=hu-hl;
%-----------------------------------------------------

figure;axes('FontSize',30);contourf(dmidx,dmidy,th);xlabel('x (nm)','FontSize',30);ylabel('y (nm)','FontSize',30);colorbar('FontSize',30);set(gca,'box','on','LineWidth',3);colormap('jet');
set(gca,'FontSize',30);
set(gca,'box','on','LineWidth',3);
axis([LeftEdge RightEdge BtmEdge TopEdge]);
axis square;

xlim([LeftEdge RightEdge]);set(gca,'XTick',[0:5:15]);
ylim([BtmEdge TopEdge]);set(gca,'YTick',[0:5:15]); 
set(gca,'CLim',[3.5 4.5]);
colorbar;caxis('auto');ax=gca;set(gca,'CLim',[ax.CLim]);
set(gca,'Position',[0.177238805970149 0.21957671957672 0.656716417910448 0.70542328042328]);
saveas(gca,'thickness_membrane_r2.fig');
exportgraphics(gca,['thickness_membrane_r2.png'],'Resolution',1024);

save('thickness_membrane_r2.mat');
