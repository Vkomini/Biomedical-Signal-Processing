function [U,S,V]=Vangjush_Truncate_SVD(Hanke_Matrix,Component_Number)
%%
[u,s,v]=svd(Hanke_Matrix,'econ');
U=u(:,1:Component_Number);
S=s(1:Component_Number,1:Component_Number);
V=v(:,1:Component_Number);
end

