clear all
close all
clc
%% Load and inspect EEG measurements.
fig=300;
iteration=5000;
load demosignal3_963
%% Tensorisation
FreqSampling=250;
Start_point=51;
Ending_Point=53;
Freq_Start=2;
Freq_Ending=25;
T_sampling=1/FreqSampling;
t=0:max(size(demosignal3_963))-1;
t=T_sampling*t;
Vangjush_PlotEEG(demosignal3_963,t)
xlabel('Time in sec'), ylabel('Number of channels');
title('EEG channels');
[fig]=Vangjush_Save_Images(fig);
Scale = Vangjush_Scale(Freq_Start,Freq_Ending,FreqSampling);
[Scaleogram,MeanData,StandartDeviation] =Vangjush_Normalise_3D(demosignal3_963,Start_point,Ending_Point,Scale);
%%
Sizes=size(Scaleogram);
Scaleogram1=reshape(Scaleogram,Sizes(1)*Sizes(2),Sizes(3));
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(Scaleogram1),colorbar
title('Tensorisation of the EEG streched','FontSize',15)
xlabel('Time [Second]','FontSize',15)
ylabel('Channel number and the frequency streching of dimesions','FontSize',15)
[fig]=Vangjush_Save_Images(fig);

%%
% TENSORLAB and EEGLAB has been utilized for this part.
rankC2=2;
% Decompose the tensor in two rank one terms.
U = cpd(Scaleogram,rankC2);
A = U{1}; B = U{2}; C = U{3};

% Look at the error of the fit in function of the number of rank one terms.
% This can be done by manually testing each R or by using rankest(data_3D).

% Topoplots.
result = transform_back(A,StandartDeviation);

% Frequency signatures.
figure('units','normalized','outerposition',[0 0 1 1]);
plot(B);
title('frequency signatures','FontSize',15)
xlabel('component','FontSize',15)
ylabel('frequency','FontSize',15)
[fig]=Vangjush_Save_Images(fig);
% Temporal signatures.
figure('units','normalized','outerposition',[0 0 1 1]);
plot(C);
title('temporal signatures','FontSize',15)
xlabel('component','FontSize',15)
ylabel('frequency','FontSize',15)
[fig]=Vangjush_Save_Images(fig);
%%
close all
MaxRank=11;
index=1;
figure('units','normalized','outerposition',[0 0 1 1])
for R=2:MaxRank;
    U = cpd(Scaleogram,R);
    
    options.Initialization = @cpd_rnd;              % Select pseudorandom initialization.
    options.Algorithm = @cpd_nls;                   % Select NLS as the main algorithm multiple initialization avoid local minima.
    options.AlgorithmOptions.LineSearch = @cpd_nls; % Add exact line search.
    options.AlgorithmOptions.TolFun = 1e-20;        % Set algorithm stop criteria.
    options.AlgorithmOptions.TolX = 1e-20;
    
    
    [Uhat,output] = cpd(Scaleogram,R,options);
    
    semilogy(0:output.Algorithm.iterations,sqrt(2*output.Algorithm.fval),'color',rand(1,3),'LineWidth',4);
    xlabel('iteration','FontSize',15)
    ylabel('frob(cpdres(T,U))','FontSize',15)
    title('Norm estimation over different interation repsectively to different rank trial','FontSize',15)
    hold on
    K=2:R;                                                          % Raw of different order of components
    legendCell=strcat('R=',strtrim(cellstr(num2str(K(:)))));        % Generation fo cells for the legend
    legend(legendCell)
    
    res = cpdres(Scaleogram,Uhat);
    relerr(index) = frob(cpdres(Scaleogram,Uhat))/frob(Scaleogram);
    index=index+1;
end
grid on;
[fig]=Vangjush_Save_Images(fig);



