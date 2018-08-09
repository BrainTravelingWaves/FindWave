function [  ] = plot_eeg_traj( cap,nums,eeg )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
labels=strsplit(nums,',');
C=[];
E=[];
for i=1:length(labels)
    labels{i}=strcat('E',labels{i});
end
for i=1:128
if sum(strcmp(labels,cap.Channel(i).Name))>0
    C=cat(2,C,cap.Channel(i).Loc);
    E=cat(1,E,eeg(i,:));
end
end

x1=pi/180:pi/180:pi;
x2=pi+pi/180:pi/180:2*pi;
y1=90*cos(x1)/1000;
y2=90*cos(x2)/1000;
z2=100*sin(x2)/1000;
z1=120*sin(x1)/1000;
Cxy=C(1:2,:)';
for i=1:size(E,2)
idx=E(:,i)>0;
Xc(i)=sum(E(idx,i).*Cxy(idx,1))/sum(E(idx,i));
Yc(i)=sum(E(idx,i).*Cxy(idx,2))/sum(E(idx,i));
end
figure();
hold on;
plot(y1,z1);
plot(y2,z2);
for i=1:size(C,2);
scatter(C(2,i),C(1,i));
end
plot(Yc,Xc,'-r');
hold off;
end