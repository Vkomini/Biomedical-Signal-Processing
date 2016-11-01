function [ChannelSignal,Wx,r]=Vangjush_CCA(Signal)
%%
A=Signal(:,2:end);
B = Signal(:,1:end-1);
[Wx,~,r]=Vangjushu_Canonical_Coefficients(A,B);
ChannelSignal = Wx'*Signal;
Wx=pinv(Wx);
end