function [Value,Value1,r]=Vangjush_Grassberger_Procaccia_Gaussian_Kernel(Signal)
%%
r=linspace(1,1e3,10);
parfor i=1:length(r)
    [Value1(i),Value(i)]=Vangjush_Correlation_Integral(Signal,r(i));
end
end