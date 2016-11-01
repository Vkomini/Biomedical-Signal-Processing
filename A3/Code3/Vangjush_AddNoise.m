function [Signal_Noisy,Noise] = Vangjush_AddNoise(Signal,SNR)
%%
Dimension= size(Signal); 
real = isreal(Signal);
tmp = randn(Dimension)+(~real*randn(Dimension)*1i); 
scale = frob(Signal)*10^(-SNR/20)/frob(tmp); 
Noise = tmp*scale; 
Signal_Noisy = Signal+Noise; 
end
