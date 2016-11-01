function [Hanke_Matrix,Row_Length]=Vangjush_Hankel_Matrix(MRS_single_signal,Nr_Data_Point)
%%
Column_Length=Nr_Data_Point/2;                                  % Columns size of the Hankel matrix as half the size of the data points
Length_Data=length(MRS_single_signal);                          % Length of the data points
Row_Length=Length_Data-Column_Length+1;                         % Raw size of the hankel matrix
Column_Hanke_Matrix=MRS_single_signal(1:Row_Length);            % First Column of the Hankel matrix as first part of the MRS signal 
Row_Hanke_Matrix=MRS_single_signal(Row_Length:Length_Data);     % First Row of the Hankel matrix as last part of the MRS signal 
Hanke_Matrix=hankel(Column_Hanke_Matrix(:),Row_Hanke_Matrix(:));% Construction of the Hankel matrix using the matlab function
%%
end