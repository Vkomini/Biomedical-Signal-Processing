clear all
close all
clc
%% Part I: Decompose using HSVD & filter water @ 4.7ppm

load ExSession1_MRS_signal  % Load MRS data


%IMPORTANT THIS IS FUNCTION NEEDS TO BE ORIGINAL

PPM_Axis = Vangjush_PPM_Axis_Find(step,ndp,frequency);                             % [ppm] X axis
PPM_Ref = 4.7;                                                          % [ppm] Reference frequency
Axis_kHz = Vangjus_Part_Per_Million2_k_Hz(PPM_Axis,frequency,PPM_Ref);  % [kHz] Conversion from ppm to kHz of the axis
% Time_Record=linspace(0,(ndp-1)*step,ndp);                               % [Sec] Time duration
Time_Record=[0:step:(ndp-1)*step];
fig=100;
%%
% Decomposition of the signal using HSVD into k component
Sampling_Frequency=1/step;                                              % [Hz] Sampling frequency
K=40;                                                                   % Model order to be used for the decomposition
k=1:K;                                                                  % Raw of different order of components
% legendCell=strcat('Model order=',strtrim(cellstr{num2str(k(:))}));      % Generation fo cells for the legend
%%
% Part II
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
[Frequency_Parameters(1,:),Damping_Parameters(1,:),Amplitude_Parameters(1,:),Phase_Parameters(1,:)]=Vangjush_HSVD(mrs_filt,K,Sampling_Frequency,Time_Record,ndp);
[Frequency_Parameters(2,:),Damping_Parameters(2,:),Amplitude_Parameters(2,:),Phase_Parameters(2,:)]=Vangjush_HTLSU(mrs_filt,K,Sampling_Frequency,Time_Record,ndp);
[Frequency_Parameters(3,:),Damping_Parameters(3,:),Amplitude_Parameters(3,:),Phase_Parameters(3,:)]=Vangjush_HTLSU_PK_FD(mrs_filt,K,Sampling_Frequency,Time_Record,Nr_Column,ndp,Frequency_known,Damping_known);
%%
noise_std=std(mrs_filt(end-299:end)); % get standard deviation of the last 300 points of the water filtered signal
rng(250) % set the seed for the random noise generator
mrs_noisy=mrs_filt+normrnd(0,noise_std,[1 ndp]); % add noise to the water filtered signal: m=0, StDev=std
[Frequency_Parameters(4,:),Damping_Parameters(4,:),Amplitude_Parameters(4,:),Phase_Parameters(4,:)]=Vangjush_HSVD(mrs_noisy,K,Sampling_Frequency,Time_Record,ndp);
[Frequency_Parameters(5,:),Damping_Parameters(5,:),Amplitude_Parameters(5,:),Phase_Parameters(5,:)]=Vangjush_HTLSU(mrs_noisy,K,Sampling_Frequency,Time_Record,ndp);
[Frequency_Parameters(6,:),Damping_Parameters(6,:),Amplitude_Parameters(6,:),Phase_Parameters(6,:)]=Vangjush_HTLSU_PK_FD(mrs_noisy,K,Sampling_Frequency,Time_Record,Nr_Column,ndp,Frequency_known,Damping_known);
%%
Str{1}= 'Filtered Signal HSVD';
Str{2}= 'Filtered Signal HTLSU';
Str{3}= 'Filtered Signal HTLSU PK FD';
Str{4}= 'Noisy Signal HSVD';
Str{5}= 'Noisy Signal HTLSU';
Str{6}= 'Noisy Signal HTLSU PK FD';

Str1{1}= 'Original';
Str1{2}= 'HSVD';
Str1{3}= 'HTLSU';
Str1{4}= 'HTLSU PK FD';

%%
mrs_filt_spectrum=(fftshift(fft(mrs_filt)));
mrs_noisy_spectrum=(fftshift(fft(mrs_noisy)));

%%
figure('units','normalized','outerposition',[0 0 1 1]);plot(PPM_Axis,real(mrs_filt_spectrum),'b');
Vangjush_Costum_Plot()
[fig]=Vangjush_Save_Images(fig);
title('Filtered Signal','FontSize',18)

figure('units','normalized','outerposition',[0 0 1 1]);plot(PPM_Axis,real(mrs_noisy_spectrum),'b');
Vangjush_Costum_Plot()
title('Noisy Signal','FontSize',18)
[fig]=Vangjush_Save_Images(fig);

%%
for i=1:6
    Reconstructed_Signal(i,:)=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(i,:),Damping_Parameters(i,:),Amplitude_Parameters(i,:),Phase_Parameters(i,:));
    if i<=3
        Residue_Signal(i,:)=mrs_filt-Reconstructed_Signal(i,:);
        Mean(i,:)=abs(mean(Residue_Signal(i,:)));
        Variance(i,:)=abs(var(Residue_Signal(i,:)));
%          RMSE(i,:)=Vangjush_RMSE(mrs_filt,Reconstructed_Signal(i,:));
    else
        Residue_Signal(i,:)=mrs_filt-Reconstructed_Signal(i,:);
        Mean(i,:)=abs(mean(Residue_Signal(i,:)));
        Variance(i,:)=abs(var(Residue_Signal(i,:)));
%          RMSE(i,:)=Vangjush_RMSE(mrs_filt,Reconstructed_Signal(i,:));
    end
    Reconstructed_Signal_Spectrum(i,:)=(fftshift(fft(Reconstructed_Signal(i,:))));
    Residue_Signal_Spectrum(i,:)=(fftshift(fft(Residue_Signal(i,:))));
    Vangjush_Plot_Individual_Component(Frequency_Parameters(i,:),Damping_Parameters(i,:),Amplitude_Parameters(i,:),Phase_Parameters(i,:),Time_Record,PPM_Axis,K)
    suptitle(Str{i})
    [fig]=Vangjush_Save_Images(fig);
    
    %%
    figure
    plot(PPM_Axis,real(Residue_Signal_Spectrum(i,:)),'b');
    title(Str{i},'FontSize',18)
    Vangjush_Costum_Plot()
    [fig]=Vangjush_Save_Images(fig);
end

%%
Vangjush_Header_2_Latex_Table('11')
Vangjush_Parameter_2_Latex_Table(Frequency_Parameters,'1')
Vangjush_Parameter_2_Latex_Table(Damping_Parameters,'2')
Vangjush_Parameter_2_Latex_Table(Amplitude_Parameters,'3')
Vangjush_Parameter_2_Latex_Table(Phase_Parameters,'4')
Parameters= [abs(Mean),abs(Variance)];
Vangjush_Mean_Variance_2_Latex_Table(Parameters,'5')
%%
figure('units','normalized','outerposition',[0 0 1 1])

plot(PPM_Axis,real(mrs_filt_spectrum),'c','LineWidth',2)
hold on
plot(PPM_Axis,real(Reconstructed_Signal_Spectrum(1:3,:)),'LineWidth',2)
Vangjush_Costum_Plot()
legend(cellstr(Str1))
title('Filtered Signal','FontSize',18)
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])

plot(PPM_Axis,real(mrs_noisy_spectrum),'c','LineWidth',2)
hold on
plot(PPM_Axis,real(Reconstructed_Signal_Spectrum(4:6,:)),'LineWidth',2)
Vangjush_Costum_Plot()
legend(cellstr(Str1))
title('Noisy Signal','FontSize',18)
[fig]=Vangjush_Save_Images(fig);
close all
%%