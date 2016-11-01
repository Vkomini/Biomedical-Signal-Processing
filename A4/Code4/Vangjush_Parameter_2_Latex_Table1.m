function Vangjush_Parameter_2_Latex_Table1(Control,str1)
%% 
name_file=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A4\Files\',str1,'.txt');
fileID = fopen(name_file,'w');
fprintf(fileID,'%s',' \hline');
for j=1:10
    fprintf(fileID,'$Trial%d$&$',j);
    for k=1:5
        if k<5
            fprintf(fileID,'%6.2e$&$',Control(j,k));
        end
        if k==5
            fprintf(fileID,'%6.2e$\\\\',Control(j,k));
        end
    end
    fprintf(fileID,'%s',' \hline');
end
fprintf(fileID,' \n');
fclose(fileID);
%%
end