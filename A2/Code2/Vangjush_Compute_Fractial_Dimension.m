function [FractialDimension]=Vangjush_Compute_Fractial_Dimension(Box_Counter,Box_Size,Number_Generations)
%%
Box_Counter_log=log(Box_Counter);
Box_Size_log=log(Box_Size);
Temp_Matrix=zeros(Number_Generations+1,2);
Temp_Matrix(:,1)=Box_Size_log;
Temp_Matrix(:,2)=ones(Number_Generations+1,1);
[Q,R] = qr(Temp_Matrix);
Temp1=Q'*Box_Counter_log';
Temp=R'/Temp1';
FractialDimension=Temp(1);
end