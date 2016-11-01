function [DLE]=Dipole_Location_Error(Loc1,Loc2)
%%
DLE=sqrt(sum((Loc1-Loc2).^2));
end