function [Mixing_Matrix]=Vangjush_Fast_ICA(Signal_Mixing_Matrixhited)
%%
[Nr_Of_Channels,Signal_Length]=size(Signal_Mixing_Matrixhited);
Mixing_Matrix=rand(Nr_Of_Channels);
for i=1:Nr_Of_Channels
    Component_Mixing_Matrix=Mixing_Matrix(:,i);
    m=0;
    while(true)
        Mixing_Matrix(:,i)=Component_Mixing_Matrix;
        g=tanh(Signal_Mixing_Matrixhited'*Mixing_Matrix(:,i));
        g1=ones(size(g))-g.^2;
        Mixing_Matrix1=(Signal_Mixing_Matrixhited*g-sum(g1)*Mixing_Matrix(:,i))/Signal_Length;
        Mixing_Matrix(:,i)=Mixing_Matrix1/sqrt(sum(Mixing_Matrix1.^2));
%         if Mixing_Matrix(:,i)'*Mixing_Matrix(:,i)>0.999
        if m>10
            break
        end
        m=m+1;
        Component_Mixing_Matrix=Mixing_Matrix(:,i);
    end
    if(i<Nr_Of_Channels)
        s=zeros(size(Mixing_Matrix(:,i)));
        for j=1:i
            s=s+(Mixing_Matrix(:,i+1)'*Mixing_Matrix(:,j))*Mixing_Matrix(:,j);
        end
        Mixing_Matrix(:,i+1)=Mixing_Matrix(:,i+1)-s;
        Mixing_Matrix(:,i+1)=Mixing_Matrix(:,i+1)/sqrt(Mixing_Matrix(:,i+1)'*Mixing_Matrix(:,i+1));
    end
end
end