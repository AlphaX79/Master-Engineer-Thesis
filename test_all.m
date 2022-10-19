clc
clear vars
for i=1:44
%     i=4;
    i_val=string(i);
    PhotoName=strcat("../sources-photos/",i_val,".jpg");
    photo=imread(PhotoName);
    [height, width] = size(photo(:,:,1));
    tic
    n=16;
    score_SI=zeros(1,n);
    score_CHI=zeros(1,n);
    score_EM=zeros(1,n);
    mask=zeros(height,width,n);
    colors=zeros(16,3,16);
    timer_CHI=zeros(5,16);
    timer_SI=zeros(5,16);
    timer_EM=zeros(5,16);

    for k=2:1:n
        [mask(:,:,k), it_count,colors(1:k,:,k)]= kmpp_mask(photo, k);
        tic
        score_CHI(k)=CHIndex(photo,mask(:,:,k),k,colors(1:k,:,k));
        timer_CHI(i,k)=toc;
        tic
        score_EM(k)=ElbowMethod(photo,mask(:,:,k),colors(1:k,:,k));
        timer_EM(i,k)=toc;
        tic;
        score_SI(k)=Fsilhouette(photo,mask(:,:,k),k,colors(1:k,:,k));
        timer_SI(i,k)=toc;
    end
    k_val = [1:16];

    %% plot CHI
    plot(k_val(2:end),score_CHI(2:end))
    xlabel('liczba k')
    ylabel('CH Index')
    PlotGraph=gca;
    PlotName = strcat("../CHIndex/",i_val,".png");
    exportgraphics(PlotGraph,PlotName);
    T = table(k_val',score_CHI',timer_CHI(i,:)');
    TableName = strcat("../CHIndex/",i_val,".txt");
    writetable(T,TableName,'Delimiter','\t','WriteRowNames',true);
    close all;

    %% plot SI
    plot(k_val(2:end),score_SI(2:end))
    xlabel('liczba k')
    ylabel('wartość SI')
    PlotGraph=gca;
    PlotName = strcat("../Silhouette_modified/",i_val,".png");
    exportgraphics(PlotGraph,PlotName);
    T = table(k_val',score_SI',timer_SI(i,:)');
    TableName = strcat("../Silhouette_modified/",i_val,".txt");
    writetable(T,TableName,'Delimiter','\t','WriteRowNames',true);
    close all;

    %% plot Elbow
    plot(k_val(2:end),score_EM(2:end))
    xlabel('liczba k')
    ylabel('wartość (metoda łokciowa)')
    PlotGraph=gca;
    PlotName = strcat("../ElbowMethod/",i_val,".png");
    exportgraphics(PlotGraph,PlotName);
    T = table(k_val',score_EM',timer_EM(i,:)');
    TableName = strcat("../ElbowMethod/",i_val,".txt");
    writetable(T,TableName,'Delimiter','\t','WriteRowNames',true);
    close all;

end