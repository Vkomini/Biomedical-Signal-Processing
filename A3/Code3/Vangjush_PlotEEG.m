function Vangjush_PlotEEG(sig,t)
%%
figure('units','normalized','outerposition',[0 0 1 1])
[dim1,dim2]=size(sig);
mi = min(sig,[],2);
ma = max(sig,[],2);
shift = cumsum([0; abs(ma(1:end-1))+abs(mi(2:end))]);
shift = repmat(shift,1,dim2);
plot(t,sig+shift)
set(gca,'ytick',mean(sig+shift,2),'yticklabel',1:dim1)
grid on
end