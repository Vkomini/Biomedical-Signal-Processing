function Position_Of_Electrodes(hm,r,manner)
%%
Elect_Postion=Spherical_To_Cartesian_Coordiante([hm.elpos(:,1)'; hm.elpos(:,2)'; r*1*ones(size(hm.elpos(:,2)))']);
X_el=Elect_Postion(1,:)';
Y_el=Elect_Postion(2,:)';
Z_el=Elect_Postion(3,:)';
S = 500*ones(size(X_el));
C = 500*ones(size(X_el));
scatter3(X_el,Y_el,Z_el,S,C,manner),view(-90,90)
end