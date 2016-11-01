function [G]=Vangjush_Inner_Product(Channel_Nr,Source_Numbers,length_time_invariant_filters,Signal_Spectrum,FFT_Length)
% Inner products between delayed versions of s
G=zeros(Channel_Nr*Source_Numbers*length_time_invariant_filters);
for k1=0:Channel_Nr*Source_Numbers-1,
    for k2=0:k1,
        SSignal_Spectrum=Signal_Spectrum(k1+1,:).*conj(Signal_Spectrum(k2+1,:));
        SSignal_Spectrum=real(ifft(SSignal_Spectrum));
        SSS=toeplitz(SSignal_Spectrum([1 FFT_Length:-1:FFT_Length-length_time_invariant_filters+2]),SSignal_Spectrum(1:length_time_invariant_filters));
        G(k1*length_time_invariant_filters+1:k1*length_time_invariant_filters+length_time_invariant_filters,k2*length_time_invariant_filters+1:k2*length_time_invariant_filters+length_time_invariant_filters)=SSS;
        G(k2*length_time_invariant_filters+1:k2*length_time_invariant_filters+length_time_invariant_filters,k1*length_time_invariant_filters+1:k1*length_time_invariant_filters+length_time_invariant_filters)=SSS.';
    end
end

end