function [Signal_Filt]=Vangush_Minimum_Variance(MRS_single_signal, Component_Number, Nr_Data_Point) 
%%
% Construct Hangel matrix
[Hanke_Matrix,~]=Vangjush_Hankel_Matrix(MRS_single_signal,Nr_Data_Point);
% Truncated SVD computation
[U,S,V]=Vangjush_Truncate_SVD(Hanke_Matrix,Component_Number);
% Correct the Signular Values
[S_crr]=Vangjush_Correct_Signular(Hanke_Matrix,S,Component_Number);
% Reconsution of the data with the principal components
Mat_SVD_Reconstructed=U*S_crr*V';
%Back To Hankel matrix
Hankel_M=Vangjush_Avg_Hankel_Matrix(Mat_SVD_Reconstructed);
% Extract the signal from Hangle Matrix
Signal_Filt=Vangjush_Extract_Signal(Hankel_M);
end