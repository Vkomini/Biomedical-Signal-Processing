function [D_Estimated]=Vangjush_Inner_Product_Second(Source_Numbers,length_time_invariant_filters,Channel_Nr,Signal_Spectrum,Estimated_Signal_Spectrum,FFT_Length)
%%
D_Estimated=zeros(Channel_Nr*Source_Numbers*length_time_invariant_filters,Channel_Nr);
for k=0:Channel_Nr*Source_Numbers-1,
    for i=1:Channel_Nr,
        SEstimated_Signal_Spectrum=Signal_Spectrum(k+1,:).*conj(Estimated_Signal_Spectrum(i,:));
        SEstimated_Signal_Spectrum=real(ifft(SEstimated_Signal_Spectrum,[],2));
        D_Estimated(k*length_time_invariant_filters+1:k*length_time_invariant_filters+length_time_invariant_filters,i)=SEstimated_Signal_Spectrum(:,[1 FFT_Length:-1:FFT_Length-length_time_invariant_filters+2]).';
    end
end
end