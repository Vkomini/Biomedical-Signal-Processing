function [Control]=Vangjush_Nonlinear_Signal_Processing(Signal,dim,i,threshold1,threshold2,T,Fre_Thre1,Fre_Thre2,scale)

Control.ACF{i} = Vangjush_ACF(Signal,length(Signal)-1);
[pos]=Vangjush_First_Zero(Control.ACF{i});
%%
Control.Vectors{i}=Vangjush_Phase_Space_Reconstrucion(Signal,dim,pos);
%%
Vectors=Control.Vectors{i};
%% Complexity and chaos of the system
[Control.Lyapunov_Exponent{i}] = Vangjush_Lyapunov_Wolf(Vectors,0.1);
[Control.Value{i},Control.Value1{i},Control.r{i}]=Vangjush_Grassberger_Procaccia_Gaussian_Kernel(Vectors);
[Control.Sample_Entropy{i}]= Vangjush_Sample_Entropy( Signal ,dim, scale);

%% Scaling behavior of the nonlinear systems
[Control.Box_Counter{i},Control.Box_Size{i},Control.FractialDimension{i}] = Vangjush_Box_Counting(Signal);
[Control.Rescaled_Range_Series{i}]=Vangjush_Hurst_Exponential(Signal);
[Control.Fitt{i},Control.Alpha{i},Control.Beta{i},Control.Pxx{i},Control.FrequencySpectrum{i},Control.LogFreq{i},Control.LogSpectrum{i}]=Vangjush_F_slope(Signal,T,Fre_Thre1,Fre_Thre2);
for j=1:2
    [Control.F1{i+j-1},Control.Yn1{i+j-1},Control.x1{i+j-1}]=Vangjush_DFA(Signal,threshold1(j),threshold2(j));
end
[Control.X{i},Control.Y{i}]=Vangjush_Poincare(Signal);
end