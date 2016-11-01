function Vangjush_Plot_Individual_Component(Frequency_Parameters1,Damping_Parameters1,Amplitude_Parameters1,Phase_Parameters1,Time_Record,PPM_Axis,K)
%%
figure('units','normalized','outerposition',[0 0 1 1])
for i=1:K
    MRS_Individual_Component_Reconstructed=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameters1(i),Damping_Parameters1(i),Amplitude_Parameters1(i),Phase_Parameters1(i));
    MRS_Individual_Component_Spectrum=(fftshift(fft(MRS_Individual_Component_Reconstructed)));
    component=sprintf('K=%d',i);
    subplot1 = subplot(floor(sqrt(K)),ceil(K/sqrt(K)),i);
    plot(PPM_Axis,real(MRS_Individual_Component_Spectrum),'b');
    t=title(component);
    set(t,  'FontSize',18);
    Vangjush_Costum_Plot1()    
end
end