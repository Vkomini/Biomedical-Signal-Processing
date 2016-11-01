function [Signal_Whited]=Vangjush_Whitening(Signal)
%%
Covariance_Matrix=cov(Signal');        % Covariance matrix
[V,D]=eig(Covariance_Matrix);          % Eigvalue decomposition
Signal_Whited=(V/(sqrt(D)))*V'*Signal; % Whitening
end