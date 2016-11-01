function [Kurt]=Vangjush_Gaussianity(EEG)
%%
[dim1,~]=size(EEG);
for i=1:dim1
    Kurt(i)=kurtosis(EEG(i,:));
end
end