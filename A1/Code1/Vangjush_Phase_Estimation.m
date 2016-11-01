function [Phase_Parameter]=Vangjush_Phase_Estimation(Component_Number,Imaginary_Part,Real_Part,Z_Component)
%%
Phase_Parameter=zeros(1,Component_Number);                      % Initialization of the data vector
for i=1:Component_Number,
  if Z_Component(i)==0,
    if Imaginary_Part(i)>=0,
      Phase_Parameter(i)=90;
    else
      Phase_Parameter(i)=270;
    end
  else
    Phase_Parameter(i)=atand(Imaginary_Part(i)/Real_Part(i));
  end
end

end