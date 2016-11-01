function Vangjush_Costum_Plot()
%%
set(gca,'xdir','reverse');
x=xlabel('ppm');
y=ylabel('Amplitude (a.u.)');
set(x,  'FontSize',18);
set(y,  'FontSize',18);
set(gca,'FontSize',18);
xlim([0 8])
end