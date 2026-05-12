%function [dmidx dmidy scd_hist_av]=fun(h);
function [dmidx dmidy scd_hist_av histo]=scd_histogram_distribution(data,ndiv,dminx,widthx,dminy,widthy);
%dmidx=data(:,1);
%dmidy=data(:,2);
%scd_hist_av=data(:,3);
%ndiv=data(1,4);
n=length(data);
%dminx=min(data(:,1));
%dmaxx=max(data(:,1));
%widthx=(dmaxx-dminx)/ndiv;
%dminy=min(data(:,2));
%dmaxy=max(data(:,2));
%widthy=(dmaxy-dminy)/ndiv;

histo=zeros(ndiv,ndiv);
scd_hist=zeros(ndiv,ndiv);
scd_hist_av=zeros(ndiv,ndiv);
for i = 1:n
    if data(i,1)==dminx
        boxb(i,1)=1;
    else
        boxb(i,1)=ceil((data(i,1)-dminx)/widthx);
            if data(i,2)==dminy
            boxb(i,2)=1;
            else
            boxb(i,2)=ceil((data(i,2)-dminy)/widthy);
            histo(boxb(i,1),boxb(i,2))=histo(boxb(i,1),boxb(i,2))+1;
            scd_hist(boxb(i,1),boxb(i,2))=scd_hist(boxb(i,1),boxb(i,2))+data(i,3);
            end
    end
end

for i=1:ndiv
    for j=1:ndiv
        scd_hist_av(i,j)=scd_hist(i,j)/histo(i,j);
    end
end

dmidx=zeros(ndiv,ndiv);
for i=1:ndiv
    for j=1:ndiv
        dmidx(i,j)=dmidx(i,j)+dminx+(j-0.5)*widthx;
    end
end

dmidy=zeros(ndiv,ndiv);
for i=1:ndiv
    for j=1:ndiv
        dmidy(i,j)=dmidy(i,j)+dminy+(i-0.5)*widthy;
    end
end

%surface(dmidx,dmidy,histo)
%surfl(dmidx,dmidy,histo)
%surfl(dmidx,dmidy,scd_hist)
%surface(dmidx,dmidy,scd_hist_av)
%surfl(dmidx,dmidy,scd_hist_av)
