function [SDR,SIR,SAR]=Vangjush_Best_Ordering(Source_Numbers,SDR,SIR,SAR)
%%
perm=perms(1:Source_Numbers);
nperm=size(perm,1);
meanSIR=zeros(nperm,1);
for p=1:nperm,
    meanSIR(p)=mean(SIR((0:Source_Numbers-1)*Source_Numbers+perm(p,:)));
end
[~,popt]=max(meanSIR);
perm=perm(popt,:).';
SDR=SDR((0:Source_Numbers-1).'*Source_Numbers+perm);
SIR=SIR((0:Source_Numbers-1).'*Source_Numbers+perm);
SAR=SAR((0:Source_Numbers-1).'*Source_Numbers+perm);
end