function Vangjush_Parameter_2_Latex_Table(Frequency_Parameters,name)
%%
Frequency_Parameters=Frequency_Parameters';
[dim1,dim2]=size(Frequency_Parameters);
name_file=strcat(name,'.txt');
fileID = fopen(name_file,'w');
str1='\hline';
str4='$K$&$Pure signal$&$Pure signal$&$Pure signal$&$Noisy signal$&$Noisy signal$&$Noisy signal$\\';
str2='\footnotesize ';
% fprintf(fileID,'  %s    \n',str2);
% fprintf(fileID,'$Compo$&$HSVD$&$HTLS$&$HTLSPKFD$&$HSVD$&$HTLS$&$HTLSPKFD$\\\\  \n');
% fprintf(fileID,'  %s    \n',str1);
% fprintf(fileID,' %s\n',str4);
% fprintf(fileID,'  %s    \n',str1);
for i=1:dim1
    fprintf(fileID,'$%d$&$',i);
    for j=1:dim2
        if j<dim2
            if Frequency_Parameters(i,j)==0
                fprintf(fileID,'$%d$&$',Frequency_Parameters(i,j));
            else
                fprintf(fileID,'%6s$&$',Frequency_Parameters(i,j));
            end
        else
            if Frequency_Parameters(i,j)==0
                fprintf(fileID,'$%d$\\\\ \n',Frequency_Parameters(i,j));
            else
                fprintf(fileID,'%6s$\\\\ \n',Frequency_Parameters(i,j));
            end
        end
    end
end
fprintf(fileID,'  %s  \n',str1);
fclose(fileID);
end