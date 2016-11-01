function [DOE]=Dipole_Orientation_Error(Loc1,Loc2)
%%
d1=sqrt(sum(Loc1.^2));
d2=sqrt(sum(Loc2.^2));
DOE=acosd(sum(Loc1.*Loc2)/d1/d2);
end