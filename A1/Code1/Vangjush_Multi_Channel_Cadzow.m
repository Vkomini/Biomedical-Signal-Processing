function [Signal_Filt]=Vangjush_Multi_Channel_Cadzow(MRS_single_signal, Component_Number, Nr_Data_Point,pos) 
%%
% Temp=MRS_single_signal(pos,:);
% MRS_single_signal(pos,:)=MRS_single_signal(1,:);
% MRS_single_signal(1,:)=Temp;

Hanke_Matrix_C=[];
for i=1:size(MRS_single_signal,1)    
    [Hanke_Matrix,~]=Vangjush_Hankel_Matrix(MRS_single_signal(i,:),Nr_Data_Point);
    Hanke_Matrix_C = horzcat(Hanke_Matrix_C,Hanke_Matrix);
end
[Dimen1,Dimen2]=size(Hanke_Matrix);
%%
[U_trancated,S_trancated,V_trancated]=Vangjush_Truncate_SVD(Hanke_Matrix_C,Component_Number);

%% 
% Recover the data matrix of rank K (component number)
Mat_SVD_Reconstructed=U_trancated*S_trancated*V_trancated';
% Extracting the first matrix
Mat_SVD_Reconstructed=Mat_SVD_Reconstructed(1:Dimen1,((pos-1)*Dimen2+1):((pos-1)*Dimen2+Dimen2));
% Averging through antidiagonal yields the Hankel matrix back
Hanke_Matrix_T=Vangjush_Avg_Hankel_Matrix(Mat_SVD_Reconstructed);
% Extract the signal from Hangle Matrix
Signal_Filt=Vangjush_Extract_Signal(Hanke_Matrix_T);
end

%%
