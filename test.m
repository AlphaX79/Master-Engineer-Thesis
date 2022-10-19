clear vars 
clc
a1=imread("../sources-photos/37.jpg");

tic;
[image,k]=SI_Final(a1);
timer=toc;
k
imshow(image);