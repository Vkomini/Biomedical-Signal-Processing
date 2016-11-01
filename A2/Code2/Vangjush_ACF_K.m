function ACF = Vangjush_ACF_K(Signal,k,Mean_Value,N)
%%
cross_sum = zeros(N-k,1) ;
for i = (k+1):N
    cross_sum(i) = (Signal(i)-Mean_Value)*(Signal(i-k)-Mean_Value) ;
end
yvar = (Signal-Mean_Value)'*(Signal-Mean_Value) ;

ACF = sum(cross_sum) / yvar ;
end