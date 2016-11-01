function Electrod_Names(Head_Model,r,Font)
%%
Element_Position=Head_Model.elpos;
Electrode_Names=Head_Model.meas;
%%
Electr_Position_Cartesian=Spherical_To_Cartesian_Coordiante([Element_Position, r*ones(length(Element_Position),1)]');
Electr_Position_Cartesian_text=Spherical_To_Cartesian_Coordiante([Element_Position, r*(ones(length(Element_Position),1)+0.3)]');

for i=1:size(Electr_Position_Cartesian,2)
    text(Electr_Position_Cartesian_text(1,i)',Electr_Position_Cartesian_text(2,i)',Electr_Position_Cartesian_text(3,i)'+r*0.011,...
        [num2str(i) ' ' Electrode_Names.el.lbl{i}],'FontSize',Font);    
end
end