function [fig]=Vangjush_Save_Images_1(fig)
%%
% t1=sprintf('%d',fig);
t1=num2str(fig);
File=sprintf('.jpg');
Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A1\Images1\',t1,File);
saveas(gcf,Name)
fig=fig+1;
close all
end