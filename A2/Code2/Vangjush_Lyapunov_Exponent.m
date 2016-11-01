function [Lambda]=Vangjush_Lyapunov_Exponent(Vectors,Distances)
%%
Dimension=max(size(Vectors));
Embedded_Dimension=min(size(Vectors));
Lambda=0;
for i=1:Dimension
%     P1=Vectors(i,:);
    Distances(i,i)=Inf;
    [Lt1,Index]=min(Distances(i,:));
%     if Index==Index
%     Distances(i,:)
%     P1=Vectors(Index,:);
    Lt2=sqrt(sum((Vectors(i+1,:)-Vectors(Index+1,:)).^2));
%     Lambda=Lambda+log2(Lt1/Lt2);
    Lambda(i)=log2(Lt1/Lt2);
end
Lambda=sum(Lambda);
end