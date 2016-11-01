function Vangjush_PlotEEG(sig,t)
%%
% t=0:size(sig,2)-1;
[dim1,dim2]=size(sig);
mi = min(sig,[],2);
ma = max(sig,[],2);
shift1 = cumsum([0; abs(ma(1:end-1))+abs(mi(2:end))]);
shift = repmat(shift1,1,dim2);
plot(t,sig+shift,'LineWidth',2)
set(gca,'ytick',mean(sig+shift,2),'yticklabel',1:dim1)
grid on
end