function [Phase_Parameter]=Vangjush_Phase_Correction(Component_Number,Phase_Parameter,Imaginary_Part,Real_Part)
%%
for i=1:Component_Number,
  if Imaginary_Part(i)<0 && Real_Part(i)>0;
    Phase_Parameter(i)=Phase_Parameter(i)+360;
  end
  if Real_Part(i)<0;                      
    Phase_Parameter(i)=Phase_Parameter(i)+180;
  end
end
end