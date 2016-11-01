function Vangjush_Header_2_Latex_Table(name)
%%
name_file=strcat(name,'.txt');
fileID = fopen(name_file,'w');
str1='\hline';
str4='$K$&$Pure signal$&$Pure signal$&$Pure signal$&$Noisy signal$&$Noisy signal$&$Noisy signal$\\';
str2='\footnotesize ';
fprintf(fileID,'  %s    \n',str2);
fprintf(fileID,'$Compo$&$HSVD$&$HTLS$&$HTLSPKFD$&$HSVD$&$HTLS$&$HTLSPKFD$\\\\  \n');
fprintf(fileID,'  %s    \n',str1);
fprintf(fileID,' %s\n',str4);
fprintf(fileID,'  %s  \n',str1);
fclose(fileID);
end