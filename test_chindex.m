    clearvars
    clc
for i=1:1:5   
    i_val=string(i);
    PhotoName=strcat("../sources-photos/a",i_val,".jpg");
    photo=imread(PhotoName);
    tic
    n=16;
    score=zeros(1,n);
    for k=1:n
        [mask, it_count,colors]= kmpp_mask(photo, k);
        score(k)=CHIndex(photo,mask,k,colors);
    end
    timer=toc;
    plot(1:n,score(:))
    xlabel('liczba k')
    ylabel('CH Index')
    PlotGraph=gca;
    [~,optimal_k]=max(score);
    optimal_k=optimal_k+1;
    grid on

    PlotName = strcat("../CHIndex/a",i_val,".png");
    exportgraphics(PlotGraph,PlotName);
     k_val = [1:16];
    T = table(k_val',score');
    TableName = strcat("../CHIndex/a",i_val,".txt");
    writetable(T,TableName,'Delimiter','\t','WriteRowNames',true);

end