function [Mixing_Matrix,Signal]=Vangjush_Fast_ICA_Final(Signal)
%%
[Signal_Centered]=Vangjush_Centering(Signal);
[Signal_Whited]=Vangjush_Whitening(Signal_Centered);
[Mixing_Matrix]=Vangjush_Fast_ICA(Signal_Whited);
Signal=Mixing_Matrix'*Signal_Whited;
end