function [Amplitude_Parameter,Phase_Parameter]=Vangjush_Linear_Parameter_Estination(MRS_single_signal,Component_Number,Frequency_Parameters,Damping_Parameters,Time_Record)
%%
% Reconstruction of the eZ_Componentponential damping part consistently to the number
% of component and frequency and damping values computed
PoComponent_Normer_Value=Time_Record'*(-Damping_Parameters+1i*2*pi.*Frequency_Parameters);
Z_Component=exp(PoComponent_Normer_Value);
%%
% Weight each component throughout the time record 
Component_Norm=[];
for i=1:Component_Number
  Component_Norm=[Component_Norm norm(Z_Component(:,i))];
end
%%
Component_Norm=diag(Component_Norm);                            % Construction diagonal matrix 
%%
if cond(Component_Norm) > 10^14                                 % Checking the invertability of the processed data
  disp('Warning in Vangjush_Linear_Parameter_Estination.m: the cond> 10^14. Close to singular matrix thus inversion quasi inexisting')
end
%%
Component_Norm_Inverse=inv(Component_Norm);                     % Inverse matrix computation for Component Norm
Z_Component=Z_Component*Component_Norm_Inverse;                 % Least Square solution
%%
[U_trancated,S_trancated,V_trancated]=Vangjush_Truncate_SVD(Z_Component,Component_Number);
%%
if cond(S_trancated) > 10^14                                    % Checking the invertability of the of the scaling matrix
  disp('Warning in Vangjush_Linear_Parameter_Estination.m: the cond> 10^14. Close to singular matrix thus inversion quasi inexisting')
end
%%
% C component computation via Lease Square approax utilising pseudoinverse matrix
C_Component=Component_Norm_Inverse*V_trancated*inv(S_trancated)*U_trancated'*MRS_single_signal(:); 
%%
% Amplitude_Parameteriture retrival
Amplitude_Parameter=abs(C_Component).';
%% 
% Exponential part retrival exp(j*Phase_Parametere)=Real_Part+j*Imaginary_Part
Imaginary_Part=imag(C_Component);                               % Imaginary part of the exponential Phase_Parametere
Real_Part=real(C_Component);                                    % Real part of the exponential Phase_Parametere
%%
[Phase_Parameter]=Vangjush_Phase_Estimation(Component_Number,Imaginary_Part,Real_Part,Z_Component);
%%
[Phase_Parameter]=Vangjush_Phase_Correction(Component_Number,Phase_Parameter,Imaginary_Part,Real_Part);
end
