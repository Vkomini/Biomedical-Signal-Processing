clear all
close all
clc
%%
fig=200;
iteration=2000;
load SynCP
%%
T1=squeeze(T(:,:,4));
[U, S, V]=svd(T1);
U=U(:,1:3);
V=V(:,1:3);
S=S(1:3,1:3);
%%
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(T1),colorbar
set(gca,'FontSize',15);
title('Main component');
[fig]=Vangjush_Save_Images(fig);
%%
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(A),colorbar
set(gca,'FontSize',15);
title('Orthogonal component');
[fig]=Vangjush_Save_Images(fig);
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(B),colorbar
set(gca,'FontSize',15);
title('Mixing matrix');
[fig]=Vangjush_Save_Images(fig);
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(C),colorbar
set(gca,'FontSize',15);
title('Scaling matrix');
[fig]=Vangjush_Save_Images(fig);
%%
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(U),colorbar
set(gca,'FontSize',15);
title('Orthogonal component PCA');
[fig]=Vangjush_Save_Images(fig);
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(V),colorbar
set(gca,'FontSize',15);
title('Mixing matrix PCA');
[fig]=Vangjush_Save_Images(fig);
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(S),colorbar
set(gca,'FontSize',15);
title('Scaling matrix PCA');
[fig]=Vangjush_Save_Images(fig);
%%
[MM,C]=Vangjush_Fast_ICA_Final(T1');
%%
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(MM)),colorbar
set(gca,'FontSize',15);
title('Mixing matrix ICA');
[fig]=Vangjush_Save_Images(fig);
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(abs(C)),colorbar
set(gca,'FontSize',15);
title('Orthogonal component ICA');
[fig]=Vangjush_Save_Images(fig);
%%
[T_Noisy,Noise] = Vangjush_AddNoise(T,15);
%%
[~,S_Noisy]=Vangjush_MLSVD(T_Noisy);
[~,S]=Vangjush_MLSVD(T);
for i=1:4
    Nrm1(i)= norm(S_Noisy(:,:,i));
end
Nrm1=sort(Nrm1, 'descend');
figure('units','normalized','outerposition',[0 0 1 1])
plot(Nrm1,'r','LineWidth',4)
hold on,plot(Nrm1,'x','LineWidth',30)
title('Norm of MLSVD','FontSize',15);
xlabel('Ordering','FontSize',15);
ylabel('Freb norm [A.U]','FontSize',15);
set(gca,'FontSize',15)
[fig]=Vangjush_Save_Images(fig);
%%
Ending_rank=3:10;
for R=1:length(Ending_rank);
    [A,B,C]=Vangjush_CPD_ALS(T_Noisy,Ending_rank(R),iteration);
    Dimensions=size(T_Noisy);
    T1=reshape(T,Dimensions(3)*Dimensions(2),Dimensions(1))';
    ttt=A*Vangjush_K_R(C,B)';
    Norm(R)=norm((T1-ttt)) ;
end
%%
figure('units','normalized','outerposition',[0 0 1 1])
R=Ending_rank;
plot(R,Norm,'r','LineWidth',4)
hold on,plot(R,Norm,'x','LineWidth',30)
title('Rank estimation','FontSize',15);
xlabel('Rank number','FontSize',15);
ylabel('Norm [A.U]','FontSize',15);
set(gca,'FontSize',15);
[fig]=Vangjush_Save_Images(fig);
%%
%  Using tensor lab
fig=fig+1;
[U,S,sv] = mlsvd(T_Noisy);
[U_p,S_p,sv_p] = mlsvd(T);

figure('units','normalized','outerposition',[0 0 1 1])
for i=1:3
    subplot(1,3,i);
    semilogy(sv{i},'x')
    hold on
    semilogy(sv{i},'r')
    title('Frob norm of MLSVD','FontSize',15);
    xlabel('Ordering','FontSize',15);
    ylabel('Freb norm [A.U]','FontSize',15);
    set(gca,'FontSize',15)
end
[fig]=Vangjush_Save_Images(fig);

figure('units','normalized','outerposition',[0 0 1 1])
for i=1:3
    subplot(1,3,i);
    semilogy(sv_p{i},'x')
    hold on
    semilogy(sv_p{i},'r')
    title('Frob norm of MLSVD','FontSize',15);
    xlabel('Ordering','FontSize',15);
    ylabel('Freb norm [A.U]','FontSize',15);
    set(gca,'FontSize',15)
end
[fig]=Vangjush_Save_Images(fig);
%%
figure('units','normalized','outerposition',[0 0 1 1])
index=1;
MaxRank=15;
for R=3:MaxRank;
    Uhat = cpd(T_Noisy,R);
    
    options.Initialization = @cpd_rnd;              % Select pseudorandom initialization.
    options.Algorithm = @cpd_nls;                   % Select NLS as the main algorithm multiple initialization avoid local minima.
    options.AlgorithmOptions.LineSearch = @cpd_nls; % Add exact line search.
    options.AlgorithmOptions.TolFun = 1e-20;        % Set algorithm stop criteria.
    options.AlgorithmOptions.TolX = 1e-20;
    
    
    [Uhat,output] = cpd(T,R,options);
    
    semilogy(0:output.Algorithm.iterations,sqrt(2*output.Algorithm.fval),'color',rand(1,3),'LineWidth',4);
    xlabel('iteration','FontSize',15)
    ylabel('frob(cpdres(T,U))','FontSize',15)
    set(gca,'FontSize',15)
    grid on;
    hold on
    title('Norm estimation over different interation repsectively to different rank trial','FontSize',15)
    K=3:R;                                                          % Raw of different order of components
    legendCell=strcat('R=',strtrim(cellstr(num2str(K(:)))));        % Generation fo cells for the legend
    legend(legendCell)
    
    res = cpdres(T_Noisy,Uhat);
    relerr(index) = frob(cpdres(T_Noisy,Uhat))/frob(T_Noisy);
    index=index+1;
end
[fig]=Vangjush_Save_Images(fig);
