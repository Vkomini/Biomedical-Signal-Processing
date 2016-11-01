function [MRS_Signal_Reconstructed]=Vangjush_Reconstruct_Components(Time_Record,Frequency_Parameter,Damping_Parameter,Amplitude_Parameter,Phase_Parameter)
%%
phase1=Phase_Parameter*pi/180;
phase4=repmat(phase1',1,length(Time_Record));
phase2=2*pi*Frequency_Parameter;
phase3_1=phase2'*Time_Record;
phase3_2=-Damping_Parameter'*Time_Record;
phase5=1i*(phase4+phase3_1)+phase3_2;
phase6=exp(phase5);
phase7=repmat(Amplitude_Parameter',1,length(Time_Record));
phase8=phase7.*phase6;
MRS_Signal_Reconstructed=sum(phase8,1);
end