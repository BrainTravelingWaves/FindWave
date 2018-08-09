function [matFile] = nsi2mat(nsiFile,Ne)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a=dlmread(nsiFile,'\t',5,0);
coords=a(1:Ne,3:end); % Ne 128 or 129(referent)
coords=coords/100;
c(:,1)=coords(:,1)*-1;
coords(:,1)=coords(:,2);
coords(:,2)=c(:,1);
coords(:,3)=coords(:,3)+0.038;
matFile=struct();
matFile.Comment='GSN Hydro Net';
matFile.MegRegCoef=[];
matFile.Projector=struct();
matFile.TransfMeg=[];
matFile.TransfMegLabels=[];
matFile.TransfEeg=[];
matFile.TransfEegLabels=[];
matFile.HeadPoints=[];
matFile.Channel=struct();
for i=1:size(coords,1)
    matFile.Channel(i).Loc=coords(i,:)';
    matFile.Channel(i).Orient=[];
    matFile.Channel(i).Comment='';
    matFile.Channel(i).Weight=1;
    matFile.Channel(i).Type='EEG';
    matFile.Channel(i).Name=strcat('E',num2str(i));
    matFile.Channel(i).Group=[];
end
matFile.History={};
matFile.SCS=struct();
end

