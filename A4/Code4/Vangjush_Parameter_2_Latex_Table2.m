function Vangjush_Parameter_2_Latex_Table2(Control,str1)
%% 
name_file=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A4\Files\',str1,'.txt');
fileID = fopen(name_file,'w');
fprintf(fileID,'%s',' \hline');
for j=1:5
    fprintf(fileID,'$D%d$&$',j);
    for k=1:7
        if k<7
            fprintf(fileID,'%6.2e$&$',Control(j,k));
        end
        if k==7
            fprintf(fileID,'%6.2e$\\\\',Control(j,k));
        end
    end
    fprintf(fileID,'%s',' \hline');
end
fprintf(fileID,' \n');
fclose(fileID);
%%
end