function [fig]=Vangjush_Save_Images(fig)
file='.jpg';
Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A3\Images3\',num2str(fig),file);
saveas(gcf,Name)
close all
fig=fig+1;
end