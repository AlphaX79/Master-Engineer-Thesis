function [mask, it_count,colors]= kmpp_mask(image, k)
    image=double(image);
    it_count=0;
    k_centers(k,3)=0; % k_centers(index)=[r g b]
    [X_size, Y_size,~]=size(image);
    mask=uint8(zeros(X_size,Y_size,3));

        %random point from dataset x
    k_centers(1,:)=image(randi(X_size),randi(Y_size),:);
   
    probabilities(X_size,Y_size)=0;
    distances(1:X_size,1:Y_size,1:k-1)=195075;   
    for i=1:k-1
        for x=1:X_size
            for y=1:Y_size
                %calculating distances
                    r_dist=abs(image(x,y,1)-k_centers(i,1));
                    g_dist=abs(image(x,y,2)-k_centers(i,2));
                    b_dist=abs(image(x,y,3)-k_centers(i,3));
                    pix_dist = (r_dist * r_dist) + (g_dist * g_dist) + (b_dist * b_dist); % EUKLIDES
                    distances(x,y,i)=pix_dist;                
                    probabilities(x,y)=min(distances(x,y,:));
            end    
        end
        %calculating new centroid
        probsum=sum(sum(probabilities));
        new_center=randi(probsum);
        for x=1:X_size
            for y=1:Y_size
                new_center=new_center-probabilities(x,y);
                if(new_center<=0)
                    k_centers(i+1,:)=image(x,y,:);
                    break
                end
            end
            if(new_center<=0)
                break
            end           
        end
    end
    pix_assignment(X_size,Y_size)=0;
    k_centers_old=k_centers+1;

    %main loop
    while(~isequal(k_centers_old, k_centers) && it_count<2000)  
        sums=zeros(k,3);
        counters=zeros(k,1);
        k_centers_old=k_centers;
        prev_dist=0;
        for x=1:X_size
            for y=1:Y_size
                %Assigning pixels to the centers        
                for i=1:k
                    %distance (no sqrt)
                    r_dist=abs(image(x,y,1)-k_centers(i,1));
                    g_dist=abs(image(x,y,2)-k_centers(i,2));
                    b_dist=abs(image(x,y,3)-k_centers(i,3));
                    pix_dist=r_dist * r_dist + g_dist * g_dist + b_dist * b_dist;
%                     pix_dist = r_dist  + g_dist + b_dist;  % MANHATTAN

                    if(i==1)
                        prev_dist=pix_dist;
                        pix_assignment(x,y)=i;
                    elseif(pix_dist<=prev_dist)
                        pix_assignment(x,y)=i;
                        prev_dist=pix_dist;
                    end
                end
            end
        end
        %Counting new centers
        for x=1:X_size
            for y=1:Y_size
                for i=1:3
                    sums(pix_assignment(x,y),i) = sums(pix_assignment(x,y),i) + image(x,y,i);
                end
                counters(pix_assignment(x,y))=counters(pix_assignment(x,y))+1;
            end
        end
        for i=1:k
            if(sums(i,1)~=0)
                sums(i,1)=sums(i,1)/counters(i);
                sums(i,2)=sums(i,2)/counters(i);
                sums(i,3)=sums(i,3)/counters(i);   
            end
        end
        for i=1:k
            for j=1:3
                k_centers(i,j)=sums(i,j);
            end
        end
        it_count=it_count+1;
    end
    mask=pix_assignment;
    colors=k_centers;
end