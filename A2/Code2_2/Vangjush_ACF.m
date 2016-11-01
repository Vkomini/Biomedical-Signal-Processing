function ACF = Vangjush_ACF(Signal,Lag)
%%
ACF = zeros(Lag,1) ;
N = max(size(Signal)) ;
Mean_Value = mean(Signal); 
Var_Value = var(Signal); 
parfor i = 1:Lag
   ACF(i) = Vangjush_ACF_K(Signal,i,Mean_Value,N);
end
end

