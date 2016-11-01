function [DOE,DLE]=Estimation_Error(Result,sourceEEG1)
%%
for i=1:min(size(Result))
    DOE(i)=Dipole_Orientation_Error(Result(i,4:6),sourceEEG1.ori);
    DLE(i)=Dipole_Location_Error(Result(i,1:3),sourceEEG1.loc);
end
end