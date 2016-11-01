function [V,L]=Spherical_Head_Model(Head_Model,source)
%%
Location=source.loc;
Electrode_position=Head_Model.elpos;
Radiuses=Head_Model.radius;
X=Head_Model.condratio;
S=Head_Model.condsoft;
rhead=Radiuses(3);
r2=rhead;

f1=Radiuses(1)/Radiuses(3);
f2=Radiuses(2)/Radiuses(3);

K1=1/(4*pi*S*rhead^2);



NOFTERMS=80;

theta=Electrode_position(:,1);
phi=Electrode_position(:,2);
Nr_Of_Electrodes=length(theta);




Tx=zeros(Nr_Of_Electrodes,1);% Tangent component along X
Ty=zeros(Nr_Of_Electrodes,1);% Tangent component along Y
Tz=zeros(Nr_Of_Electrodes,1);% Tangent component along Z

t=zeros(Nr_Of_Electrodes,1);
q=zeros(Nr_Of_Electrodes,1);
R2=zeros(Nr_Of_Electrodes,3);
cosalpha=zeros(Nr_Of_Electrodes,1);

V=zeros(Nr_Of_Electrodes,1);
Vx=zeros(Nr_Of_Electrodes,1);
Vy=zeros(Nr_Of_Electrodes,1);
Vz=zeros(Nr_Of_Electrodes,1);

for i=1:Nr_Of_Electrodes
    R2(i,1)=rhead*sin(theta(i))*cos(phi(i));
    R2(i,2)=rhead*sin(theta(i))*sin(phi(i));
    R2(i,3)=rhead*cos(theta(i));
end


R1=Location;
r1=sqrt( R1(1)^2+R1(2)^2+R1(3)^2 );
if r1~=0
    %% Computation of Tangential and Radial components
    b=r1/rhead;
    p=r1^2;
    for i=1:Nr_Of_Electrodes
        q(i)=R1(1)*R2(i,1) + R1(2)*R2(i,2)+ R1(3)*R2(i,3);
        cosalpha(i)=q(i)./r1./r2;
        if (abs(cosalpha(i))>1.0)
            cosalpha(i)=cosalpha(i)/abs(cosalpha(i));
        end
        Tx(i)=R2(i,1)*p - R1(1)*q(i);
        Ty(i)=R2(i,2)*p - R1(2)*q(i);
        Tz(i)=R2(i,3)*p - R1(3)*q(i);
        t(i)=sqrt(sum([Tx(i)  Ty(i) Tz(i)].^2));
        if (t(i)~=0)
            Tx(i)=Tx(i)/t(i);
            Ty(i)=Ty(i)/t(i);
            Tz(i)=Tz(i)/t(i);
        end
    end
    Rx=R1(1)/r1;% Radial component along X
    Ry=R1(2)/r1;% Radial component along Y
    Rz=R1(3)/r1;% Radial component along Z
    
    %%
    for i=1:NOFTERMS
        i1=2*i+1;
        gi=((i+1)*X+i)*(i*X/(i+1)+1) + (1-X)*((i+1)*X+i)*(f1^i1-f2^i1) -...
            i*(1-X)*(1-X)*(f1/f2)^i1;
        fact1=X*i1^3*b^(i-1)/gi/(i+1)/i;
        for j=1:Nr_Of_Electrodes
            fact2=i*PLG(i,0,cosalpha(j));
            fact3=-PLG(i,1,cosalpha(j));
            %             fact2=i*legendre(i,cosalpha(j));
            %             fact3=-legendreP(i,cosalpha(j));
            Vx(j)=Vx(j)+fact1*(fact2*Rx+fact3*Tx(j));
            Vy(j)=Vy(j)+fact1*(fact2*Ry+fact3*Ty(j));
            Vz(j)=Vz(j)+fact1*(fact2*Rz+fact3*Tz(j));
        end
    end
else
    i=1; i1=2*i+1;
    gi=((i+1)*X+i)*(i*X/(i+1)+1) + (1-X)*((i+1)*X+i)*(f1^i1-f2^i1) -...
        i*(1-X)*(1-X)*(f1/f2)^i1;
    fact1=X*i1^3^(i-1)/gi/(i+1)/i;
    for j=1:Nr_Of_Electrodes
        Vx(j)=fact1*PLG(1,0,R2(j,1)/r2);
        Vy(j)=fact1*PLG(1,0,R2(j,2)/r2);
        Vz(j)=fact1*PLG(1,0,R2(j,3)/r2);
        %         Vx(j)=fact1*legendre(1,R2(j,1)/r2);
        %         Vy(j)=fact1*legendre(1,R2(j,2)/r2);
        %         Vz(j)=fact1*legendre(1,R2(j,3)/r2);
    end
end
%%
Voltage_Ref=zeros(Nr_Of_Electrodes,3);
for i=1:Nr_Of_Electrodes
    Voltage_Ref(i,:)=[Vx(i) Vy(i) Vz(i)];
end

% average referencing
Voltage_Ref = Voltage_Ref-ones(Nr_Of_Electrodes,1)*sum(Voltage_Ref)/Nr_Of_Electrodes;
L=K1*Voltage_Ref*1e-3;
if  1 < length(fieldnames(source))
    V=L*source.ori';
else
    V=[];
end
end