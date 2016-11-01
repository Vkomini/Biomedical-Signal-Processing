function [T_q]=Vangjush_Vandermond_Tq_Matrix(Damping_known,Frequency_known,Sampling_Frequency,M)
%%
Poles_Known=exp((-Damping_known+1i*2*pi*Frequency_known)/Sampling_Frequency);
Temp1=repmat(Poles_Known,M,1);
Temp2=0:M-1;
Power=repmat(Temp2,length(Poles_Known),1)';
T_q=Temp1.^Power;
end
