
clear all
close all
clc
%%
load headmodel19                % Load the head model
%% 1
sourceEEG1.loc=[0.06 0 0.01];                 % Input a source at the the indicated location
sourceEEG1.ori=[1 0 0];                       % Input the orientation towards x axis
[V_EEG1,L_EEG1]=Spherical_Head_Model(hm,sourceEEG1); % Compute the voltage done by this potential
[Result]=Solve_Inverse_Problem(V_EEG1,hm);% Solve the inverse proble meaning the computation of the dipole parameters from the computed dipole
index=100;
Plot_EE(Result,sourceEEG1,index)
 [index]=Save_Image(index);
PlotRRE(Result(:,7),index)                                  % Plot the set of the RRE values
 [index]=Save_Image(index);
Potential_Distribution(V_EEG1,hm,index,1)                     % Plot the potential at each electrode
[index]=Save_Image(index);

%% 3
sourceEEG2.ori=[1 0 0];                             % Input the orientation towards x axis
sourceEEG2.loc=[0.06 0 0.01];                       % Input a source at the the indicated location

[VEEG2,LEEG2]=Spherical_Head_Model(hm,sourceEEG2);         % Compute the voltage done by this potential
Potential_Distribution(VEEG2,hm,index,1)                            % Show the computed voltages at each electrode
 [index]=Save_Image(index);
VEEG2Error=VEEG2;
VEEG2Error(13)=0;                                   % The P8 electrode is shut down to see the impact
Potential_Distribution(VEEG2Error,hm,index,1)                       % Show the computed voltages at each electrode and the impact of the down electrode
 [index]=Save_Image(index);
VEEG2Error1=VEEG2;
VEEG2Error1(3)=0;                                   % The third electrode is shut down to see the impact
Potential_Distribution(VEEG2Error1,hm,5,index)                      % Show the computed voltages at each electrode and the impact of the down electrode
[index]=Save_Image(index);

result_point_error=Solve_Inverse_Problem(VEEG2,hm);                    % The inverse proble is computed in the case when all electrods are working
result_point_error1=Solve_Inverse_Problem(VEEG2Error,hm);          % The inverse proble is computed in the case when the p8 electrode is down
result_point_error2=Solve_Inverse_Problem(VEEG2Error1,hm);        % The inverse proble is computed in the case when the third electrode is down
%%
PlotRRE([result_point_error(:,7),result_point_error1(:,7),result_point_error2(:,7)],index)
legend('RRE all elctrd','RRE of P8 elctrd','RRE of F7 elctrd','Location','northoutside','Orientation','horizontal')
title('RRE of the mode')
[index]=Save_Image(index);
%%
Plot_EE(result_point_error,sourceEEG2,index)
title('Estimation all electrodes','FontSize',20)
[index]=Save_Image(index);
Plot_EE(result_point_error1,sourceEEG2,index)
title('Estimation error when P8 is off','FontSize',20)
[index]=Save_Image(index);
Plot_EE(result_point_error2,sourceEEG2,index)
title('Estimation error when F7 is off','FontSize',20)
[index]=Save_Image(index);
%%
index=110;
hm1=hm;
hm.condskull=(1/80)*hm.condsoft;               % The conductivity of the skull is altered to see the impact
Nr_Dipoles=10;                                          % The total number of the random dipoles around the head is computed
[Random_Dipoles]=Generate_Random_Dipole(hm,Nr_Dipoles);

for i=1:10
    sourceEEGS.loc(1:3)=Random_Dipoles(i,1:3);                   % Location of the sources in inputed
    sourceEEGS.ori(1:3)=Random_Dipoles(i,(1:3)+3);                 % Orientation of the sources in inputed
    [A,~]=Spherical_Head_Model(hm1,sourceEEGS);    % Voltage at each electrode for this specific dipole is computed
    Estimation1{i}=Solve_Inverse_Problem(A,hm);               % Dipole parameters for the computed volatage are computed
   [DOE(i,:),DLE(i,:)]=Plot_EE(Estimation1{i},sourceEEGS,index);
    a=sprintf('Error estimation with skull conductivity altered for dipole nr %d',i);
    title(a,'FontSize',20)
    [index]=Save_Image(index);
    close all
    Temp=Estimation1{i};
    PlotRRE(Temp(:,7),index)
    a=sprintf('RRE ');
    title(a);
    [index]=Save_Image(index);
end
%%
str1='Skull';
Vangjush_Parameter_2_Latex_Table(Estimation1,str1)

str1='Skull1';
Vangjush_Parameter_2_Latex_Table1(DOE,str1)

str1='Skull2';
Vangjush_Parameter_2_Latex_Table1(DLE,str1)
%%
clear all
index=200;
load headmodel19
hm1=hm;
Nr_Dipoles=10;                                          % The total number of the random dipoles around the head is computed
[Random_Dipoles]=Generate_Random_Dipole(hm,Nr_Dipoles);
offset=1e-3;
phi=offset*360/2/pi/hm.radius(3);
hm.elpos(1,2)=hm.elpos(1,2)+1;                          % The first electrode is displaced by 1 cm
for i=1:Nr_Dipoles
    sourceEEGS.loc(1:3)=Random_Dipoles(i,1:3);                   % Location of the sources in inputed
    sourceEEGS.ori(1:3)=Random_Dipoles(i,(1:3)+3);                 % Orientation of the sources in inputed
    [A,~]=Spherical_Head_Model(hm1,sourceEEGS);    % Voltage at each electrode for this specific dipole is computed
    Estimation1{i}=Solve_Inverse_Problem(A,hm);               % Dipole parameters for the computed volatage are computed
    [DOE(i,:),DLE(i,:)]=Plot_EE(Estimation1{i},sourceEEGS,index);
    a=sprintf('Error estimation with electrod location altered for dipole nr %d',i);
    title(a,'FontSize',20)
    [index]=Save_Image(index);
    close all
    Temp=Estimation1{i};
    PlotRRE(Temp(:,7),index)
    a=sprintf('RRE ');
    title(a);
    [index]=Save_Image(index);
end
str1='Electrode';

Vangjush_Parameter_2_Latex_Table(Estimation1,str1)

str1='Electrode1';
Vangjush_Parameter_2_Latex_Table1(DOE,str1)

str1='Electrode2';
Vangjush_Parameter_2_Latex_Table1(DLE,str1)
%% 2
% Simulate EEG
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
Vangjush_PlotEEG(EEG',t);
title('EEG signals at all the electrodes','FontSize',30)
xlabel('Time of measurement in sec','FontSize',30)
ylabel('Voltage at each electrode repsectively in uV','FontSize',30)
set(gca,'FontSize',30);
[x,y]=ginput(1);
V=EEG';
Temp=V(:,round(x*f));
%%
result_point_error=Solve_Inverse_Problem(Temp,hm);   
str1='EEG';
Vangjush_Parameter_2_Latex_Table2(result_point_error,str1)