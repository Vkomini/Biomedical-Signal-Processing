function [Damping_Parameters,Frequency_Parameters]=Vangjush_Freq_Damping_Esti(E,Sampling_Frequency)
%%
% Harmonic retrieval from the eigenvalues of the matrix E 
Damped_Exponential_Z=eig(E).';                                  % Eigen value computation of the matrix E 
[~,Index_Ascend]=sort(imag(log(Damped_Exponential_Z)),'ascend');% Sort the component into ascending order of the frequencies 
Damped_Exponential_Z=Damped_Exponential_Z(Index_Ascend);        % Arrange thee exponential damping part consistently to ascending order of the 
Period_Inverse_Scaling_Factor=Sampling_Frequency/(2*pi);        % Time inverse scaling factor used to retrive the frequency component
Frequency_Parameters=imag(log(Damped_Exponential_Z)*Period_Inverse_Scaling_Factor);
Damping_Parameters=-real(log(Damped_Exponential_Z)*Sampling_Frequency);
end