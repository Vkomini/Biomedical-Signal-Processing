function MM =Vangjush_K_R(M1,M2)
%%
[dim1,dim2]=size(M1);
dim3=size(M2,1);
MM=zeros(dim1*dim3,dim2);
for i=1:dim2
   mm=M2(:,i)*M1(:,i).';
   MM(:,i)=mm(:);
end
end