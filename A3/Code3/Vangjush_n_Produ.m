function S = Vangjush_n_Produ(Tensor_Z,Matrix,n)
%%
Ash = shiftdim(Tensor_Z,n-1);
dimTensor = size(Ash);
dimTensor(1) = size(Matrix,1);
S = Matrix*Ash(:,:);
S = reshape(S,dimTensor);
S = shiftdim(S,length(dimTensor)-n+1);
end