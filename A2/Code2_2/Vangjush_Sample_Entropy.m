function [Sample_Entropy ]= Vangjush_Sample_Entropy( Time_Series ,dim, r )
%%
Data_Length=length(Time_Series);
%% Construction of the pair values vectors where hoizontally are concatet the consequetive values from 1 till dim+1 
for i=1:dim+1
    Time_Series_data(i,:)=squeeze(Time_Series(i:Data_Length-dim+i-1));
end
%% Now we compare the pairs of dimension dim and dim+1 exluding the self-similiar pattern which is the main diffrence from ApEn.
index=1;
for i=dim:dim+1
    Temp_Time_Series_data=Time_Series_data(1:dim,:);
    for j=1:Data_Length-dim-1 
        [~,y]=size(Temp_Time_Series_data);
        Temp=Temp_Time_Series_data(:,j+1);
        Temp_Data=repmat(Temp,1,y);
        Distance=max(abs(Temp_Time_Series_data-Temp_Data));
        Dist=Distance<r;
        Dist_Wanted(i)=sum(Dist);
    end
    AB(index)=sum(Dist_Wanted);
    index=index+1;
end
Sample_Entropy=-log(AB(1)/AB(2));
end
