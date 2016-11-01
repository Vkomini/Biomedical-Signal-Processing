function Vangjush_Optional_Plots(Parameters)
% clear all
% close all
% clc
%%
% load Reproducability
for i=1:40
    Temp=Parameters(i);
    LLE(i)=Temp.LLE;
    ApEn(i)=Temp.ApEn;
    Slop(i)=Temp.Slop;
    HE(i)=Temp.HE;
    DFA_FirstPart(i)=Temp.DFA_FirstPart;
    DFA_Second_Part(i)=Temp.DFA_Second_Part;
    Box(i)=Temp.Box;
    CD_Grassberger_Procaccia(i)=Temp.CD_Grassberger_Procaccia;
    CD_Gaussian_Kernel(i)=Temp.CD_Gaussian_Kernel;
end
subplot(331),hist(LLE),title('LLE'),xlabel(''),ylabel('Repetition')
subplot(332),hist(ApEn),title('ApEn'),xlabel(''),ylabel('Repetition')
subplot(333),hist(Slop),title('Slop'),xlabel(''),ylabel('Repetition')
subplot(334),hist(HE),title('HE'),xlabel(''),ylabel('Repetition')
subplot(335),hist(DFA_FirstPart),title('DFA-First-Part'),xlabel(''),ylabel('Repetition')
subplot(336),hist(DFA_Second_Part),title('DFA-Second-Part'),xlabel(''),ylabel('Repetition')
subplot(337),hist(Box),title('Box'),xlabel(''),ylabel('Repetition')
subplot(338),hist(CD_Grassberger_Procaccia),title('CD-Grassberger-Procaccia'),xlabel(''),ylabel('Repetition')
subplot(339),hist(CD_Gaussian_Kernel),title('CD-Gaussian-Kernel'),xlabel(''),ylabel('Repetition')
suptitle('Reproducability')