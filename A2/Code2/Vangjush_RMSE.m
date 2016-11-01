function r=Vangjush_RMSE(Signal,Estim_Val)
%%
I = ~isnan(Signal) & ~isnan(Estim_Val); 
Signal = Signal(I); Estim_Val = Estim_Val(I);
r=sqrt(sum((Signal(:)-Estim_Val(:)).^2)/numel(Signal));
end