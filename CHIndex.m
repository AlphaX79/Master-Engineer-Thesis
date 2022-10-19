function [score]=CHIndex(photo,mask, k, centroids)
[height,width]=size(photo(:,:,3));
photo=double(photo);
nk=zeros(k,1);
%% centroid of a full image (barycenter)
sum=zeros(1,3);
barycenter=zeros(3,1);
pix_ammount=height*width;
for i=1:height
    for j=1:width
        nk(mask(i,j))=nk(mask(i,j))+1; % calculating nk, for future use
        sum(1,1)=sum(1,1)+photo(i,j,1);
        sum(1,2)=sum(1,2)+photo(i,j,2);
        sum(1,3)=sum(1,3)+photo(i,j,3);
    end
end

barycenter(1)=sum(1,1)/(pix_ammount);
barycenter(2)=sum(1,2)/(pix_ammount);
barycenter(3)=sum(1,3)/(pix_ammount);

%%between group sum of squares (BGSS)
BGSS=0;
for i=1:k
    distance = (centroids(i,1) - barycenter(1))^2 + (centroids(i,2) - barycenter(2))^2 + (centroids(i,3) - barycenter(3))^2;
    BGSS=BGSS + nk(i)*distance;
end

%%within group sum of squares (WGSS)
WGSSk=zeros(1,k);
for i=1:height
    for j=1: width
        distance = (photo(i,j,1) - centroids(mask(i,j),1))^2 + (photo(i,j,2) - centroids(mask(i,j),2))^2 + (photo(i,j,3) - centroids(mask(i,j),3))^2;
        WGSSk(mask(i,j)) = WGSSk(mask(i,j)) + distance;
    end
end
WGSS=0;
for i=1:k
    WGSS=WGSS + WGSSk(i);
end

%% calculating CH index
score = (BGSS/WGSS) * ((pix_ammount-k)/(k-1));
end