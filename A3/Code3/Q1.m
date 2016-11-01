clear all
close all
clc
%% 1
load Q1
iteration=50000;
fig=400;
%%
Dim=size(C4);
C444=C4;
C44=reshape(C4,Dim(1)*Dim(2),Dim(3)*Dim(4));

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(C2)),colorbar
set(gca,'FontSize',15);
title('C2');
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(C44)),colorbar
set(gca,'FontSize',15);
title('C4');
[fig]=Vangjush_Save_Images(fig);
%%
% Rearrange the vetors into NxMxK suitable for the CPD_ALS
C2=reshape(C2,1,size(C2,1),size(C2,2));
[A2,B2,C2]=Vangjush_CPD_ALS(C2,2,iteration);

C4=reshape(C4,size(C4,1),size(C4,2),size(C4,3)*size(C4,4));
[A4,B4,C4]=Vangjush_CPD_ALS(C4,2,iteration);
%%
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(A4)),colorbar
set(gca,'FontSize',15);
title('A');
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(B4)),colorbar
set(gca,'FontSize',15);
title('B');
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(C4)),colorbar
set(gca,'FontSize',15);
title('C');
[fig]=Vangjush_Save_Images(fig);
%%
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(A2)),colorbar
set(gca,'FontSize',15);
title('B');
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(B2)),colorbar
set(gca,'FontSize',15);
title('B');
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(C2)),colorbar
set(gca,'FontSize',15);
title('C');
[fig]=Vangjush_Save_Images(fig);
%%
%  Using tensorlab
rankC2=rankest(C2);
rankC4=rankest(C4);

[CPD_C2,output1]=cpd(C2,rankC2);
[CPD_C4,output2]=cpd(C444,rankC4);

for i=1:2
    figure('units','normalized','outerposition',[0 0 1 1])
    imagesc(abs(CPD_C2{i})),colorbar
    set(gca,'FontSize',15);
    t=strcat('C2-U',num2str(i));
    title(t)
    [fig]=Vangjush_Save_Images(fig);
end


for i=1:4
    figure('units','normalized','outerposition',[0 0 1 1])
    imagesc(abs(CPD_C4{i})),colorbar
    set(gca,'FontSize',15);
    t=strcat('C4-U',num2str(i));
    title(t)
    [fig]=Vangjush_Save_Images(fig);
end

