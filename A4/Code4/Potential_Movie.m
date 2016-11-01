function Potential_Movie(Head_Model,EEG,fs)
%%
a=size(EEG);
for i=1:max(a);
    Potential_Distribution(EEG(i,:)',Head_Model,30,0)               
    drawnow;
    pause(1/fs);
end
end