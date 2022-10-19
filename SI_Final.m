function [image,optimal_k]=SI_Final(photo)
limit=16;
for k=2:1:limit
    [mask(:,:,k), ~,colors(1:k,:,k)]= kmpp_mask(photo, k);
    score_SI(k)=Fsilhouette(photo,mask(:,:,k),k,colors(1:k,:,k));
end
[~,optimal_k]=max(score_SI);
image=apply_mask(photo,mask(:,:,optimal_k),colors(1:optimal_k,:,optimal_k));
end