function [MDL]=Vangjush_MDL(MRS_single_signal,ndp,k)
%%
[Hanke_Matrix,~]=Vangjush_Hankel_Matrix(MRS_single_signal,ndp);
[~,L]=size(Hanke_Matrix);
N=length(MRS_single_signal);
[~,S,~]=svd(Hanke_Matrix);
SinguarlValues=S(find(S));
UpPart=N*sum(log10(SinguarlValues(k+1:L)));
LowerPart=((L-k)*N)*(sum(log10(SinguarlValues(k+1:L)))-log10(L-k));
MDL=LowerPart-UpPart+1/2*k*(2*L-k);
end