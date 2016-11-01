function Vangjush_Histogram_Amplitudes(X)
%%
figure('units','normalized','outerposition',[0 0 1 1])
[Nr_Of_Channels,~]=size(X);
for i=1:Nr_Of_Channels
    subplot(ceil(sqrt(Nr_Of_Channels)),ceil(Nr_Of_Channels/sqrt(Nr_Of_Channels)),i)
    hist(X(i,:));
    a=sprintf('Signal %d',i);
    title(a);
end
end
