function [fig]=Vangjush_Save_Images(fig)
%%
t1=sprintf('%d',fig);
File=sprintf('.jpg');
Name=strcat(t1,File);
saveas(gcf,Name)
fig=fig+1;
end