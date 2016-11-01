function [RotateFreqRad_Inter,TimeArray]=GenerateTimeSeries(f,RotateFreq,Duration)
% f=200;
T=1/f;                                % Comput the period of sampling from the sampling frequency
TimeArray=0:T:Duration;               % Time array of the sampling       
TimeArray(end)=[];      % Removing the last sample in time since we start from 0 sec
%%
T_Retota=1/RotateFreq;                % Compute the rotation period in sec
RotateAngle=0:T_Retota:20*Duration;      % Compute the array of the rotation in sec
RotateAngle(end)=[];  % Removing the last sample in time since we start from 0 sec
RotateFreqRad=RotateAngle*pi;         % Compute the array of rotation angle in rad
%%
A=length(RotateFreqRad);              % Length of the rotate angle array
B=length(TimeArray);                  % Length of the time array
% A1=rem(B,A);                          % Division residue between this data
B1=round(B/A);                        % The scale of data size between this two data
RotateFreqRad_Inter=interp(RotateFreqRad,B1);
end