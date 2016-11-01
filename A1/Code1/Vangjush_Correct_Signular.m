function [S_crr]=Vangjush_Correct_Signular(Hanke_Matrix,S,Component_Number)
%%
[~,S1,~]=svd(Hanke_Matrix,'econ');
[L,M]=size(Hanke_Matrix);
sigmaV=sum(sum(S1(Component_Number+1:M,Component_Number+1:M)));
sigmaV=sigmaV./(L*(M-Component_Number));
I=eye(Component_Number);
S_crr=(S^2-L*sigmaV*I)*pinv(S);
end
