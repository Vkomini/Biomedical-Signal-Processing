function [kHz ]= Vangjus_Part_Per_Million2_k_Hz(PPM, Frequency,PPM_Ref) 
kHz = (PPM-PPM_Ref)*Frequency/10^6;
end