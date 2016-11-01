function Show_Dipole_Placement(dipole,Head_Model,Nr_Fig)
%%
Font=20;
Nr_Points=20;
scale=1.5;
manner='filled';
% figure(Nr_Fig)
figure('units','normalized','outerposition',[0 0 1 1])
r=Head_Model.radius(end);
set(axes,'NextPlot','add');

DrawSpehere(Nr_Points,r)
Draw_Nouse(r,Font);

Position_Of_Electrodes(Head_Model,r,manner)
Electrod_Names(Head_Model,r,Font)

%plot dipoles
for i=1:size(dipole,1)
    dipole(i,4:6)=0.3*r*dipole(i,4:6)./norm(dipole(i,4:6));
    plot3(dipole(i,1),dipole(i,2),dipole(i,3),'g.','MarkerSize',50);
    plot3([dipole(i,1) dipole(i,1)+dipole(i,4)],...
        [dipole(i,2) dipole(i,2)+dipole(i,5)],...
        [dipole(i,3) dipole(i,3)+dipole(i,6)],'b','LineWidth',3);
    a=8e-4*max([dipole(i,1),dipole(i,2),dipole(i,3)]);
    text(dipole(i,1)+a,dipole(i,2)+a,dipole(i,3)+a,'Dipole','FontSize',Font);
end

Labeling(Font)
title('Dipole locations','FontSize',Font);
Bounding(scale,r);
set(gca,'FontSize',Font);
view(3)
end