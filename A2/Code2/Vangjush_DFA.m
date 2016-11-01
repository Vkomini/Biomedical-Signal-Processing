function [F,Yn,x,DFA_STEP]=Vangjush_DFA(X,threshold1,threshold2)
%%
x=Vangjush_Random_Walk(X);                               % Step1 Random walk accross the data
x=x';
index=1;
for n=threshold1:threshold2
    [X,XR]=Vangjush_Windowing_Function(x,n);              % Step2 Boxing the data consistently to the defined width
    [Yn]=Vangjush_LSE_Of_Window(X,XR,n);     % Step2 Fitting a linear regression line inside the data
    if n==16
        DFA_STEP=Yn;
    end
    F(index)=sqrt(1/length(x))*sum((x'-Yn).^2); % Step3 Detrend the integrated time series in each window
    index=index+1;
end
end