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
fig=1000;
%%
% Decomposition of the signal using HSVD into k component
Sampling_Frequency=1/step;                                              % [Hz] Sampling frequclcency
K=40;                                                                   % Model order to be used for the decomposition
k=1:K;                                                                  % Raw of different order of components
legendCell=strcat('Model order=',strtrim(cellstr(num2str(k(:)))));      % Generation fo cells for the legend
%%

% Part III
Component_Number=K;
PositionOfMainVoxel=623;                                              % Postion of the voxel of interest
NrOfVoxels=32;                                                        % Number of voxels
DimensionConsideration=3;                                             % Dimension consideratation of the neigbhours it has to odd number
maner=1;                                                              % Describes the manner of neighbourhooding 1+> full, 1=> horizontally and vertically, 2=> diagonally and anti-diagonally
Strct.Sampling_Frequency=Sampling_Frequency;
Strct.Time_Record=Time_Record;
Strct.frequency=frequency;
MRS_single_signal=MRS_grid_signal(PositionOfMainVoxel,:);

K=28;
[Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HSVD(MRS_single_signal,K,Sampling_Frequency,Time_Record,ndp);
freq_ppm=Frequency_Parameters*10^6/frequency+4.7;
idxfilt=find(freq_ppm>=4.5);
k_interest=idxfilt(1)-1;
Indexes=k_interest:K;
mrs_water=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(Indexes),Damping_Parameters(Indexes),Amplitude_Parameters(Indexes),Phase_Parameters(Indexes));
mrs_filt=MRS_single_signal-mrs_water;

%%
[Signal_Filt(1,:)]=Vangjush_Cadzow(mrs_filt, K, ndp);
Signal_Filt_Spectrum(1,:)=(fftshift(fft(Signal_Filt(1,:))));
figure('units','normalized','outerposition',[0 0 1 1]);
plot(PPM_Axis,real(Signal_Filt_Spectrum(1,:)),'b','LineWidth',2);
Vangjush_Costum_Plot()
title('Cadzow','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
[Signal_Filt(2,:)]=Vangush_Minimum_Variance(mrs_filt, K, ndp);
Signal_Filt_Spectrum(2,:)=(fftshift(fft(Signal_Filt(2,:))));
figure('units','normalized','outerposition',[0 0 1 1]);
plot(PPM_Axis,real(Signal_Filt_Spectrum(2,:)),'b','LineWidth',2);
Vangjush_Costum_Plot()
title('Minimum Variance','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
[Signal_Filt(3,:)]=Vangjush_Multi_Channel_Enhanced(MRS_grid_signal, K, ndp,PositionOfMainVoxel,DimensionConsideration,2,Strct);
Signal_Filt_Spectrum(3,:)=(fftshift(fft(Signal_Filt(3,:))));
figure('units','normalized','outerposition',[0 0 1 1]);
plot(PPM_Axis,real(Signal_Filt_Spectrum(3,:)),'b','LineWidth',2);
Vangjush_Costum_Plot()
title('Multi Channel','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
disp('Find the best comnbiation...')
manerOp=0;
CompOp=0;
DimConsOpt=0;
SNR_Opt=0;
ind1=1;
close all
h = waitbar(0,'Please wait...');
for maner=3:-1:1;
    ind2=1;
    for Comp=25:30
        K=Comp;
        ind3=1;
        for DimensionConsideration=3:2:7
            [Signal_Filt(4,:)]=Vangjush_Multi_Channel_Enhanced(MRS_grid_signal, K, ndp,PositionOfMainVoxel,DimensionConsideration,maner,Strct);
            Signal_Filt_Spectrum(4,:)=(fftshift(fft(Signal_Filt(4,:))));
            SNR1(ind1,ind2,ind3)=20*log(std(Signal_Filt(4,:))/std(Signal_Filt(4,length(Time_Record)-100:length(Time_Record))));
            if SNR_Opt<SNR1(ind1,ind2,ind3)
                SNR_Opt=SNR1(ind1,ind2,ind3);
                manerOp=maner;
                CompOp=Comp;
                DimConsOpt=DimensionConsideration;
            end
            
            waitbar((ind3+ind2+ind1)/(length(3:2:7)*length(25:30)*length(3:-1:1)),h)
            ind3=ind3+1;
        end
        ind2=ind2+1;
    end
    ind1=ind1+1;
end
close(h)
disp('finished...')
%%
[Signal_Filt(4,:)]=Vangjush_Multi_Channel_Enhanced(MRS_grid_signal, CompOp, ndp,PositionOfMainVoxel,DimConsOpt,manerOp,Strct);
Signal_Filt_Spectrum(4,:)=(fftshift(fft(Signal_Filt(4,:))));
figure('units','normalized','outerposition',[0 0 1 1]);
plot(PPM_Axis,real(Signal_Filt_Spectrum(4,:)),'b','LineWidth',2);
Vangjush_Costum_Plot()
title('Multi Channel Enhanced','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
for i=1:5
    if i==5
        SNR(i)=20*log(std(mrs_filt)/std(mrs_filt(length(mrs_filt)-100:length(mrs_filt))));
    else
        SNR(i)=20*log(std(Signal_Filt(i,:))/std(Signal_Filt(i,length(Time_Record)-100:length(Time_Record))));
    end
end
%%
clear Frequency_Parameters_est
clear Damping_Parameters_est
clear Amplitude_Parameters_est
clear Phase_Parameters_est
K=28;
for i=1:1:5
    if i==1
        [Frequency_Parameters_est(i,:),Damping_Parameters_est(i,:),Amplitude_Parameters_est(i,:),Phase_Parameters_est(i,:)]=Vangjush_HTLSU(mrs_filt,K,Sampling_Frequency,Time_Record,ndp);
    elseif i==5
        if CompOp>K
            [Frequency_Parameters_est(i,:),Damping_Parameters_est(i,:),Amplitude_Parameters_est(i,:),Phase_Parameters_est(i,:)]=Vangjush_HTLSU(Signal_Filt(i-1,:),CompOp,Sampling_Frequency,Time_Record,ndp);
        elseif CompOp<K
            [temp1,temp2,temp3,temp4]=Vangjush_HTLSU(Signal_Filt(i-1,:),CompOp,Sampling_Frequency,Time_Record,ndp);
            Frequency_Parameters_est(i,:)=[temp1,zeros(1,K-CompOp)];
            Damping_Parameters_est(i,:)=[temp2,zeros(1,K-CompOp)];
            Amplitude_Parameters_est(i,:)=[temp3,zeros(1,K-CompOp)];
            Phase_Parameters_est(i,:)=[temp4,zeros(1,K-CompOp)];
        else
            [Frequency_Parameters_est(i,:),Damping_Parameters_est(i,:),Amplitude_Parameters_est(i,:),Phase_Parameters_est(i,:)]=Vangjush_HTLSU(Signal_Filt(i-1,:),CompOp,Sampling_Frequency,Time_Record,ndp);
        end
    else
        [Frequency_Parameters_est(i,:),Damping_Parameters_est(i,:),Amplitude_Parameters_est(i,:),Phase_Parameters_est(i,:)]=Vangjush_HTLSU(Signal_Filt(i-1,:),K,Sampling_Frequency,Time_Record,ndp);
    end
    Reconstructed_Signal(i,:)=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters_est(i,:),Damping_Parameters_est(i,:),Amplitude_Parameters_est(i,:),Phase_Parameters_est(i,:));
    Reconstructed_Signal_Spectrum(i,:)=(fftshift(fft(Reconstructed_Signal(i,:))));
end
%%
Vangjush_Parameter_2_Latex_Table(Frequency_Parameters_est,'6')
Vangjush_Parameter_2_Latex_Table(Damping_Parameters_est,'7')
Vangjush_Parameter_2_Latex_Table(Amplitude_Parameters_est,'8')
Vangjush_Parameter_2_Latex_Table(Phase_Parameters_est,'9')
Vangjush_Header_2_Latex_Table1('10')
%%
figure('units','normalized','outerposition',[0 0 1 1]);
plot(PPM_Axis,(real(fftshift(fft(mrs_filt)))),'k','LineWidth',2);
hold on000
plot(PPM_Axis,real(Reconstructed_Signal_Spectrum'),'LineWidth',2);
Vangjush_Costum_Plot()
legend('Original signal','Reconstred','Cadzow','MV','MCC','MCCE')
title('Reconstructed signal','FontSize',20)
[fig]=Vangjush_Save_Images(fig);
%%
% PPM_Axis=flip(flip(PPM_Axis));
PPM_Axis=fliplr(PPM_Axis);
figure('units','normalized','outerposition',[0 0 1 1]);
plot(PPM_Axis,fliplr(real(fftshift(fft(mrs_filt')))),'LineWidth',2);
hold on
plot(PPM_Axis,fliplr(real(fftshift(fft(Signal_Filt')))),'LineWidth',2);
Vangjush_Costum_Plot()
legend('Pure Signal','Cadzow','MV','MCC','MCCE')
title('Filtered signals','FontSize',20)
[fig]=Vangjush_Save_Images(fig);

