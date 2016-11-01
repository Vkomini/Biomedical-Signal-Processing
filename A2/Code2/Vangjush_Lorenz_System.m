function [Data_Out]=Vangjush_Lorenz_System(Data,sigma,r,b)

for i=1:max(size(Data))
   Data_Out(i,1)=-sigma*Data(i,1)+sigma* Data(i,1);
   Data_Out(i,2)=-Data(i,3)*Data(i,1)+r* Data(i,1)-Data(i,2);
   Data_Out(i,3)=Data(i,2)*Data(i,1)-b* Data(i,3);
end

end