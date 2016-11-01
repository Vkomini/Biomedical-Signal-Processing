clear all
close all
clc
%% Part I: Decompose using HSVD & filter water @ 4.7ppm
load EEG_muscleArtifact
global fig;
fig=1;
%%
Vangjush_PlotEEG(EEG2)
title('EEG2')
[fig]=Vangjush_Save_Images(fig);
%%
Vangjush_PlotEEG(EEG1)
title('EEG1')
[fig]=Vangjush_Save_Images(fig);
%%
[ChannelSignal1,W1,R1]=Vangjush_CCA(EEG1);
[ChannelSignal2,W2,R2]=Vangjush_CCA(EEG2);
%%
Vangjush_PlotEEG(ChannelSignal1)
title('CCA channel for EEG1')
[fig]=Vangjush_Save_Images(fig);
Vangjush_PlotEEG(ChannelSignal2)
title('CCA channel for  EEG2')
[fig]=Vangjush_Save_Images(fig);
%%
PL=10; % 1 for not saving the images and any other for saving the images
disp('Automated CCA for the EEG1..')
fig=8;
[fig,Signal_Reconstred1]=Vangjush_Automated_CCA(ChannelSignal1,R1,W1,1,fig,PL);
disp('Finished automated CCA for the EEG1 ..')
close all
%%
for i=1:min(size(EEG1))
    [SDR1(i,1),SIR1(i,1),SAR1(i,1)]=Vangjush_BSS_Evaluate(Signal_Reconstred1(i,:),EEG1(i,:));
end
%%
disp('Automated CCA for the EEG2..')
[fig,Signal_Reconstred2]=Vangjush_Automated_CCA(ChannelSignal2,R2,W2,2,fig,PL);
disp('Finished automated CCA for the EEG2 ..')
close all
%%
for i=1:min(size(EEG1))
    [SDR1(i,2),~,SAR1(i,2)]=Vangjush_BSS_Evaluate(Signal_Reconstred2(i,:),EEG2(i,:));
end
%%
fig=82;
figure('units','normalized','outerposition',[0 0 1 1])
Origin={'EEG1' 'EEG2' };
xlabel('[A.U]')
boxplot(SDR1,Origin)
set(gca,'fontsize', 25);
set(findobj(gca,'Type','text'),'FontSize',25)
title('SDR')
[fig]=Vangjush_Save_Images(fig);
figure('units','normalized','outerposition',[0 0 1 1])
boxplot(SAR1,Origin)
set(gca,'fontsize', 25);
set(findobj(gca,'Type','text'),'FontSize',25)
title('SAR')
xlabel('[A.U]')
[fig]=Vangjush_Save_Images(fig);
%%
fig=700;
PL=10; 
disp('Manual CCA for the EEG1..')
[fig,Signal_Reconstred11]=Vangjush_Manual_CCA(ChannelSignal1,R1,W1,1,fig,PL);
disp('Finished manual CCA for the EEG1 ..')
disp('Manual CCA for the EEG2..')
[fig,Signal_Reconstred22]=Vangjush_Manual_CCA(ChannelSignal2,R2,W2,2,fig,PL);
disp('Finished manual CCA for the EEG2 ..')
%%
for i=1:min(size(EEG1))
    [SDR11(i,1),~,SAR22(i,1)]=Vangjush_BSS_Evaluate(Signal_Reconstred11(i,:),EEG1(i,:));
end
for i=1:min(size(EEG1))
    [SDR11(i,2),~,SAR22(i,2)]=Vangjush_BSS_Evaluate(Signal_Reconstred1(i,:),EEG1(i,:));
end
%%
fig=500;
[Kurt]=Vangjush_Gaussianity(EEG1);
figure('units','normalized','outerposition',[0 0 1 1])
plot(Kurt,'x','LineWidth',10)
hold on
plot(Kurt,'r','LineWidth',3)
xlabel('Kurtosis','FontSize',20)
ylabel('Signal','FontSize',20)
title('Non-Gaussianity measure','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
[Kurt]=Vangjush_Gaussianity(EEG2);
figure('units','normalized','outerposition',[0 0 1 1])
plot(Kurt,'x','LineWidth',10)
hold on
plot(Kurt,'r','LineWidth',3)
xlabel('Kurtosis','FontSize',20)
ylabel('Signal','FontSize',20)
title('Non-Gaussianity measure','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
[fig,~]=Vangjush_ICA(EEG1,fig,0);
[fig,~]=Vangjush_ICA(EEG2,fig,0);
%%
% Test the ICA with arbitrary wave form
clear all
close all
clc
fig=600;
%%
load mixedsignals
%%
% Test ICA
[fig1,~]=Vangjush_ICA(smix,fig,0);
%%
% Test CCA
fig=606;
PL=10;
[ChannelSignal1,W1,R1]=Vangjush_CCA(smix);
[fig]=Vangjush_Manual_CCA(ChannelSignal1,R1,W1,1,fig);
disp('Finished automated CCA for the EEG1 ..')


