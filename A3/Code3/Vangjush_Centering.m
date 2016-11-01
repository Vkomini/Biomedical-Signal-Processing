function [Signal_Centered]=Vangjush_Centering(Signal)
%%
Signal_Centered=zeros(size(Signal));
for i=1:size(Signal_Centered,1)
    Mean(i)=mean(Signal(i,:));
    for j=1:max(size(Signal))
        Signal_Centered(i,j)=Signal(i,j)-Mean(i);
    end
end
%%
end