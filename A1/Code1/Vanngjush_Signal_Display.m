function Vanngjush_Signal_Display(t,yR,K)
%%
figure,plot(t,real((yR)));                              
ylabel('Amplitude (a.u.)','FontSize',12);
legendCell=strcat('N=',strtrim(cellstr(num2str(K(:)))));
legend(legendCell);
end