clear all
close all
clc
%%
load ECGdata
fs = 2;
T=6;                         % Duration in hours of the signal [Hours]
Fre_Thre1=10^(-4);           % First threshold frequency
Fre_Thre2=10^(-2);           % First threshold frequency

threshold1=[4,16];
threshold2=[16,64];
str1='Control';
str2='West';
threshold3=16;
threshold4=64;
scale=0.1;
dim=3;
fig=120;
File=sprintf('.jpg');
%%
for i=1:5
    Signal=eval([str1 num2str(i)]);
    figure
    time_course=linspace(0,(1/fs)*length(Signal)-1,length(Signal));
    plot(time_course,Signal,'r','LineWidth',3)
    t=strcat(num2str(str1),num2str(i),' time course');
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('Heart beat [cycle]','FontSize',20)
    ylabel('RR interval [microSec]','FontSize',20)
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    Signal=eval([str2 num2str(i)]);
    figure
    time_course=linspace(0,(1/fs)*length(Signal)-1,length(Signal));
    plot(time_course,Signal,'r','LineWidth',3)
    t=strcat(num2str(str2),num2str(i),' time course');
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('Heart beat [cycle]','FontSize',20)
    ylabel('RR interval [microSec]','FontSize',20)
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
end
%%
close all
for i=1:5
    Signal=eval([str1 num2str(i)]);
    [Control.X{i},Control.Y{i}]=Vangjush_Poincare(Signal);
    X=Control.X{i};
    Y=Control.Y{i};
    t=strcat(str1,num2str(i),' Poincare');
    figure,plot(X,Y,'x','MarkerSize',10)
    xlabel('RR_n','FontSize',20)
    ylabel('RR_n+1','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    Signal=eval([str2 num2str(i)]);
    [Control.X{i},Control.Y{i}]=Vangjush_Poincare(Signal);
    X=Control.X{i};
    Y=Control.Y{i};
    t=strcat(str2,num2str(i),' Poincare');
    figure,plot(X,Y,'x','MarkerSize',10)
    xlabel('RR_n','FontSize',20)
    ylabel('RR_n+1','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
end
close all
%%
% myCluster = parcluster('local');
% myCluster.NumWorkers = 4;  % 'Modified' property now TRUE7
% saveProfile(myCluster);    % 'local' profile now updated
%%
ind=1;
for i=1:5
    Signal=eval([str1 num2str(i)]);
    Control.ACF{ind} = Vangjush_ACF(Signal,length(Signal)-1);
    ACF=Control.ACF{i};
    t=strcat(str1,num2str(i),' ACF');
    figure,plot(ACF,'LineWidth',3)
    ylabel('[A.U]','FontSize',20)
    xlabel('Time sample','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    ind=ind+1;
    Signal=eval([str2 num2str(i)]);
    Control.ACF{ind} = Vangjush_ACF(Signal,length(Signal)-1);
    ACF=Control.ACF{i};
    t=strcat(str2,num2str(i),' ACF');
    figure,plot(ACF,'LineWidth',3)
    ylabel('[A.U]','FontSize',20)
    xlabel('Time sample','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    ind=ind+1;
end
close all
dim=3;
%%
% fig=144;
index11=1;
index12=1;
for i=1:10
    if rem(i,2)==1
        t=strcat(str1,num2str(index11),' Phase space');
        Signal=eval([str1 num2str(index11)]);
        index11=index11+1;
    else
        t=strcat(str2,num2str(index12),' Phase space');
        Signal=eval([str2 num2str(index12)]);
        index12=index12+1;
    end
    
    Control.ACF{i} = Vangjush_ACF(Signal,length(Signal)-1);
    [pos]=Vangjush_First_Zero(Control.ACF{i});
    %%
    Control.Vectors{i}=Vangjush_Phase_Space_Reconstrucion(Signal,dim,pos);
    Phase_space=Control.Vectors{i};
    figure,plot3(Phase_space(:,1),Phase_space(:,2),Phase_space(:,3),'LineWidth',0.5)
    xlabel('First dimension','FontSize',20)
    ylabel('Second Dimension','FontSize',20)
    zlabel('Third dimension','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    
end
clear index11;
clear index12;
close all
%%
% fig=152;
for i=1:5
    Signal=eval([str1 num2str(i)]);
    [Control.Fitt{i},Control.Alpha{i},Control.Beta{i},Control.Pxx{i},Control.FrequencySpectrum{i},Control.LogFreq{i},Control.LogSpectrum{i}]=Vangjush_F_slope(Signal,T,Fre_Thre1,Fre_Thre2);
    LogFreq=Control.LogFreq{i};
    LogSpectrum=Control.LogSpectrum{i};
    Fitt=Control.Fitt{i};
    figure,plot(LogFreq,LogSpectrum,'LineWidth',3)
    hold on
    plot(LogFreq,Fitt,'r','LineWidth',3)
    %     if rem(i,2)==1
    t=strcat(str1,num2str(i),' F-Slope');
    %     else
    %         t=strcat(str2,num2str(i),' F-Slope');
    %     end
    %         t=strcat(str1,num2str(i),' F-Slope');
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('Frequency in Hz','FontSize',20)
    ylabel('Spectrum value','FontSize',20)
    legend('PSD real value','F slope')
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    
    Signal=eval([str2 num2str(i)]);
    [Control.Fitt{i},Control.Alpha{i},Control.Beta{i},Control.Pxx{i},Control.FrequencySpectrum{i},Control.LogFreq{i},Control.LogSpectrum{i}]=Vangjush_F_slope(Signal,T,Fre_Thre1,Fre_Thre2);
    LogFreq=Control.LogFreq{i};
    LogSpectrum=Control.LogSpectrum{i};
    Fitt=Control.Fitt{i};
    figure,plot(LogFreq,LogSpectrum,'LineWidth',3)
    hold on
    plot(LogFreq,Fitt,'r','LineWidth',3)
    %     if rem(i,2)==1
    %         t=strcat(str1,num2str(i),' F-Slope');
    %     else
    t=strcat(str2,num2str(i),' F-Slope');
    %     end
    %         t=strcat(str1,num2str(i),' F-Slope');
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('Frequency in Hz','FontSize',20)
    ylabel('Spectrum value','FontSize',20)
    legend('PSD real value','F slope')
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
end
%%
close all
for i=1:5
    Signal=eval([str1 num2str(i)]);
    [Control.Rescaled_Range_Series{i}]=Vangjush_Hurst_Exponential(Signal);
    Hurst_Expo=Control.Rescaled_Range_Series{i};
    figure,loglog(Hurst_Expo,'LineWidth',3)
    t=strcat(str1,num2str(i),' Hurst Exponential');
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('log2(t)','FontSize',20)
    ylabel('log2(R/S)','FontSize',20)
    
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    
    %%
    Signal=eval([str2 num2str(i)]);
    [Control.Rescaled_Range_Series{i}]=Vangjush_Hurst_Exponential(Signal);
    Hurst_Expo=Control.Rescaled_Range_Series{i};
    figure,loglog(Hurst_Expo,'LineWidth',3)
    t=strcat(str2,num2str(i),' Hurst Exponential');
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('log2(t)','FontSize',20)
    ylabel('log2(R/S)','FontSize',20)
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
end

%%
close all
% fig=168;
for i=1:5
    Signal=eval([str1 num2str(i)]);
    [Control.Box_Counter{i},Control.Box_Size{i},Control.FractialDimension{i}] = Vangjush_Box_Counting(Signal);
    X=Control.Box_Counter{i};
    Y=Control.Box_Size{i};
    t=strcat(str1,num2str(i),' Box counter');
    figure,plot(X,Y,'LineWidth',3)
    xlabel('Box scale','FontSize',20)
    ylabel('Box counted','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    
    %%
    Signal=eval([str2 num2str(i)]);
    [Control.Box_Counter{i},Control.Box_Size{i},Control.FractialDimension{i}] = Vangjush_Box_Counting(Signal);
    X=Control.Box_Counter{i};
    Y=Control.Box_Size{i};
    t=strcat(str2,num2str(i),' Box counter');
    figure,plot(X,Y,'LineWidth',3)
    xlabel('Box scale','FontSize',20)
    ylabel('Box counted','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
end

%%
% fig=177;
close all
for j=1:2
    figure
    clear F
    clear X
    clear t
    for i=1:5
        Signal=eval([str1 num2str(i)]);
        [Control.F1{j},Control.Yn1{j},Control.x1{(j-1)*5+i},DFA_STEP]=Vangjush_DFA(Signal,threshold1(j),threshold2(j));
        %% DFA
        F(i,:)=Control.F1{j};
        X(i,:)=(threshold1(j):threshold2(j));
        t(i,:)=strcat(str1,num2str(i));
    end
    plot(log(X'),log(F'),'LineWidth',3)
    title('DFA','FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('Window size','FontSize',20)
    ylabel('RMS Fluctuation','FontSize',20)
    legend(t,'Location','NorthWest' )
    hold on
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    figure
    clear F
    clear X
    clear t
    for i=1:5
        Signal=eval([str2 num2str(i)]);
        [Control.F1{j},Control.Yn1{j},Control.x11{(j-1)*5+i},~]=Vangjush_DFA(Signal,threshold1(j),threshold2(j));
        %% DFA
        F(i,:)=Control.F1{j};
        X(i,:)=(threshold1(j):threshold2(j));
        t(i,:)=strcat(str2,num2str(i));
    end
    plot(log(X'),log(F'),'LineWidth',3)
    title('DFA','FontSize',20)
    set(gca,'fontsize', 20);
    xlabel('Window size','FontSize',20)
    ylabel('RMS Fluctuation','FontSize',20)
    legend(t,'Location','NorthWest' )
    hold on
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
end

%%
% fig=191;
close all
for i=1:5
    X=Control.x1{i};
    t=strcat(str1,num2str(i),' Cumulative plot');
    figure,plot(X,'LineWidth',3)
    xlabel('Time seris','FontSize',20)
    ylabel('Cumulative value [A.U]','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    X=Control.x1{i+5};
    t=strcat(str2,num2str(i),' Cumulative plot');
    figure,plot(X,'LineWidth',3)
    xlabel('Time seris','FontSize',20)
    ylabel('Cumulative value [A.U]','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    clear X
    clear t
end
%%
%%
fig=204;
close all
for i=1:5
    %%
    Signal=eval([str1 num2str(i)]);
    Control.ACF{i} = Vangjush_ACF(Signal,length(Signal)-1);
    [pos]=Vangjush_First_Zero(Control.ACF{i});
    Control.Vectors{i}=Vangjush_Phase_Space_Reconstrucion(Signal,dim,pos);
    Vectors=Control.Vectors{i};
    [Control.Value{i},Control.Value1{i},Control.r{i}]=Vangjush_Grassberger_Procaccia_Gaussian_Kernel(Vectors);
    %%
    Y1=Control.Value1{i};
    X=Control.r{i};
    t=strcat(str1,num2str(i),' CD Gaussian Kernel');
    figure,plot(log10(X),log10(Y1),'LineWidth',3)
    ylabel('[A.U]','FontSize',20)
    xlabel('Time sample','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    Y1=Control.Value{i};
    Y2=Control.Value1{i};
    X=Control.r{i};
    t=strcat(str1,num2str(i),' CD Grassberger Procaccia');
    figure,plot(log10(X),log10(Y1),'LineWidth',3)
    ylabel('[A.U]','FontSize',20)
    xlabel('Time sample','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    %     Signal=eval([str2 num2str(i)]);
    %     Control.Vectors{i}=Vangjush_Phase_Space_Reconstrucion(Signal,dim,pos);
    %     Vectors=Control.Vectors{i};
    %     [Control.Value{i},Control.Value1{i},Control.r{i}]=Vangjush_Grassberger_Procaccia_Gaussian_Kernel(Vectors);
end
%%

close all
for i=1:5
    %%
    Signal=eval([str2 num2str(i)]);
    Control.ACF{i} = Vangjush_ACF(Signal,length(Signal)-1);
    [pos]=Vangjush_First_Zero(Control.ACF{i});
    Control.Vectors{i}=Vangjush_Phase_Space_Reconstrucion(Signal,dim,pos);
    Vectors=Control.Vectors{i};
    [Control.Value{i},Control.Value1{i},Control.r{i}]=Vangjush_Grassberger_Procaccia_Gaussian_Kernel(Vectors);
    %%
    Y1=Control.Value1{i};
    X=Control.r{i};
    t=strcat(str2,num2str(i),' CD Gaussian Kernel');
    figure,plot(log10(X),log10(Y1),'LineWidth',3)
    ylabel('[A.U]','FontSize',20)
    xlabel('Time sample','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    Y1=Control.Value{i};
    Y2=Control.Value1{i};
    X=Control.r{i};
    t=strcat(str2,num2str(i),' CD Grassberger Procaccia');
    figure,plot(log10(X),log10(Y1),'LineWidth',3)
    ylabel('[A.U]','FontSize',20)
    xlabel('Time sample','FontSize',20)
    title(t,'FontSize',20)
    set(gca,'fontsize', 20);
    [fig]=Vangjush_Save_Images(fig);
    Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
    %saveas(gcf,Name)
    %%
    
end
%%

%%
% fig=223;
close all
clear t
for j=2:2
    for i=1:5
        figure
        Signal=eval([str1 num2str(i)]);
        [~,~,Control.x1{i},DFA_STEP{i}]=Vangjush_DFA(Signal,threshold1(j),threshold2(j));
        t=strcat('Linear regression n=16  ',str1,num2str(i));
        
        plot(Control.x1{i},'x','LineWidth',4)
        hold on
        plot(DFA_STEP{i},'r','LineWidth',1)
        title(t,'FontSize',20)
        set(gca,'fontsize', 20);
        set(gca,'fontsize', 20);
        xlabel('Time seris','FontSize',20)
        ylabel('Cumulative value [A.U]','FontSize',20)
        xlim([0 200])
        %     legend(t,'Location','NorthWest' )
        %         hold on
        [fig]=Vangjush_Save_Images(fig);
        Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
        %saveas(gcf,Name)
        %     end
        %%
        %     figure
        clear t
        %     for i=1:5
        figure
        Signal=eval([str2 num2str(i)]);
        [~,~,Control.x11{i},DFA_STEP1{i}]=Vangjush_DFA(Signal,threshold1(j),threshold2(j));
        t1=strcat('Linear regression n=16  ',str2,num2str(i));
        
        plot(Control.x11{i},'x','LineWidth',4)
        hold on
        plot(DFA_STEP1{i},'r','LineWidth',1)
        title(t1,'FontSize',20)
        set(gca,'fontsize', 20);
        xlabel('Time seris','FontSize',20)
        ylabel('Cumulative value [A.U]','FontSize',20)
        xlim([0 200])
        %     legend(t,'Location','NorthWest' )
        %         hold on
        [fig]=Vangjush_Save_Images(fig);
        Name=strcat('C:\Users\vkomin1\Dropbox\Apps\ShareLaTeX\Katholieke university of Leuven\Bio-Medical Data Processing part II\A2\Images2\',num2str(fig),File);
        %saveas(gcf,Name)
    end
end
