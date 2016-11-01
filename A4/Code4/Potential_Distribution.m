function Potential_Distribution(V,Head_Model,~,barcolor)
%%
scale=1.5;
Font=20;

% figure(Nr_Fig)
figure('units','normalized','outerposition',[0 0 1 1])
set(axes,'NextPlot','add');
r=Head_Model.radius(end);
[X,Y,Z]=sphere(50);
fvc=surf2patch(r*X,r*Y,r*Z);
manner='ko';

Position_Of_Electrodes(Head_Model,r,manner)
Electrod_Names(Head_Model,r,Font-5)

Se=Spherical_To_Cartesian_Coordiante([Head_Model.elpos(:,1)'; Head_Model.elpos(:,2)'; r*1.17*ones(size(Head_Model.elpos(:,2)))']);
F=TriScatteredInterp(Se(1,:)',Se(2,:)',Se(3,:)',V);
VI=F(fvc.vertices(:,1),fvc.vertices(:,2),fvc.vertices(:,3));
p1=patch(fvc);
set(p1,'FaceColor','interp','EdgeColor','none','FaceVertexCData',VI);


lightangle(-45,30)
h.FaceLighting = 'gouraud';
h.AmbientStrength = 0.3;
h.DiffuseStrength = 0.8;
h.SpecularStrength = 0.9;
h.SpecularExponent = 25;
h.BackFaceLighting = 'unlit';

if barcolor==1
    c=colorbar('westoutside');
    % c=colorbar('AxisLocation','in')
    c.Label.String = 'Potential distribution';
end
Draw_Nouse(r,Font);
Labeling(Font)
Bounding(scale,r);
view(-90,90)
end