function PlotRRE(RRE,~)
%%
% figure(Nr)
figure('units','normalized','outerposition',[0 0 1 1])
plot(RRE,'x','LineWidth',10)
hold on
plot(RRE,'o','LineWidth',10)
hold on
plot(RRE,'r','LineWidth',3)
xlabel('Solutions trials','FontSize',20);
ylabel('Error value in [A.u]','FontSize',20);
title('RRE plot for respective dipole','FontSize',20);
set(gca,'FontSize',20);
end
