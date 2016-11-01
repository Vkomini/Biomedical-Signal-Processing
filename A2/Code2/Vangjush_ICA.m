function [fig,y]=Vangjush_ICA(EEG,fig,PL)
%%
% Shperical signal
if PL~=1
% %     figure('units','normalized','outerposition',[0 0 1 1])
    Vangjush_PlotEEG(EEG)
    title('EEG signal')
end
[fig]=Vangjush_Save_Images(fig);
% Centering the data poits
[Signal_Centered]=Vangjush_Centering(EEG);
if PL~=1
% %     figure('units','normalized','outerposition',[0 0 1 1])
    Vangjush_PlotEEG(Signal_Centered)
    title('EEG signal centered')
    [fig]=Vangjush_Save_Images(fig);
end
% Whitening the centered datapoints
% Covariance matrix
[Signal_Whited]=Vangjush_Whitening(Signal_Centered);
% figure
% Vangjush_PlotEEG(Signal_Whited)
% title('EEG signal whited')
% [fig]=Vangjush_Save_Images(fig);
% Fast ICA
tic
[w]=Vangjush_Fast_ICA(Signal_Whited);
toc
y=w'*Signal_Whited;
%Vangjush_PlotEEG the real signals
if PL~=1
    Vangjush_PlotEEG(Signal_Whited)
    title('EEG signal whited')
    [fig]=Vangjush_Save_Images(fig);
end
%Vangjush_PlotEEG the reconstructed signals
if PL~=1
    Vangjush_PlotEEG(y)
    title('EEG after Fast ICA')
    [fig]=Vangjush_Save_Images(fig);
end
%Histogram of the real signal
if PL~=1
    Vangjush_Histogram_Amplitudes(EEG)
    suptitle('Histogram of EEG')
    [fig]=Vangjush_Save_Images(fig);
end
%Histogram of the reconstructed signal
if PL~=1
    Vangjush_Histogram_Amplitudes(y)
    suptitle('Histogram after Fast ICA')
    [fig]=Vangjush_Save_Images(fig);
end
end