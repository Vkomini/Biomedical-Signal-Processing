function [index]=Save_Image(index)
%%
File=sprintf('.jpg');
Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A4\Images4\',num2str(index),File);
% saveas(gcf,Name)
index=index+1;
close all
end