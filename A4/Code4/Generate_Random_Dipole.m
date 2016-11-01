function [Random_Dipoles]=Generate_Random_Dipole(hm,Nr_Dipoles)
%%
Random_Dipoles=zeros(Nr_Dipoles,3);
center=hm.center;
h=waitbar(0,'Generating random dipoles inside head model');
for l=1:Nr_Dipoles
   i=hm.radius(1);
   j=hm.radius(1);
   k=hm.radius(1);
   while(sqrt(sum(([i-center(1),j-center(2),k-center(3)].^2)))>hm.radius(1))
       i=rand(1);
       j=rand(1);
       k=rand(1);
   end
   Random_Dipoles(l,1:3)=[i j k];
   Random_Dipoles(l,4:6)=[randi([0 1],1,1) randi([0 1],1,1) randi([0 1],1,1)];
   
   waitbar(l/Nr_Dipoles,h)
end
delete(h)
end