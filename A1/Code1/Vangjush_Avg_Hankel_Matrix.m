function [Hankel_Matrix]= Vangjush_Avg_Hankel_Matrix(A)
%%
Hankel_Matrix=A;
[Row_Nr,Column_Nr]=size(Hankel_Matrix);
%%
Column_Index=1;
for Row_Index=1:Row_Nr
    Value=mean(Vangjush_Antidiag(Hankel_Matrix,Row_Index, Column_Index));
    [Hankel_Matrix]=Vangjush_Walk_Edit_Antidiagonal(Hankel_Matrix,Column_Index,Row_Index,Value);
end
%%
Row_Index=Row_Nr;
for Column_Index=1:Column_Nr
    Value=mean(Vangjush_Antidiag(Hankel_Matrix,Row_Index, Column_Index));
    [Hankel_Matrix]=Vangjush_Walk_Edit_Antidiagonal(Hankel_Matrix,Column_Index,Row_Index,Value);
end
end









