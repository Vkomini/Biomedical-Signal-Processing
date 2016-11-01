function [Distance]=Vangjush_Matrix_Adjective(Signal)
%%
Dimension=max(size(Signal));
[dim1,dim2]=size(Signal);
if dim1<dim2
    Signal=Signal';
end
Diagonal=Inf*ones(1,Dimension);
Distance=diag(Diagonal);
Distance=zeros(Dimension);
for i=1:Dimension
    for j=i+1:Dimension
        Distance(i,j)= sqrt(sum((Signal(i,:)-Signal(j,:)).^2));
    end
end
Distance=Distance+Distance';
end