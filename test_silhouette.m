clearvars
clc
for i=1:5    
    i_val=string(i);
    PhotoName=strcat("../sources-photos/a",i_val,".jpg");
    photo=imread(PhotoName);
    n=16;
    AvgSI=zeros(1,n-1);
    tic
    for k=2:1:n
        [mask,iterations,colors]=kmpp_mask(photo,k);    
        SI=Fsilhouette(photo,mask,k,colors);
        AvgSI(k-1)=SI;
        clear SI;
    end
    plot(2:n,AvgSI);
        xlabel('liczba k')
        ylabel('Silhouette Index')
        PlotGraph=gca;
    [~,optimal_k]=max(AvgSI);
    optimal_k=optimal_k+1;
    grid on
    timer=toc;
    
    PlotName = strcat("../Silhouette_modified/a",i_val,".png");
    exportgraphics(PlotGraph,PlotName);
     k_val = [2:1:16];
    T = table(k_val',AvgSI');
    TableName = strcat("../Silhouette_modified/a",i_val,".txt");
    writetable(T,TableName,'Delimiter','\t','WriteRowNames',true);
end