function c=Dipole_Position_Inverse(dp,hm,V)
%%
ndip=size(dp,1);
L=zeros(size(V,1),3*ndip);
for i=1:ndip
    source.loc=dp(i,:);
    [~,L]=Spherical_Head_Model(hm,source);
end
c=norm((eye(size(V,1))-L*pinv(L))*V,'fro')/norm(V,'fro');
return;


