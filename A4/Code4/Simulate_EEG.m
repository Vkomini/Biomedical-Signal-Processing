function [EEG]=Simulate_EEG(sourceEEG,hm,f,RotateFreq,Duration)
%%
[RotateFreqRadReplecated,~]=GenerateTimeSeries(f,RotateFreq,Duration); % Compute the array of the rotation angles
for i=1:length(RotateFreqRadReplecated)
    Rotation=[0 sin(RotateFreqRadReplecated(i)) cos(RotateFreqRadReplecated(i))];%RotateDipole(sourceEEG.ori',RotateFreqRadReplecated(i),0,0)      % Rotation the dipole consistently to the rotation angles
    sourceEEG.ori=Rotation;                       
    [EEG(i,:),~]=Spherical_Head_Model(hm,sourceEEG);                    % Compute the voltage done by this potential
end
end