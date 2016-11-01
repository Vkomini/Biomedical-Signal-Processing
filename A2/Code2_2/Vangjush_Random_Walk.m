function [y]=Vangjush_Random_Walk(x)
%%
y=zeros(1,length(x));
for i=1:length(x)
    y(i)=sum(x(1:i)-mean(x));
end
end