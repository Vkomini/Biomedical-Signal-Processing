function Plot_Electrode_Potential(V,nr)
figure(nr),plot(V,'x','LineWidth',13),hold on,plot(V,'r','LineWidth',3)
xlabel('Electrode Number','FontSize',20)
ylabel('Voltage [uV]','FontSize',20)
title('Electrode potential','FontSize',20)
set(gca,'fontsize', 20);
end