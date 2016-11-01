function  [Frequency_Parameters,Damping_Parameters,Amplitude_Parameters,Phase_Parameters]=Vangjush_HTLSU_PK_FD(MRS_single_signal,Component_Number,Sampling_Frequency,Time_Vector,Nr_Column,Nr_Data_Point,Frequency_known,Damping_known)

%%
% Vandermond matrix
[T_q]=Vangjush_Vandermond_Tq_Matrix(Damping_known,Frequency_known,Sampling_Frequency,Nr_Column);
%%
% QR decomposition
[Q,~]=qr(T_q);
Q2=Q(:,length(Damping_known)+1:Nr_Column);
%%
% Construction of the Hankel matrix 
[Hanke_Matrix,Row_Length]=Vangjush_Hankel_Matrix(MRS_single_signal,Nr_Data_Point);
%%
% Project of data
Hanke_Matrix=Hanke_Matrix*conj(Q2);  
%%
% Singular Value Decomposition of the Hankel Matrix
[U,~,~]=svd(Hanke_Matrix,0);                                      % SVD computation of the Hankel matrix in an economical size manner
%%
% Truncation of the SVD entities in order to process only the required number of component K
U_trancated=U(:,1:Component_Number);                              % Truncation of the mixing matrix
% Total Least Square solution 
[E]=Vangjush_TLS(U_trancated,Row_Length,Component_Number);
%%
% Harmonic retrieval from the eigenvalues of the matrix E 
[Damping_Parameters,Frequency_Parameters]=Vangjush_Freq_Damping_Esti(E,Sampling_Frequency);
%%
% Phase and Amplitude parameter estimation 
[Amplitude_Parameters,Phase_Parameters]=Vangjush_Linear_Parameter_Estination(MRS_single_signal,Component_Number,Frequency_Parameters,Damping_Parameters,Time_Vector);
end
