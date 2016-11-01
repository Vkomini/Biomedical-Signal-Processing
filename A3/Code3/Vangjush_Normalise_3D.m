function  [Scaleogram,MeanData,StandartDeviation] =Vangjush_Normalise_3D(Data,Start_point,Ending_Point,Scale)
%%
Partial_Data=Data(:,Start_point*250+1:Ending_Point*250);
MeanData=mean(Partial_Data,2);
Partial_Data=Partial_Data-MeanData(:,ones(1,size(Partial_Data,2)));
StandartDeviation=std(Partial_Data,[],2);
Partial_Data=Partial_Data./StandartDeviation(:,ones(1,size(Partial_Data,2)));
for k=1:size(Partial_Data,1)
  Scaleogram(k,:,:)=cwt(Partial_Data(k,:),Scale,'bior1.3');
end
end