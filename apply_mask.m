function [result]= apply_mask(image, mask, colors)
    image=double(image);
    [X_size, Y_size,~]=size(image);
    result=uint8(zeros(X_size,Y_size,3));
    [k,~]=size(colors);
    for x=1:X_size
        for y=1:Y_size
            for i=1:k
                if(mask(x,y)==i)
                    result(x,y,1)=uint8(colors(i,1));
                    result(x,y,2)=uint8(colors(i,2));
                    result(x,y,3)=uint8(colors(i,3));
                end
            end
        end
    end
end