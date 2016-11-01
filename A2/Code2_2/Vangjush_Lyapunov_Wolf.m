function [Lyapunov_Exponent] = Vangjush_Lyapunov_Wolf(Phase_Space,dt)
%%
% calculate lyapunov coefficient of time series

[Length_Data,~]=size(Phase_Space);

% N4 = 1;
N2 = floor(Length_Data/2);
N4 = floor(Length_Data/4);
TOL = 1.0e-6;

exponent = zeros(N4+1,1);

for i=N4:N2  % second quartile of data should be sufficiently evolved
   dist = norm(Phase_Space(i+1,:)-Phase_Space(i,:));
   Index = i+1;
   for j=1:Length_Data-5
       if (i ~= j) && norm(Phase_Space(i,:)-Phase_Space(j,:))<dist
           dist = norm(Phase_Space(i,:)-Phase_Space(j,:));
           Index = j; % closest point!
       end
   end
   expn = 0.0; % estimate local rate of ePhase_Spacepansion (i.e. largest eigenvalue)
   for k=1:5
       if norm(Phase_Space(i+k,:)-Phase_Space(Index+k,:))>TOL && norm(Phase_Space(i,:)-Phase_Space(Index,:))>TOL
           expn = expn + (log(norm(Phase_Space(i+k,:)-Phase_Space(Index+k,:)))-log(norm(Phase_Space(i,:)-Phase_Space(Index,:))))/k;
       end
   end
   exponent(i-N4+1)=expn/5;
end

% plot(exponent);  % plot the estimates for each initial point (fairly noisy)

sum=0;  % now, calculate the overal average over N4 data points ...
for i=1:N4+1
    sum = sum+exponent(i);
end

Lyapunov_Exponent=sum/((N4+1)*dt);  % return the average value

end
