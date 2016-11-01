function [Control]=Localization_Error(Dipole,HeadModel,Voltage)
%%
Number_Dipoles=size(Dipole,1);
% Lead_Field_Matrix=zeros(size(V,1),3*Number_Dipoles);
%%
for i=1:Number_Dipoles
    source.loc=Dipole(i,:)';
    [~,Lead_Field_Matrix]=solve_forward(HeadModel,source);
    Control(i)=norm((eye(size(Voltage,1))-Lead_Field_Matrix*pinv(Lead_Field_Matrix))*Voltage,'fro')/norm(Voltage,'fro');
end
Control=sum(Control(i));
end

