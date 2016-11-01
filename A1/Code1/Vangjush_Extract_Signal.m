function [Signal_Filt]=Vangjush_Extract_Signal(Hankel_M)
%%
First_Column=Hankel_M(:,1);
Last_Row=Hankel_M(size(Hankel_M,1),2:size(Hankel_M,2)).';
Signal= conj([First_Column;Last_Row]);
Signal_Filt=real(Signal)-1i*imag(Signal);
end