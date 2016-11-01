function [PPM_Axis] = Vangjush_PPM_Axis_Find(Steps,Nr_DFT,Freq)
%%
x_lower_bound  = -1000 / (2*Steps) ;
xSteps = 1000 / (Nr_DFT*Steps);
X_upper_bound = 1000 / (2*Steps) ;
X_Points     = x_lower_bound:xSteps:X_upper_bound;
Ref_Freq=0;
PPM_ref_Value=4.7;
Step_Freq = Freq*1000;
PPM_Axis=(X_Points-Ref_Freq)/Step_Freq*10^6+PPM_ref_Value;
PPM_Axis=PPM_Axis(1:Nr_DFT);
end