function [Rescaled_Range_Series]=Vangjush_Hurst_Exponential(Signal)
%%
Data_length=length(Signal);
Mu=mean(Signal);
for i=1:Data_length
% Mean computation 
    Mean_Data=mean(Signal(1:i));
    % Mean adjusted
    Mean_Data_Adjusted(i)=Signal(i)-Mean_Data;
    % Cumulative deviate series
    Cumulative_Deviate_Series(i)=sum(Mean_Data_Adjusted(1:i));
    % Calculate range series R
    Range_Series(i)=max(Cumulative_Deviate_Series(1:i))-min(Cumulative_Deviate_Series(1:i));
    % Calculate standard deviation series S
    Standard_Deviation_Series(i)=sqrt((1/i)*sum((Signal(1:i)-Mu).^2));
    % Calculate rescaled range series
    Rescaled_Range_Series(i)=Range_Series(i)./Standard_Deviation_Series(i);
end
end