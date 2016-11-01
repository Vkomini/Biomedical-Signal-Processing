function [MRS_filter]=Vangjush_Filter_MRS_Signal(MRS_grid_signal,K,Sampling_Frequency,Time_Record,ndp,frequency)
%%
MRS_filter=zeros(size(MRS_grid_signal));
for i=1:min(size(MRS_grid_signal));
    MRS_single_signal=MRS_grid_signal(i,:);
    [Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HSVD(MRS_single_signal,K,Sampling_Frequency,Time_Record,ndp);
    freq_ppm=Frequency_Parameters*10^6/frequency+4.7;
    idxfilt=find(freq_ppm>=4.5);
    k_interest=idxfilt(1)-1;
    mrs_water=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters(k_interest:K),Damping_Parameters(k_interest:K),Amplitude_Parameters(k_interest:K),Phase_Parameters(k_interest:K));
    MRS_filter(i,:)=MRS_single_signal-mrs_water;
end
end