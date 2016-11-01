function [A,B,C]=Vangjush_CPD_ALS(T,rank,iteration)
%%
Dimensions=size(T);
%%
% initialization
A=rand(Dimensions(1),rank);
B=rand(Dimensions(2),rank);
C=rand(Dimensions(3),rank);
%%
T1=reshape(T,Dimensions(3)*Dimensions(2),Dimensions(1))';
T2=reshape(T,Dimensions(1)*Dimensions(3),Dimensions(2))';
T3=reshape(T,Dimensions(1)*Dimensions(2),Dimensions(3))';
%%
% ALS via Gaus Seilden
h = waitbar(0,'CPD computation...');
for i=1:iteration
    A1=1/2*T1*pinv(Vangjush_K_R(C,B)');
    B1=1/2*T2*pinv(Vangjush_K_R(C,A1)');
    C1=1/2*T3*pinv(Vangjush_K_R(B1,A1)');
    A=A1;
    B=B1;
    C=C1;
    waitbar(i/iteration,h)
end
close(h);
end