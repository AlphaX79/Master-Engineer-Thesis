function [score]=ElbowMethod(photo,mask, centroids)
[height,width]=size(photo(:,:,3));
photo=double(photo);

score=0;
for i=1:height
    for j=1:width
        distance = (centroids(mask(i,j),1)-photo(i,j,1))^2 + (centroids(mask(i,j),2)-photo(i,j,2))^2 + (centroids(mask(i,j),3)-photo(i,j,3))^2;
        score = score + distance;
    end
end
end