function Signal_Projected=Vangjush_SignalProjection(Sources_estimated,Sources,length_time_invariant_filters)
%%
[Source_Numbers,Sample_Nr,Channel_Nr]=size(Sources);
Sources=reshape(permute(Sources,[3 1 2]),Channel_Nr*Source_Numbers,Sample_Nr);
Sources=[Sources,zeros(Channel_Nr*Source_Numbers,length_time_invariant_filters-1)];
Sources_estimated=[Sources_estimated,zeros(Channel_Nr,length_time_invariant_filters-1)];
FFT_Length=2^nextpow2(Sample_Nr+length_time_invariant_filters-1);
Signal_Spectrum=fft(Sources,FFT_Length,2);
Estimated_Signal_Spectrum=fft(Sources_estimated,FFT_Length,2);
AAAAA=Vangjush_Inner_Product(Channel_Nr,Source_Numbers,length_time_invariant_filters,Signal_Spectrum,FFT_Length);
BBBBB=Vangjush_Inner_Product_Second(Source_Numbers,length_time_invariant_filters,Channel_Nr,Signal_Spectrum,Estimated_Signal_Spectrum,FFT_Length);
CCCC=AAAAA\BBBBB;
CCCC=reshape(CCCC,length_time_invariant_filters,Channel_Nr*Source_Numbers,Channel_Nr);
%%
Signal_Projected=zeros(Channel_Nr,Sample_Nr+length_time_invariant_filters-1);
for k=1:Channel_Nr*Source_Numbers,
    for i=1:Channel_Nr,
        Signal_Projected(i,:)=Signal_Projected(i,:)+fftfilt(CCCC(:,k,i).',Sources(k,:));
    end
end
return
