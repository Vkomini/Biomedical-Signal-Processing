function Electrode_Position_V(Head_Model,~)
%%
% figure(nr_fig)
figure('units','normalized','outerposition',[0 0 1 1])
r=Head_Model.radius(end);
Nr_Points=20;
Font1=20;
Font=30;
scale=1.5;
manner='filled';

DrawSpehere(Nr_Points,r)
hold on

Position_Of_Electrodes(Head_Model,r,manner);
Electrod_Names(Head_Model,r,Font)

Draw_Nouse(r,Font1);

Labeling(Font)
title('Electrode distribution in head','FontSize',Font);
Bounding(scale,r);
set(gca,'FontSize',Font);
end
