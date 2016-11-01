function [Signal_Filt]=Vangjush_Multi_Channel_Enhanced(MRS_grid_signal,Component_Number, Nr_Data_Point,PositionOfMainVoxel,DimensionConsideration,maner,Strct)
%%
[Neigbours,pos]=Vangjush_ExtractionNeigbours(PositionOfMainVoxel,DimensionConsideration,MRS_grid_signal,maner);
%%
[MRS_filter]=Vangjush_Filter_MRS_Signal(Neigbours,Component_Number,Strct.Sampling_Frequency,Strct.Time_Record,Nr_Data_Point,Strct.frequency);
%%
[Signal_Filt]=Vangjush_Multi_Channel_Cadzow(MRS_filter, Component_Number, Nr_Data_Point,pos);
% [Signal_Filt]=Multi_Channel_Cadzow(MRS_filter, Component_Number, Nr_Data_Point,pos);
end