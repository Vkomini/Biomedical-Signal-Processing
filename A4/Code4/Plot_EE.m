function [DOE,DLE]=Plot_EE(Result,sourceEEG1,~)
%%
[DOE,DLE]=Estimation_Error(Result,sourceEEG1);
figure('units','normalized','outerposition',[0 0 1 1])
X=1:length(DOE);
[hAx,~,~]=plotyy(X,DOE,X,DLE);
title('Estimation Error','FontSize',20)
xlabel('Dipole number','FontSize',20)
ylabel(hAx(1),'DOE [deg]','FontSize',15) % left y-axis
ylabel(hAx(2),'DLE [m]','FontSize',15) % right y-axis
set(hAx,'FontSize',15);

end