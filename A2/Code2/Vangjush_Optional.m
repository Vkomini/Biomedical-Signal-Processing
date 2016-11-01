clear all
close all
clc

%%
load ECGdata
myCluster = parcluster('local');
myCluster.NumWorkers = 12;  % 'Modified' property now TRUE7
saveProfile(myCluster);    % 'local' profile now updated

fs = 2;
T=6;                         % Duration in hours of the signal [Hours]
Fre_Thre1=10^(-4);           % First threshold frequency
Fre_Thre2=10^(-2);           % First threshold frequency

Control.threshold1=[4,16];
Control.threshold2=[16,64];

Control.threshold3=16;
Control.threshold4=64;
scale=0.1;
dim=3;
fig=2;
%%

Scale_Selection=[1 9/10];
for index=2:2
    h = waitbar(0,'Reproducability of the methods');
    for itarations=1:40
        for step=1:1
            Control.threshold1=[4,16];
            Control.threshold2=[16,64];
            %%
            if step==1
                str1='Control';
            end
            if step==2
                str1='West';
            end
            for i=1:1
                Signal1=eval([str1 num2str(i)]);
                %          [FD,SampEnResults,LE]=nonlin_measures(Signal);
                Signal=Signal1(1:Scale_Selection(index)*end);
                Control.ACF{i} = Vangjush_ACF(Signal,length(Signal)-1);
                [pos]=Vangjush_First_Zero(Control.ACF{i});
                %%
                Control.Vectors{i}=Vangjush_Phase_Space_Reconstrucion(Signal,dim,pos);
                %%
                Vectors=Control.Vectors{i};
                %% Complexity and chaos of the system
                [Control.Lyapunov_Exponent{i}] = Vangjush_Lyapunov_Wolf(Vectors,0.1);
                [Control.Value{i},Control.Value1{i},Control.r{i}]=Vangjush_Grassberger_Procaccia_Gaussian_Kernel(Vectors);
                [Control.Sample_Entropy{i}]= Vangjush_Sample_Entropy_1( Signal ,dim, scale);
                %% Scaling behavior of the nonlinear systems
                [Control.Box_Counter{i},Control.Box_Size{i},Control.FractialDimension{i}] = Vangjush_Box_Counting(Signal);
                [Control.Rescaled_Range_Series{i}]=Vangjush_Hurst_Exponential(Signal);
                [Control.Fitt{i},Control.Alpha{i},Control.Beta{i},Control.Pxx{i},Control.FrequencySpectrum{i},Control.LogFreq{i},Control.LogSpectrum{i}]=Vangjush_F_slope(Signal,T,Fre_Thre1,Fre_Thre2);
                %%
                for j=1:2
                    [Control.F1{i+(j-1)*4},Control.Yn1{i+(j-1)*4},Control.x1{i+(j-1)*4},Control.DFA_STEP]=Vangjush_DFA(Signal,Control.threshold1(j),Control.threshold2(j));
                end
                %         [Control.X{i},Control.Y{i}]=Vangjush_Poincare(Signal);
            end
            %% Write in the file
        end
        [Parameters(itarations)]=Vangjush_Parameter_2_Matrix(Control);
        waitbar(itarations/40,h);
        clear Signal
    end
    delete(h);
    Vangjush_Optional_Plots(Parameters)
    if index==1
        suptitle('Reproducability')
    else
        suptitle('Reliability')
    end
    File='.jpg';
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\Optional',num2str(fig),File);
    saveas(gcf,Name)
end
pause(15)
system('shutdown -s')
