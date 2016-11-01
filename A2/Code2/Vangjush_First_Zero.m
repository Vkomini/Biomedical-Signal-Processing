function [pos]=Vangjush_First_Zero(Signal)
%%
for i=1:length(Signal)
   if Signal(i)<0
       pos=i-1;
       break;
   end
end
end