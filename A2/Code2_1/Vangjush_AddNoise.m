function [Signal_Noisy,Noise] = Vangjush_AddNoise(Signal,SNR)
%%
Dimension= size(Signal); 
real = isreal(Signal);% Get the real part of the signal 
tmp = randn(Dimension)+(~real*randn(Dimension)*1i); % Unit scale of the noise
scale = frob(Signal)*10^(-SNR/20)/frob(tmp);  % dB Scale added to the noise
Noise = tmp*scale; % Final Noise Level
Signal_Noisy = Signal+Noise;        % Noise added to the signal

end
