
clear all
close all
clc

%%
load ExSession1_MRS_signal  % Load MRS data


%IMPORTANT THIS IS FUNCTION NEEDS TO BE ORIGINAL

PPM_Axis = Vangjush_PPM_Axis_Find(step,ndp,frequency);                             % [ppm] X axis
PPM_Ref = 4.7;                                                          % [ppm] Reference frequency
Axis_kHz = Vangjus_Part_Per_Million2_k_Hz(PPM_Axis,frequency,PPM_Ref);  % [kHz] Conversion from ppm to kHz of the axis
Time_Record=[0:step:(ndp-1)*step];
fig=100;
%%
% Decomposition of the signal using HSVD into k component
Sampling_Frequency=1/step;                                              % [Hz] Sampling frequency
%%
K=29;
[Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HSVD(MRS_single_signal,K,Sampling_Frequency,Time_Record,ndp);
freq_ppm=Frequency_Parameters*10^6/frequency+4.7;
idxfilt=find(freq_ppm>=4.5);
k_interest=idxfilt(1)-1;
mrs_water=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(k_interest:K),Damping_Parameters(k_interest:K),Amplitude_Parameters(k_interest:K),Phase_Parameters(k_interest:K));
mrs_filt=MRS_single_signal-mrs_water;
Frequency_known=3.9725493;
Damping_known=0.072981231;
Nr_Column=ndp/2;
%%
Str{1}= 'Filtered Signal HSVD';
Str{2}= 'Filtered Signal HTLSU';
Str{3}= 'Filtered Signal HTLSU PK FD';
Str{4}= 'Noisy Signal HSVD';
Str{5}= 'Noisy Signal HTLSU';
Str{6}= 'Noisy Signal HTLSU PK FD';

% Str1{1}= 'Original';
Str1{1}= 'HSVD';
Str1{2}= 'HTLSU';
Str1{3}= 'HTLSU PK FD';
%%
index=1;
Start=0;
h = waitbar(0,'Please wait...');
Ending=50;
Step=1;
for SNR=Start:Step:Ending
    [mrs_noisy,Noise] = noisy(mrs_filt,SNR);
    [Frequency_Parameters(1,:),Damping_Parameters(1,:),Amplitude_Parameters(1,:),Phase_Parameters(1,:)]=Vangjush_HSVD(mrs_noisy,K,Sampling_Frequency,Time_Record,ndp);
    [Frequency_Parameters(2,:),Damping_Parameters(2,:),Amplitude_Parameters(2,:),Phase_Parameters(2,:)]=Vangjush_HTLSU(mrs_noisy,K,Sampling_Frequency,Time_Record,ndp);
    [Frequency_Parameters(3,:),Damping_Parameters(3,:),Amplitude_Parameters(3,:),Phase_Parameters(3,:)]=Vangjush_HTLSU_PK_FD(mrs_noisy,K,Sampling_Frequency,Time_Record,Nr_Column,ndp,Frequency_known,Damping_known);
    
    %%
    mrs_filt_spectrum=(fftshift(fft(mrs_filt)));
    mrs_noisy_spectrum=(fftshift(fft(mrs_noisy)));
    %%
    for i=1:3
        Reconstructed_Signal(i,:)=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(i,:),Damping_Parameters(i,:),Amplitude_Parameters(i,:),Phase_Parameters(i,:));
        Residue_Signal(i,:)=mrs_filt-Reconstructed_Signal(i,:);
        RMSE(index,i,:)=real(Vangjush_RMSE(fftshift(fft(mrs_filt)),fftshift(fft(Reconstructed_Signal(i,:)))));
    end
    index=index+1;
    waitbar(SNR/Ending-Start,h)
end
%%
close  (h)
%%
SNR=Start:Step:Ending;
figure('units','normalized','outerposition',[0 0 1 1]);
plot(SNR,abs(RMSE),'LineWidth',2)
hold on
plot(SNR,abs(RMSE),'x','LineWidth',8)
legend(cellstr(Str1))
x=xlabel('SNR dB');
y=ylabel('RMSE ');
set(x,  'FontSize',18);
set(y,  'FontSize',18);
set(gca,'FontSize',18);











