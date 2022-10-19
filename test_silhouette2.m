clearvars
clc
for i=5:5    
    i_val=string(i);
    PhotoName=strcat("../sources-photos/a",i_val,".jpg");
    photo=imread(PhotoName);
    n=16;
    tic
    for k=i:1:i+3
        [mask,iterations,colors]=kmpp_mask(photo,k);    
        SI(k)=Fsilhouette2(photo,mask,k,colors);
    end
        plot(i:k,SI(i:k));
        k_val = [i:1:3+i];
    xlabel('liczba k')
    ylabel('Silhouette Index')
    PlotGraph=gca;
    grid on
    timer=toc;
    
    PlotName = strcat("../Silhouette/a",i_val,".png");
    exportgraphics(PlotGraph,PlotName);
    
    T = table(k_val',SI(i:k)');
    TableName = strcat("../Silhouette/a",i_val,".txt");
    writetable(T,TableName,'Delimiter','\t','WriteRowNames',true);
    clear SI;
end