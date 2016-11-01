function [SDR,SIR,SAR]=Vangjush_BSS_Evaluate(Sources_estimated,Sources)
%%
[Source_Numbers,~]=size(Sources_estimated);
%%
SDR=zeros(Source_Numbers,Source_Numbers);
SIR=zeros(Source_Numbers,Source_Numbers);
SAR=zeros(Source_Numbers,Source_Numbers);
%%
for jest=1:Source_Numbers,
    for jtrue=1:Source_Numbers,
        [True_Source,Spatial_Distortion,Interference_Component,Artifact_Component]=Vangjush_Decompose_BSS(Sources_estimated(jest,:),Sources,jtrue,512);
        [SDR(jest,jtrue),SIR(jest,jtrue),SAR(jest,jtrue)]=Vangjush_BSS_Final(True_Source,Spatial_Distortion,Interference_Component,Artifact_Component);
    end
end
%%
 [SDR,SIR,SAR]=Vangjush_Best_Ordering(Source_Numbers,SDR,SIR,SAR); 
return
