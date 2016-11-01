clear all
close all
clc
%% Part I: Decompose using HSVD & filter water @ 4.7ppm

load ExSession1_MRS_signal  % Load MRS data


%IMPORTANT THIS IS FUNCTION NEEDS TO BE ORIGINAL

PPM_Axis = Vangjush_PPM_Axis_Find(step,ndp,frequency);                             % [ppm] X axis
PPM_Ref = 4.7;                                                          % [ppm] Reference frequency
Axis_kHz = Vangjus_Part_Per_Million2_k_Hz(PPM_Axis,frequency,PPM_Ref);  % [kHz] Conversion from ppm to kHz of the axis
Time_Record=linspace(0,(ndp-1)*step,ndp);                               % [Sec] Time duration
Time_Record=[0:step:(ndp-1)*step];
fig=1;
%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(Time_Record,real((MRS_single_signal)));
x=xlabel('Time [Sec]');
y=ylabel('Amplitude (a.u.)');
t=title('MRS signal with water component in time domain');
set(x,  'FontSize',18);
set(y,  'FontSize',18);
set(t,  'FontSize',18);
set(gca,'FontSize',18);
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
plot(PPM_Axis,real(fftshift(fft(MRS_single_signal))))
x=xlabel('ppm');
y=ylabel('Amplitude (a.u.)');
t=title('MRS Signal with water in ppm domain');
set(x,  'FontSize',18);
set(y,  'FontSize',18);
set(t,  'FontSize',18);
set(gca,'FontSize',18);
set(gca, 'xdir', 'reverse');
xlim([0 8])
[fig]=Vangjush_Save_Images(fig);
%%
% Decomposition of the signal using HSVD into k component
Sampling_Frequency=1/step;                                              %  [Hz] Sampling frequency
K_Est=40;                                                                   %  Model order to be used for the decomposition
k=1:K_Est;                                                                  % Raw of different order of components
legendCell=strcat('Model order=',strtrim(cellstr(num2str(k(:)))));      % Generation fo cells for the legend
%%
% Decomposition of the signal using hsvdU subspace method
% [Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HSVD(MRS_single_signal,K,Sampling_Frequency,Time_Record,ndp);
%%
index=1;
ste=2;
start=5;
Ending=30;
for K=start:ste:Ending
    % Plot components from the decomposition
    [Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HSVD(MRS_single_signal,K,Sampling_Frequency,Time_Record,ndp);
    freq_ppm=Frequency_Parameters*10^6/frequency+4.7;
    idxfilt=find(freq_ppm>=4.5);
    figure('units','normalized','outerposition',[0 0 1 1])
    for i=1:K
        MRS_Individual_Component_Reconstructed(i,:)=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(i),Damping_Parameters(i),Amplitude_Parameters(i),Phase_Parameters(i));
        MRS_Individual_Component_Spectrum(i,:)=(fftshift(fft(MRS_Individual_Component_Reconstructed(i,:))));
        component=sprintf('Spectrum for the componenet %d',i);
        subplot1 = subplot(round(sqrt(K)),ceil(K/sqrt(K)),i);
        plot(PPM_Axis,real(MRS_Individual_Component_Spectrum(i,:)),'b');
        Vangjush_Costum_Plot()
        t=title(component,'FontSize',12);
        xlabel('','FontSize',12);
    end
    %%
    % Plot Water component for different decomposition level
    figure('units','normalized','outerposition',[0 0 1 1])
    for i=1:K
        MRS_Individual_Component_Reconstructed(i,:)=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(1:i),Damping_Parameters(1:i),Amplitude_Parameters(1:i),Phase_Parameters(1:i));
        MRS_Individual_Component_Spectrum(i,:)=(fftshift(fft(MRS_Individual_Component_Reconstructed(i,:))));
        component=sprintf('Spectrum Water for %d',i);
        subplot1 = subplot(round(sqrt(K)),ceil(K/sqrt(K)),i);
        plot(PPM_Axis,real(MRS_Individual_Component_Spectrum(i,:)),'b');
        Ma=max(real(MRS_Individual_Component_Spectrum(i,:)));
        Mi=min(real(MRS_Individual_Component_Spectrum(i,:)));
        hold on
        plot(4.7*ones(size(PPM_Axis)),linspace(Mi,Ma,length(PPM_Axis)),'r')
        Vangjush_Costum_Plot()        
    end
    %%
    k_interest=idxfilt(1)-1;
    [Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HSVD(MRS_single_signal,K,Sampling_Frequency,Time_Record,ndp);
    mrs_water=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(k_interest:K),Damping_Parameters(k_interest:K),Amplitude_Parameters(k_interest:K),Phase_Parameters(k_interest:K));
    mrs_filt=MRS_single_signal-mrs_water;
    DataSize=length(mrs_filt);
    signma=var(mrs_filt(DataSize-100:DataSize));
    [Hanke_Matrix,~]=Vangjush_Hankel_Matrix(MRS_single_signal,ndp);
    [L,M]=size(Hanke_Matrix);
    MDL(index)=Vangjush_MDL(MRS_single_signal,ndp,K);
    RankDetermination(index)=sqrt(2*max(L,M))*signma;
    index=index+1;
    mrs_water_spectrum=(fftshift(fft(mrs_water)));
    component=sprintf('Spectrum for %d componenet ',i);
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(PPM_Axis,real(mrs_water_spectrum),'b');
    Vangjush_Costum_Plot()
    t=title(component);
    [fig]=Vangjush_Save_Images(fig);
    set(gca,'fontsize', 18);
    %%
    mrs_filt_spectrum=fftshift(fft(mrs_filt));
    figure('units','normalized','outerposition',[0 0 1 1])
    plot(PPM_Axis,real(mrs_filt_spectrum))
    Vangjush_Costum_Plot()
    t=title('MRS filtered signal');
    set(t,'fontsize', 18);
    set(gca,'fontsize', 18);
    [fig]=Vangjush_Save_Images(fig);
end
%%
figure('units','normalized','outerposition',[0 0 1 1]);
plot(start:ste:Ending,RankDetermination,'x','LineWidth',18)
hold on
plot(start:ste:Ending,RankDetermination,'r','LineWidth',3)
x=xlabel('Model order');
y=ylabel('Rank determination');
t=title('Model order selection via Rank determination');
set(x,'fontsize', 18);
set(y,'fontsize', 18);
set(t,'fontsize', 18);
set(gca,'fontsize', 18);
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
plot(start:ste:Ending,MDL,'x','LineWidth',18)
hold on
plot(start:ste:Ending,MDL,'r','LineWidth',3)
x=xlabel('Model order');
y=ylabel('MDL');
t=title('Model order selection via Minimum distance length');

set(x,'fontsize', 18);
set(y,'fontsize', 18);
set(t,'fontsize', 18);
set(gca,'fontsize', 18);
[fig]=Vangjush_Save_Images(fig);
%%
K=40;
[Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HSVD(MRS_single_signal,K,Sampling_Frequency,Time_Record,ndp);
freq_ppm=Frequency_Parameters*10^6/frequency+4.7;
idxfilt=find(freq_ppm>=4.5);
k_interest=idxfilt(1)-1;
mrs_water=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(k_interest:K),Damping_Parameters(k_interest:K),Amplitude_Parameters(k_interest:K),Phase_Parameters(k_interest:K));
mrs_filt=MRS_single_signal-mrs_water;
%%

