function Vangjush_Plot_Evaluation(SNR,SDR_3)
%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(SNR,SDR_3,'Linewidth',4);
hold on,plot(SNR,SDR_3,'x','Linewidth',20);
ylabel('SDR','FontSize',20)
xlabel('SNR','FontSize',20)
set(gca,'FontSize',15);
legend('PCA','ICA')
end