clear all
close all
clc
%% 2
fig =1;
A1=[1 -2;-2 1];
A2=[1 -1.1;-1.1 1];
A1=1/sqrt(5)*A1;
A2=1/sqrt(2.21)*A2;

CondA1=cond(A1);
CondA2=cond(A2);

SNR=5:5:40;
for i=1:length(SNR)
    x(i,:,:)=rand(2,500);
    x1(:,:)=x(i,:,:);
    
    S1=A1*x1;
    S2=A2*x1;
    
    [Y1(i,:,:),~] = Vangjush_AddNoise(S1,SNR(i));
    [Y2(i,:,:),~] = Vangjush_AddNoise(S2,SNR(i));
    
    M1(:,:)=Y1(i,:,:);
    M2(:,:)=Y2(i,:,:);
    
    [U1,Sing1,V1]=svd(M1,'econ');
    [U2,Sing2,V2]=svd(M2,'econ');    
    
    
    x1_est_PCA=V1(:,1:2)';
    x2_est_PCA=V2(:,1:2)';
    
    A1_h_PCA=M1*pinv(x1_est_PCA);
    A2_h_PCA=M2*pinv(x2_est_PCA);    
    
    [SDR1(i,:),SIR1(i,:),SAR1(i,:)]=Vangjush_BSS_Evaluate(x1_est_PCA,squeeze(x(i,:,:)));
    [SDR2(i,:),SIR2(i,:),SAR2(i,:)]=Vangjush_BSS_Evaluate(x2_est_PCA,squeeze(x(i,:,:)));
    
    [A1_h(i,:,:),x1_est]=Vangjush_Fast_ICA_Final(M1);
    [A2_h(i,:,:),x2_est]=Vangjush_Fast_ICA_Final(M2);
    
%     A1_hat(:,:)=A1_h(i,:,:);
%     A2_hat(:,:)=A2_h(i,:,:);
%     
%     x1_est=pinv(A1_hat)*M1;
%     x2_est=pinv(A2_hat)*M2;
        
    [SDR3(i,:),SIR3(i,:),SAR3(i,:)]=Vangjush_BSS_Evaluate(x1_est,squeeze(x(i,:,:)));
    [SDR4(i,:),SIR4(i,:),SAR4(i,:)]=Vangjush_BSS_Evaluate(x2_est,squeeze(x(i,:,:)));
    
end
%%
SDR_B=[SDR1(:),SDR2(:);SDR3(:),SDR4(:)];
SIR_B=[SIR1(:),SIR2(:);SIR3(:),SIR4(:)];
SAR_B=[SAR1(:),SAR2(:);SAR3(:),SAR4(:)];
%%
SDR_1=[SDR1(:,1),SDR3(:,1)];
SDR_2=[SDR1(:,2),SDR3(:,2)];
SDR_3=[SDR2(:,1),SDR4(:,1)];
SDR_4=[SDR2(:,2),SDR4(:,2)];
%%
SIR_1=[SIR1(:,1),SIR3(:,1)];
SIR_2=[SIR1(:,2),SIR3(:,2)];
SIR_3=[SIR2(:,1),SIR4(:,1)];
SIR_4=[SIR2(:,2),SIR4(:,2)];
%%
SAR_1=[SAR1(:,1),SAR3(:,1)];
SAR_2=[SAR1(:,2),SAR3(:,2)];
SAR_3=[SAR2(:,1),SAR4(:,1)];
SAR_4=[SAR2(:,2),SAR4(:,2)];
%%
Vangjush_Plot_Evaluation(SNR,SDR_1)
title('SDR First Channel A1 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SDR_2)
title('SDR Second Channel A1 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SDR_3)
title('SDR First Channel A2 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SDR_4)
title('SDR Second Channel A2 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
Vangjush_Plot_Evaluation(SNR,SIR_1)
title('SIR First Channel A1 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SIR_2)
title('SIR Second Channel A1 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SIR_3)
title('SIR First Channel A2 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SIR_4)
title('SIR Second Channel A2 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
Vangjush_Plot_Evaluation(SNR,SAR_1)
title('SAR First Channel A1 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SAR_2)
title('SAR Second Channel A1 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SAR_3)
title('SAR First Channel A2 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
Vangjush_Plot_Evaluation(SNR,SAR_4)
title('SAR Second Channel A2 mixing matrix','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%% 
load mixedsignals
 [MM,x1_est]=Vangjush_Fast_ICA_Final(smix);
%  x1_est=MM'*smix;
 t=0:max(size(x1_est))-1;
 %%
Vangjush_PlotEEG(smix,t);
ylabel('Channel nr','FontSize',20)
xlabel('Time [sec]','FontSize',20)
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);
%%
Vangjush_PlotEEG(x1_est,t);
ylabel('Channel nr','FontSize',20)
xlabel('Time [sec]','FontSize',20)
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);
%%
fig=15;
Origin={'PCA','ICA'};

boxplot(SDR_B,Origin);
title('SDR','FontSize',15);
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);

boxplot(SIR_B,Origin);
title('SIR','FontSize',15);
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);

boxplot(SAR_B,Origin);
title('SAR','FontSize',15);
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);