function Scale = Vangjush_Scale(First_Freq,Ending_Freq,FreqSampling)
%%
waveletName = 'bior1.3';
Central_Freq = centfrq(waveletName);
index=1;
for i=First_Freq:Ending_Freq
    Scale(index) = (Central_Freq*FreqSampling)/(i);
    index=index+1;
end
end