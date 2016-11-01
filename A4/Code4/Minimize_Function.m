function [Result]=Minimize_Function(Random_Dipoles,HeadModel,V)
%%
h=waitbar(0,'Locating the sources');
Nr_Dipoles=size(Random_Dipoles,1);
for i=1:Nr_Dipoles
    % Location calculation
    [Result(i,1:3),Voltage]=fminsearch('Localization_Error',Random_Dipoles(i,1:3),optimset('TolX',1.e-4,'TolFun',1.e-5,'Display','off','MaxFunEvals',100000,'MaxIter',10000),HeadModel,V);
    % Orientation calculation
    source.loc=Result(i,1:3);
    [~,L]=solve_forward(HeadModel,source);    
    Orientation=pinv(L)*V;    
    Orientation_Nomalized=Orientation./norm(Orientation);    
    Result(i,4:6)=[Orientation_Nomalized(1),Orientation_Nomalized(2),Orientation_Nomalized(3)];
    Result(i,7)=Voltage;
    waitbar(i/Nr_Dipoles,h);
end
delete(h);
end