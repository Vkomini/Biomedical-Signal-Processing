clear all
close all
clc
%% Part IIII

load 1  % Load MRS data
clear a
% Data1(1:400,:,:)=[];
%%
dimensions=size(Data1);
ndp=max(dimensions);
Sampling_Freq=100e6;
T_sampling=1/Sampling_Freq;
Time_Record=[0:T_sampling:(ndp-1)*T_sampling];
Freq=1e-6*linspace(-Sampling_Freq/2,Sampling_Freq/2,ndp);
fig=800;
%%
US_Signal=squeeze(Data1(:,2,1));
% US_Signal=
%%


figure('units','normalized','outerposition',[0 0 1 1])
Temp1=abs(fftshift(fft(US_Signal)));
Temp2=20*log10((Temp1./max(Temp1)));
plot(Freq,Temp2,'LineWidth',1);
x=xlabel('Freq [MHz]');
y=ylabel('Amplitude (dB)');
t=title('US signal in freq domain');
Vangjush_Costum(x,y,t,fig)
xlim([0 max(Freq)])
[fig]=Vangjush_Save_Images_1(fig);
%%
% Decomposition of the signal using HSVD into k component
K=28;                                                                   % Model order to be used for the decomposition
k=1:K;                                                                  % Raw of different order of components
legendCell=strcat('Model order=',strtrim(cellstr(num2str(k(:)))));      % Generation fo cells for the legend
%%
for i=1:3
    US_Signal_Neig{i}=squeeze(Data1(:,i,1));
    [Freq_Para,Damp_Para,Amp_Para,Phas_Para]=Vangjush_HSVD(US_Signal_Neig{i},K,Sampling_Freq,Time_Record,ndp);
    %%
    count=1;
    for j=1:K
        if abs(Freq_Para(j))>7e6||abs(Freq_Para(j))<2e6
            Index(count)=j;
            count=count+1;
        end
    end
    %%
    Freq_Para1=Freq_Para(Index);
    Damp_para1=Damp_Para(Index);
    Amp_Para1=Amp_Para(Index);
    Phas_Para1=Phas_Para(Index);
    US_Recons{i}=Vangjush_Reconstruct_Components(Time_Record,Freq_Para1,Damp_para1,Amp_Para1,Phas_Para1);
    US_Signal_Filt{i}=squeeze(US_Signal_Neig{i})-(squeeze(US_Recons{i}'));
end
%%
figure('units','normalized','outerposition',[0 0 1 1])
Temp1=abs(fftshift(fft(US_Signal_Filt{2})));
Temp2=Temp1./max(Temp1);
Temp3=20*log10(Temp2);
plot(Freq,Temp3,'LineWidth',1);
x=xlabel('Freq [MHz]');
y=ylabel('Amplitude (dB)');
t=title('Artefact removed US signal in frequency domain');
Vangjush_Costum(x,y,t,fig)
xlim([0 max(Freq)])
[fig]=Vangjush_Save_Images_1(fig);
%%
[Freq_Para,Damp_Para,Amp_Para,Phas_Para]=Vangjush_HTLSU(US_Signal_Filt{2},K,Sampling_Freq,Time_Record,ndp);

%%
US_Sign_Cl(1,:)=US_Signal_Filt{1};
US_Sign_Cl(2,:)=US_Signal_Filt{2};
US_Sign_Cl(3,:)=US_Signal_Filt{3};
[Signal_Filt1{1}]=Vangush_Cadzow(US_Signal_Filt{2}, K, ndp);
[Signal_Filt1{2}]=Vangush_Minimum_Variance(US_Signal_Filt{2}, K, ndp);
[Signal_Filt1{3}]=Vangjush_Multi_Channel_Cadzow(US_Sign_Cl, K, ndp,2);
%% SNR computation
Spectrum{1}=(abs(fftshift(fft(US_Signal))));
Spectrum{2}=(abs(fftshift(fft(US_Signal_Filt{2}))));
for i=1:3
    Spectrum{2+i}=(abs(fftshift(fft(Signal_Filt1{i}))));
end

[~,ind1]=min(abs(Freq-(2e6)));
[~,ind2]=min(abs(Freq-(-2e6)));
[~,ind3]=min(abs(Freq-(7e6)));
[~,ind4]=min(abs(Freq-(-7e6)));
for i=1:5
    TempSpectrum=Spectrum{i};
    TempSpectrum1=[TempSpectrum(1:ind4)',TempSpectrum(ind3:end)',TempSpectrum(ind2:ind1)'];
    TempSpectrum2=[TempSpectrum(ind4:ind2)',TempSpectrum(ind1:ind3)'];
    SNR(i)=20*log10(sum(TempSpectrum2)/sum(TempSpectrum1));
end
%%
%%

%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(Freq,20*log10(Spectrum{1}./max(Spectrum{1})),'b','LineWidth',1);
hold on
clear Temp3
for i=1:3
    Temp1=abs(fftshift(fft(Signal_Filt1{i})));
    Temp2=Temp1./max(Temp1);
    Temp3{i}=20*log10(Temp2);
end
plot(Freq,Temp3{1},'x','LineWidth',2);
hold on
plot(Freq,Temp3{2},'k','LineWidth',1);
hold on
plot(Freq,Temp3{3},'g','LineWidth',1);
x=xlabel('Freq [MHz]');
y=ylabel('Amplitude (dB)');
t=title('Filtered US signal in frequency domain');
legend('Orignal signal','Cadzow','MV','MCC','Location','northoutside','Orientation','horizontal')
Vangjush_Costum(x,y,t,fig)
xlim([0 max(Freq)])
[fig]=Vangjush_Save_Images_1(fig);
%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(Time_Record,real((US_Signal)));
x=xlabel('Time [Sec]');
y=ylabel('Amplitude (a.u.)');
t=title('US signal in time domain');
Vangjush_Costum(x,y,t,fig)
[fig]=Vangjush_Save_Images_1(fig);
%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(Time_Record,real((US_Signal_Filt{2})));
x=xlabel('Time [Sec]');
y=ylabel('Amplitude (a.u.)');
t=title('Artefact removed US signal in time domain');
Vangjush_Costum(x,y,t,fig)
[fig]=Vangjush_Save_Images_1(fig);
%%
for i=1:3
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(Time_Record,real((Signal_Filt1{i})));
    x=xlabel('Time [Sec]');
    y=ylabel('Amplitude (a.u.)');
    if i==1
        t=title('Filtered US signal via Cadzow in time domain');
    elseif i==2
        t=title('Filtered US signal via MV in time domain');
    elseif i==3
        t=title('Filtered US signal via MCC in time domain');
    end
    Vangjush_Costum(x,y,t,fig)
    [fig]=Vangjush_Save_Images_1(fig);
end