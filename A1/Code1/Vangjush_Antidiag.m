function AntiDiagonal = Vangjush_Antidiag(Matrix,Row_Index, Column_Index)
%%
[~,Column_Nr]=size(Matrix);
Control=Row_Index+Column_Index-1;
if Control>Column_Nr
    Boundary=Column_Nr-Column_Index;
else
    Boundary=Row_Index-1;
end
AntiDiagonal=zeros(1,Boundary+1);
index=1;
for i=0:Boundary
    AntiDiagonal(index)=Matrix(Row_Index-i,Column_Index+i);
    index=index+1;
end
end