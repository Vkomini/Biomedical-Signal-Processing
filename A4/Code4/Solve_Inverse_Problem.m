function [Result]=Solve_Inverse_Problem(V,Head_Model)
%%
% Generate 5 random dipoles
n=5;
[Random_Dipole]=Generate_Random_Dipoles(Head_Model,n);
for i=1:n
    [Result(i,1:3),RRE]=fminsearch('Dipole_Position_Inverse',Random_Dipole(i,1:3),optimset('TolX',1.e-4,'TolFun',1.e-5,'Display','off','MaxFunEvals',100000,'MaxIter',10000),Head_Model,V);
    source.loc=Result(i,1:3);
%     source.ori=Result(i,4:3);
    [~,L]=Spherical_Head_Model(Head_Model,source);
    Orientation=pinv(L)*V;
    Orientation=Orientation./norm(Orientation);
    Result(i,4:6)=Orientation;
    Result(i,7)=RRE;
end
end