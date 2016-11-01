function [Hankel_Matrix]=Vangjush_Walk_Edit_Antidiagonal(Hankel_Matrix,Column_Index,Row_Index,Value)
%%
[~,Column_Nr]=size(Hankel_Matrix);
Control=Row_Index+Column_Index-1;
if Control>Column_Nr
    Boundary=Column_Nr-Column_Index;
else
    Boundary=Row_Index-1;
end
for i=0:Boundary
    Hankel_Matrix(Row_Index-i,Column_Index+i)=Value;
end
end

