function Result=Solve_Inverse_Problem_Dipole_Ana(V,hm)
%%
n=5;
[Random_Dipoles]=Generate_Random_Dipoles(hm,n);
[Result]=Minimize_Function(Random_Dipoles,hm,V);
end
