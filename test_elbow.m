for i=1:5
%     i=1;
    i_val=string(i);
    PhotoName=strcat("../sources-photos/a",i_val,".jpg");
    photo=imread(PhotoName);
    tic
    n=16;
    score=zeros(1,n);
    for k=1:n
        [mask, it_count,colors]= kmpp_mask(photo, k);
        score(k)=ElbowMethod(photo,mask,colors);
    end
    timer=toc;
    k_val = [1:16];
    plot(1:n,score)
    xlabel('liczba k')
    ylabel('wartość')
    grid on
    PlotGraph=gca;

    PlotName = strcat("../ElbowMethod/a",i_val,".png");
    exportgraphics(PlotGraph,PlotName);
    
    T = table(k_val',score');
    TableName = strcat("../ElbowMethod/a",i_val,".txt");
    writetable(T,TableName,'Delimiter','\t','WriteRowNames',true);
%     close all;
 
end