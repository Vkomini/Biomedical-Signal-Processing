function Vangjush_Parameter_2_Latex_Table(Control,str1)
%% LLE
name_file=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Files\',str1,'.txt');
fileID = fopen(name_file,'w');
% fprintf(fileID,'$&$');
fprintf(fileID,' $LLE$&$');
for i=1:5
    Temp(i)=Control.Lyapunov_Exponent{i};
    fprintf(fileID,'%6s$&$',Temp(i));
    if i==5
        fprintf(fileID,'%6s$\\\\',mean(Temp));
    end
end
fprintf(fileID,' \n');
%% ApEn
fprintf(fileID,' $ApEn$&$');
for i=1:5
    Temp(i)=Control.Sample_Entropy{i};
    fprintf(fileID,'%6s$&$',Temp(i));
    if i==5
        fprintf(fileID,'%6s$\\\\',mean(Temp));
    end
end
fprintf(fileID,' \n');
%% 1/f Slope
fprintf(fileID,' $F-Slope$&$');
for i=1:5
    Temp(i)=abs(Control.Beta{i});
    fprintf(fileID,'%6s$&$',Temp(i));
    if i==5
        fprintf(fileID,'%6s$\\\\',mean(Temp));
    end
end
fprintf(fileID,' \n');
%% Hurst Exponential
clear Temp
fprintf(fileID,' $HE$&$');
for i=1:5
    Temp=20*log10(Control.Rescaled_Range_Series{i}+1);
    a=20*log10(linspace(0,length(Temp),length(Temp))+1);
    CovMatrix=cov(double(Temp),double(a));         % Computation of the coovariance matrix
    p(i)=CovMatrix(2,1)./CovMatrix(2,2);                        % Computation of Beta coefficient for the linear regression SLOPE
    fprintf(fileID,'%6s$&$',p(i));
    if i==5
       fprintf(fileID,'%6s$\\\\',mean(p));
    end
end
fprintf(fileID,' \n');
%% DFA
clear Temp
fprintf(fileID,' $DFA - first$&$');
for i=1:5
    F=Control.F1{i};
    X=(Control.threshold1(1):Control.threshold2(1));
    CovMatrix=cov(double(log(F)),double(log(X)));         % Computation of the coovariance matrix
    p(i)=CovMatrix(2,1)./CovMatrix(2,2);                        % Computation of Beta coefficient for the linear regression SLOPE
    fprintf(fileID,'%6s$&$',p(i));
    if i==5
      fprintf(fileID,'%6s$\\\\',mean(p));
    end
end
fprintf(fileID,' \n');
%% DFA
clear Temp
fprintf(fileID,' $DFA - second$&$');
for i=1:5
    F=Control.F1{i};
    X=(Control.threshold1(1):Control.threshold2(1));
    CovMatrix=cov(double(log(F)),double(log(X)));         % Computation of the coovariance matrix
    p(i)=CovMatrix(2,1)./CovMatrix(2,2);                        % Computation of Beta coefficient for the linear regression SLOPE
    fprintf(fileID,'%6s$&$',p(i));
    if i==5
       fprintf(fileID,'%6s$\\\\',mean(p));
    end
end
fprintf(fileID,' \n');
%% Box counting
clear Temp
fprintf(fileID,' $BC$&$');
for i=1:5
    Temp(i)=Control.FractialDimension{i};
    fprintf(fileID,'%6s$&$',Temp(i));
    if i==5
        fprintf(fileID,'%6s$\\\\',mean(Temp));
    end
end
fprintf(fileID,' \n');
%%
%% CD
clear Temp
fprintf(fileID,' $CD GP$&$');
for i=1:5
    Y2=log10(Control.Value1{i});
    X=log10(Control.r{i});
    Temp(i) = (Y2(2)-Y2(1))/(X(2)-X(1));
    fprintf(fileID,'%6s$&$',Temp(i));
    if i==5
        fprintf(fileID,'%6s$\\\\',mean(Temp));
    end
end
fprintf(fileID,' \n');
%%
%% CD
clear Temp
fprintf(fileID,' $CD GK$&$');
for i=1:5
    Y1=log10(Control.Value{i});
    X=log10(Control.r{i});
    Temp(i) = (Y1(2)-Y1(1))/(X(2)-X(1));
    fprintf(fileID,'%6s$&$',Temp(i));
    if i==5
        fprintf(fileID,'%6s$\\\\',mean(Temp));
    end
end
fprintf(fileID,' \n');
fclose(fileID);
%%
end