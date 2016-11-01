function [Parameters]=Vangjush_Parameter_2_Matrix(Control)
%%
for i=1:1
    Parameters.LLE(i)=Control.Lyapunov_Exponent{i};
end
%%
for i=1:1
    Parameters.ApEn(i)=Control.Sample_Entropy{i};
end
%% 1/f Slope
for i=1:1
    Parameters.Slop(i)=abs(Control.Beta{i});
end
%% Hurst Exponential
for i=1:1
    Temp=20*log10(Control.Rescaled_Range_Series{i}+1);
    a=20*log10(linspace(0,length(Temp),length(Temp))+1);
    CovMatrix=cov(double(Temp),double(a));         % Computation of the coovariance matrix
    Parameters.HE(i)=CovMatrix(2,1)./CovMatrix(2,2);                        % Computation of Beta coefficient for the linear regression SLOPE
end
%% DFA
for i=1:1
    F=Control.F1{i};
    X=(Control.threshold1(1):Control.threshold2(1));
    CovMatrix=cov(double(log(F)),double(log(X)));         % Computation of the coovariance matrix
    Parameters.DFA_FirstPart(i)=CovMatrix(2,1)./CovMatrix(2,2);                        % Computation of Beta coefficient for the linear regression SLOPE
end
%% DFA
for i=1:1
    F=Control.F1{i};
    X=(Control.threshold1(1):Control.threshold2(1));
    CovMatrix=cov(double(log(F)),double(log(X)));         % Computation of the coovariance matrix
    Parameters.DFA_Second_Part(i)=CovMatrix(2,1)./CovMatrix(2,2);                        % Computation of Beta coefficient for the linear regression SLOPE
end
%% Box counting
for i=1:1
    Parameters.Box(i)=Control.FractialDimension{i};
end
%%
%% CD
for i=1:1
    Y2=log10(Control.Value1{i});
    X=log10(Control.r{i});
    Parameters.CD_Grassberger_Procaccia(i)= (Y2(2)-Y2(1))/(X(2)-X(1));
end
%%
%% CD
for i=1:1
    Y1=log10(Control.Value{i});
    X=log10(Control.r{i});
    Parameters.CD_Gaussian_Kernel(i) = (Y1(2)-Y1(1))/(X(2)-X(1));
end
%%
end