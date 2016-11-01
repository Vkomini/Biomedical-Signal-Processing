clear all
close all
clc
%% Part I: Decompose using HSVD & filter water @ 4.7ppm
load EEG_muscleArtifact
global fig;
fig=1;
%%
Start=0;
h = waitbar(0,'Please wait...');
Ending=50;
Step=1;
index=1;
PL=1;
for SNR=Start:Step:Ending
    [EEG_noisy,Noise] = Vangjush_AddNoise(EEG1,SNR);
    [~,EEG_Estimated]=Vangjush_ICA(EEG_noisy,fig,PL);
    [ChannelSignal1,W1,R1]=Vangjush_CCA(EEG1);
    [~,EEG_Estimated1]=Vangjush_Automated_CCA(ChannelSignal1,R1,W1,1,fig,PL);
    fig=1;
    RMSE(index,1)=real(Vangjush_RMSE(EEG_noisy,EEG_Estimated));
    RMSE(index,2)=real(Vangjush_RMSE(EEG_noisy,EEG_Estimated1));
    index=index+1;
    waitbar(index/length(Start:Step:Ending),h)
end
%%
close  (h)
%%
SNR=Start:Step:Ending;
figure,plot(SNR,abs(RMSE),'LineWidth',2)
hold on
plot(SNR,abs(RMSE),'x','LineWidth',8)
legend('ICA','CCA')
t=title('Performance of BSS');
x=xlabel('SNR dB');
y=ylabel('RMSE ');
set(x,  'FontSize',18);
set(y,  'FontSize',18);
set(t,  'FontSize',18);
set(gca,'FontSize',18);











