function [SDR,SIR,SAR]=Vangjush_BSS_Final(True_Source,Spatial_Distortion,Interference_Component,Artifact_Component)
%%
Filtered_Signal=True_Source+Spatial_Distortion;
SDR=10*log10(sum(sum(Filtered_Signal.^2))/sum(sum((Interference_Component+Artifact_Component).^2)));
SIR=10*log10(sum(sum(Filtered_Signal.^2))/sum(sum(Interference_Component.^2)));
SAR=10*log10(sum(sum((Filtered_Signal+Interference_Component).^2))/sum(sum(Artifact_Component.^2)));
end