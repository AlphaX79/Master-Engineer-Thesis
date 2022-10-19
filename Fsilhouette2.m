function [Final_SI]= Fsilhouette2(photo,mask, k,~)

photo=double(photo);
[X_size, Y_size,~]=size(photo);
SI_list=zeros(X_size,Y_size);
for x=1:X_size
    for y=1:Y_size
        % pixel(1)=randi(X_size);
        % pixel(2)=randi(Y_size);
        pixel(1)=x;
        pixel(2)=y;
        A=mask(pixel(1),pixel(2));
        Counter=0;
        %% computing a(i) 
        i_pixel=photo(pixel(1),pixel(2),:);
        % i_pixel=colors(A,1:3);
        SumOfDistances=0;
        for i=1:X_size
            for j=1:Y_size
                if(mask(i,j)==A)
                    `if(~(i==pixel(1) && j==pixel(2)))
                        r_dist=abs(i_pixel(1)-photo(i,j,1));
                        g_dist=abs(i_pixel(2)-photo(i,j,2));
                        b_dist=abs(i_pixel(3)-photo(i,j,3));
                        pix_dist = sqrt((r_dist * r_dist) + (g_dist * g_dist) + (b_dist * b_dist)); % EUKLIDES
                        SumOfDistances=SumOfDistances+pix_dist;
                        Counter=Counter+1;
                    end
                end
            end
        end
        Ai=SumOfDistances/Counter;
        
        AvgDistB=0;
        %% computing b(i)
        for m=1:k
            if(m~=A)
                SumOfDistances=0;
                Counter=0;
                for i=1:X_size
                    for j=1:Y_size
                        if(mask(i,j)==m)
                            if(~(i==pixel(1) && j==pixel(2)))
                                r_dist=abs(i_pixel(1)-photo(i,j,1));
                                g_dist=abs(i_pixel(2)-photo(i,j,2));
                                b_dist=abs(i_pixel(3)-photo(i,j,3));
                                pix_dist = sqrt((r_dist * r_dist) + (g_dist * g_dist) + (b_dist * b_dist)); % EUKLIDES
                                SumOfDistances=SumOfDistances+pix_dist;
                                Counter=Counter+1;
                            end
                        end
                    end
                end
                if(AvgDistB~=0)
                    AvgDistB(end+1)=SumOfDistances/Counter;
                else
                    AvgDistB=SumOfDistances/Counter;
                end
        
            end
        end
        Bi=min(AvgDistB);
        %% determining SI(i)
        if (Ai==Bi)
            SI=0;
        elseif (Ai>Bi)
            SI=(Bi/Ai)-1;
        else
            SI=1-(Ai/Bi);
        end
        SI_list(x,y)=SI;
    end
end
Final_SI=mean(mean(SI_list));