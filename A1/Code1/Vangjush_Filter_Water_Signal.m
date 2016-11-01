function [SpectrumOfWatterSignal,SpectrumOfWatterFilterSignal,mrs_filt,mrs_water,SNR,ModelOrder]=Vangjush_Filter_Water_Signal(MRS_single_signal,k,t,frequency,freqT,dampT,amplT,phasT,PPM_Axis)
%%
index=1;

for i=1:k
    freq=freqT(1:i);                                                                                    % Subset of frequency
    damp=dampT(1:i);                                                                                    % Subset of damping
    ampl=amplT(1:i);                                                                                    % Subset of amplitude
    phas=phasT(1:i);                                                                                    % Subset of phase
    
    freq_ppm=freq*10^6/frequency+4.7;                                                                   % Going from Hz to ppm
    idxfilt=find(freq_ppm>2);                                                                           % Select frequencies lower than 4.6ppm since higher thatn 4.7 are water signals and we can have a margin of 0.1 ppm away
    
    
    if idxfilt>0
        freqfilt=freq(idxfilt);                                                                             % Select out the frequencies which are higher than 4.6 ppm
        dampfilt=damp(idxfilt);                                                                             % Select out the dampling factors which are higher than 4.6 ppm
        amplfilt=ampl(idxfilt);                                                                             % Select out the amplitudes which are higher than 4.6 ppm
        phasfilt=phas(idxfilt);                                                                             % Select out the phases which are higher than 4.6 ppm
        
        mrs_water(index,:)=Vangjush_Reconstruct_Components(t,freqfilt,dampfilt,amplfilt,phasfilt);      % Reconstruct the signal in time domain
        mrs_filt(index,:)=MRS_single_signal- mrs_water(index,:);                                        % Compute the water signals as the residue from the orginal signal after removing the filtered water
        SpectrumOfWatterFilterSignal(index,:)=fftshift(fft(mrs_filt(index,:)));                         % Compute the spectrum of the filtered signal
        SpectrumOfWatterSignal(index,:)=fftshift(fft(mrs_water(index,:)));                              % Compute the spectrum of the water signal
        SNR(index)=snr(mrs_filt(index,:),mrs_water(index,:));
        ModelOrder(index)=i;

        index=index+1;
        
    end
end
end