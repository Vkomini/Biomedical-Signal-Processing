function [Value1,Value]=Vangjush_Correlation_Integral(Vectors,r)
%%
[dim1,dim2]=size(Vectors);
if dim1<dim2
    Vectors=Vectors';
    [dim1,dim2]=size(Vectors);
end
Value1=0;
Value=0;
disp('Correlation integral computation started..')
% h = waitbar(0,'Please wait...');
for i=1:20:dim1-1
    for j=i+5:dim1
       % Grassberger Procaccia 
       Epsilon=sqrt(sum((Vectors(i,:)-Vectors(j,:)).^2));
       if r-Epsilon>0
           Value=Value+1;
       end
       % Gaussian Kernel
       Power=(Epsilon.^2)./(4*r^2);
       Value1=Value1+exp(-Power);
    end 
%     waitbar(i/(dim1-1),h)
end
disp('Correlation integral computation finished!')
% close (h)
Value=Value/(dim1*(dim1-1));
end