function [Wx,Wy,r]=Vangjushu_Canonical_Coefficients(SingX,SingY)
%%
% Calculated the Covariance matrix
Cxx=cov(SingX');
Cyy=cov(SingY');
C=cov([SingX;SingY].');
dim1=size(SingX,1);
dim2=size(SingY,1);
Cxy=C(1:dim1,dim1+1:dim1+dim2);
Cyx=Cxy';
CxxInv=inv(Cxx);
CyyInv=inv(Cyy);
% Calculate the eignvalues and eigen vectors
RhoX=CxxInv*Cxy*CyyInv*Cyx;
RhoY=CyyInv*Cyx*CxxInv*Cxy;
% Compute the eigenvalues and the eigen vector for each base
[Wx,S]=eig(RhoX);
[Wy,S1]=eig(RhoY);
% Sort the correlation values
S=sqrt(real(S));
S=diag(S);
[r,index]=sort(S,'descend');
Wx=Wx(:,index);
Wy=Wy(:,index);
end