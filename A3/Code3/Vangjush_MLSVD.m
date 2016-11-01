function [U,S]=Vangjush_MLSVD(T)
%%
Dimensions=size(T);
Dim=1:length(Dimensions);
S=T;
for i=1:length(Dimensions)
    Dimensions1=Dimensions;
    Dimensions1(i)=[];
    T1=reshape(T,Dimensions(i),prod(Dimensions1));
    [U{i},~,~]=svd(T1);
    S = Vangjush_n_Produ(S,U{i}',Dim(i));
end
end