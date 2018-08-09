function [  ] = plot_eeg_traj2( cap,eeg,nums )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
markers={'+','o','*','.','x','s','d','^','v','>','<','p','h'};
if strcmp(nums,'');
    for i=1:length(cap.Channel)
        nums=strcat(nums,num2str(i),',');
    end
    nums(end)=[];
end
labels=strsplit(nums,',');
C=[];
Cs=[];
E=[];
for i=1:length(labels)
    labels{i}=strcat('E',labels{i});
end
for i=1:128
if sum(strcmp(labels,cap.Channel(i).Name))>0
    Cs=cat(2,Cs,cap.Channel(i).Loc);
end
    C=cat(2,C,cap.Channel(i).Loc);
    E=cat(1,E,eeg(i,:,:));
end

x1=0:pi/180:pi;
x2=pi:pi/180:2*pi;
y1=90*cos(x1)/1000;
y2=90*cos(x2)/1000;
z2=100*sin(x2)/1000;
z1=120*sin(x1)/1000;
Cxy=C(1:2,:)';
for k=1:size(E,3)
for i=1:size(E,2)
idx=E(:,i,k)>0;
Xc(i,k)=sum(E(idx,i,k).*Cxy(idx,1))/sum(E(idx,i,k));
Yc(i,k)=sum(E(idx,i,k).*Cxy(idx,2))/sum(E(idx,i,k));
idx=E(:,i,k)<0;
XcN(i,k)=sum(E(idx,i,k)*(-1).*Cxy(idx,1))/sum(E(idx,i,k)*(-1))
YcN(i,k)=sum(E(idx,i,k)*(-1).*Cxy(idx,2))/sum(E(idx,i,k)*(-1))
end
end
figure();
hold on;
plot(y1,z1,'-b');
plot(y2,z2,'-b');
for i=1:size(Cs,2);
scatter(Cs(2,i),Cs(1,i));
end
for k=1:size(E,3)
    cr=rand(1,3);
    mr=randi(13);
     plot(Yc(1,k),Xc(1,k),'color',cr,'marker',markers{mr},'MarkerSize',10)
     plot(Yc(1:end,k),Xc(1:end,k),'-','color',cr,'LineWidth',2);
     plot(Yc(end,k),Xc(end,k),'color',cr,'marker',markers{mr},'MarkerSize',10)
    plot(YcN(1,k),XcN(1,k),'color',cr,'marker',markers{mr},'MarkerSize',10)
    plot(YcN(1:end,k),XcN(1:end,k),'--','color',cr,'LineWidth',2);
    plot(YcN(end,k),XcN(end,k),'color',cr,'marker',markers{mr},'MarkerSize',10)
end
hold off;
end

