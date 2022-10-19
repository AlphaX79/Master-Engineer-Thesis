function [image,optimal_k]=CHI_Final(photo)
limit=16;
for k=2:1:limit
    [mask(:,:,k), ~,colors(1:k,:,k)]= kmpp_mask(photo, k);
    score_CHI(k)=CHIndex(photo,mask(:,:,k),k,colors(1:k,:,k));
end
[~,optimal_k]=max(score_CHI);

if(optimal_k == 2)
    image=apply_mask(photo,mask(:,:,optimal_k),colors(1:optimal_k,:,optimal_k));
else
    for i=3:limit-1   
        if(score_CHI(i)>score_CHI(i-1)) 
            if(score_CHI(i)>score_CHI(i+1))
                image=apply_mask(photo,mask(:,:,i),colors(1:i,:,i));
                done=1;
                optimal_k=i;
                break;
            end    
        end
    end
end
end