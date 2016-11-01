clear all
close all
clc
%%
fig=100;
load FECG
[Mixing_Matrix,Signals]=Vangjush_Fast_ICA_Final(S);
%%
Vangjush_PlotEEG(S,t);
ylabel('Channel nr','FontSize',20)
xlabel('Time [sec]','FontSize',20)
title('FECG before BSS','FontSize',20)
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);
%%
Vangjush_PlotEEG(Signals,t);
ylabel('Channel nr','FontSize',20)
xlabel('Time [sec]','FontSize',20)
title('FECG after BSS','FontSize',20)
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);