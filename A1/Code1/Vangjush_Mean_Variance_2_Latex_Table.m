function Vangjush_Mean_Variance_2_Latex_Table(Frequency_Parameters,name)
%%
Frequency_Parameters=Frequency_Parameters';
[dim1,dim2]=size(Frequency_Parameters);
name_file=strcat(name,'.txt');
fileID = fopen(name_file,'w');
str1='\hline';
str4='$ $&$Pure signal$&$Pure signal$&$Pure signal$&$Noisy signal$&$Noisy signal$&$Noisy signal$\\';
fprintf(fileID,'$ $&$HSVD$&$HTLS$&$HTLSPKFD$&$HSVD$&$HTLS$&$HTLSPKFD$\\\\  \n');
fprintf(fileID,'  %s    \n',str1);
fprintf(fileID,' %s\n',str4);
fprintf(fileID,'  %s    \n',str1);
for i=1:dim1
    if i==1
    fprintf(fileID,'$Mean$&$');
    elseif i==2
    fprintf(fileID,'$Var$&$');
    else
    fprintf(fileID,'$RMSE$&$');
    end
    for j=1:dim2
        if j<dim2
            fprintf(fileID,'%6s$&$',Frequency_Parameters(i,j));
        else
            fprintf(fileID,'%6s$\\\\ \n',Frequency_Parameters(i,j));
        end
    end
end
fprintf(fileID,'  %s  \n',str1);
fclose(fileID);
end