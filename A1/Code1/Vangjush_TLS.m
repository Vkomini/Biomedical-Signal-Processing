function [E]=Vangjush_TLS(U_trancated,Row_Length,Component_Number)
%%
U_trancated_up=U_trancated(1:Row_Length-1,:);          
U_trancated_down=U_trancated(2:Row_Length,:);             
C=U_trancated_up;
C(:,Component_Number+1:2*Component_Number)=U_trancated_down;  
[~,~,v]=svd(C,0);    
A=v(1:Component_Number,Component_Number+1:2*Component_Number);
B=pinv(v(Component_Number+1:2*Component_Number,Component_Number+1:2*Component_Number));
E=-A*B; 
end