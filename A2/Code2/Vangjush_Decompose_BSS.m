function [True_Source,Spatial_Distortion,Interference_Component,Artifact_Component]=Vangjush_Decompose_BSS(Sources_estimated,Sources,j,length_time_invariant_filters)
%%
[~,Sample_Nr,Channel_Nr]=size(Sources);
True_Source=[reshape(Sources(j,:,:),Sample_Nr,Channel_Nr).',zeros(Channel_Nr,length_time_invariant_filters-1)];
Spatial_Distortion=Vangjush_SignalProjection(Sources_estimated,Sources(j,:,:),length_time_invariant_filters)-True_Source;
Interference_Component=Vangjush_SignalProjection(Sources_estimated,Sources,length_time_invariant_filters)-True_Source-Spatial_Distortion;
Artifact_Component=[Sources_estimated,zeros(Channel_Nr,length_time_invariant_filters-1)]-True_Source-Spatial_Distortion-Interference_Component;
return;
