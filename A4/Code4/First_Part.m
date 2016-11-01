
clear all
close all
clc
%%
% 1
load headmodel19                % Load the head model
%%
index=1;
% 2 Show electrode position
Electrode_Position_V(hm,3)% Plot the location of the electrodes
[index]=Save_Image(index);
% index=2;

%%
% 3
Show_Dipole_Placement([0 0 0 0 0 1],hm,4)    % Show the dipole at the center orientation towards z
[index]=Save_Image(index);
Show_Dipole_Placement([.05 0 0 0 0 1],hm,5)  % Show the dipole at the middle of center towards the right ear orientation towards z
[index]=Save_Image(index);
%%
% 4 dipole at the center orinted along x axis
source.loc=[0 0 0.05];             % Input a source at the center
source.ori=[1 0 0];             % Input the orientation towards x axis
[V1,L]=Spherical_Head_Model(hm,source);% Comput the voltage at the electrodes from this dipole with the forward solution
Potential_Distribution(V1,hm,6,1)           % Show the potential distribution in the electrodes
title('Electrod potential from dipole at the center oriented along x axis')
[index]=Save_Image(index);
Plot_Electrode_Potential(V1,9)
[index]=Save_Image(index);
Show_Dipole_Placement([0 0 0 1 0 0],hm,8)    % The dipole location and its orientation has been plot
[index]=Save_Image(index);
%%
% 5 study the composition of L
Potential_Distribution(L(:,1),hm,17,1)
title('First column')
[index]=Save_Image(index);
Potential_Distribution(L(:,2),hm,18,1)
title('Second column')
[index]=Save_Image(index);
Potential_Distribution(L(:,3),hm,19,1)
title('Third column')
[index]=Save_Image(index);
%%
% % 6 two potential at the center, where one along the x axis the other along the z axis
source1.loc=[0 0 0];                % Input a source at the center
source1.ori=[0 0 1];                % Input the orientation towards z axis

source2.loc=[0 0 0];                % Input a source at the center
source2.ori=[1 0 0];                % Input the orientation towards x axis

source3.loc=[0 0 0];                % Input a source at the center
source3.ori=[1 0 1];                % Input the orientation towards x axis
%
[V1,L1]=Spherical_Head_Model(hm,source1);  % Comput the voltage at the electrodes from this dipole with the forward solution
[V2,L2]=Spherical_Head_Model(hm,source2);  % Comput the voltage at the electrodes from this dipole with the forward solution
[V3,L2]=Spherical_Head_Model(hm,source3);  % Comput the voltage at the electrodes from this dipole with the forward solution
VT=V1+V2;                           % Superimpose the voltages since the Maxwel equation is a linear relatoin
Potential_Distribution(VT,hm,20,1)             % Show the potential distribution in the electrodes
[index]=Save_Image(index);
Potential_Distribution(V1,hm,20,1)             % Show the potential distribution in the electrodes
[index]=Save_Image(index);
Potential_Distribution(V2,hm,20,1)             % Show the potential distribution in the electrodes
[index]=Save_Image(index);
Potential_Distribution(V3,hm,20,1)             % Show the potential distribution in the electrodes
[index]=Save_Image(index);
Show_Dipole_Placement([0 0 0 0 0 1],hm,8)    % The dipole location and its orientation has been plot
[index]=Save_Image(index);
Show_Dipole_Placement([0 0 0 1 0 0],hm,8)    % The dipole location and its orientation has been plot
[index]=Save_Image(index);
Show_Dipole_Placement([0 0 0 1 0 1],hm,8)    % The dipole location and its orientation has been plot
[index]=Save_Image(index);
%%
% 7 Simulate EEG
sourceEEG.loc=[0 -0.05 0.02];       % Input a source at the the indicated location
sourceEEG.ori=[0 0 1];              % Input the orientation towards z axis
f=200;                              % Sampling frequency
RotateFreq=10;                      % Rotation frequency in time domain
Duration=3;                         % Duration of the EEG signal
[EEG]=Simulate_EEG(sourceEEG,hm,f,RotateFreq,Duration);
%%
[dim1,dim2]=size(EEG);
t=linspace(0,3,dim1);
figure('units','normalized','outerposition',[0 0 1 1])
Vangjush_PlotEEG(EEG',t)
title('EEG signals at all the electrodes','FontSize',30)
xlabel('Time of measurement in sec','FontSize',30)
ylabel('Voltage at each electrode repsectively in uV','FontSize',30)
set(gca,'FontSize',30);
[index]=Save_Image(index);
Show_Dipole_Placement([0 -0.05 0.02 0 0 1],hm,8)    % The dipole location and its orientation has been plot
[index]=Save_Image(index);
%%
%  Potential_Movie(hm,EEG,f)
