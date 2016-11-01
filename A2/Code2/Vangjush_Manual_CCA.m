function [fig,y]=Vangjush_Manual_CCA(Y,R,W,k,fig,PL)
%%
y=W'*Y;                                      % Reconstruct the signals from the CCA
[NumberOfChannels,~]=size(y);      % Extract the number of channels and the length of each signal
iterations=1;                                   % iteration index
for i=NumberOfChannels:-1:1
    a=input('press 1 to continue');             % Manual control for proceeding the removal of the noisy component, 1 to conitue and anything else to interup
    if(a==1)
        R(length(R))=[];                        % Removal of the last correlation coefficient with the lowest value
        %%
        % Here is the secion of ploting the result
        if PL~=1
            figure
            plot(R),hold on,plot(R,'>')
            x=xlabel('Component');
            y=ylabel('Correlation coefficent');
            b=sprintf('Component remain after %d iteration',iterations);
            title(b);
            set(x,  'FontSize',18);
            set(y,  'FontSize',18);
            set(gca,'FontSize',18);
            [fig]=Vangjush_Save_Images(fig);
        end
        %%
        Y(i,:)=[];                           % Removal of the last component corresponding to the lowest correlation coefficient
        W(i,:)=[];                           % Removal of the last linear coefficent corresponding to the lowest correlation coefficient
        y=W'*Y;                              % Reconstruction of the EEG signal without the last component which was removed
        %%
        % Here is the secion of ploting the result after removal of the last componet
        if PL~=1
            Vangjush_PlotEEG(Y)
            a=sprintf('Manual CCA channels for EEG%d after % iteration',k,iterations);
            title(a)
            [fig]=Vangjush_Save_Images(fig);
            Vangjush_PlotEEG(y)
            a=sprintf('Manual CCA EEG%d after % iteration',k,iterations);
            title(a)
            [fig]=Vangjush_Save_Images(fig);
        end
    else
        break
    end
    iterations=iterations+1;
end
[fig]=Vangjush_Save_Images(fig);
end