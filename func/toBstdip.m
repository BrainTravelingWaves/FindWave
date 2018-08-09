function [ bstDip ] = toBstdip( dip, name, SR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
bstDip.Comment=name;
for i=1:length(dip)
    bstDip.Dipole(i).Index=i;
    bstDip.Dipole(i).Time=1/SR*i;
    bstDip.Dipole(i).Loc=dip.loc(i,:);
    bstDip.Dipole(i).Amplitude=dip.amp(i,:);
    bstDip.Dipole(i).Origin=[0 0 0];
    bstDip.Dipole(i).Errors=0;
    bstDip.Dipole(i).Goodness=[];
    bstDip.Dipole(i).Errors=0;
    bstDip.Dipole(i).Noise=[];
    bstDip.Dipole(i).SingleError=[];
    bstDip.Dipole(i).ErrorMatrix=[];
    bstDip.Dipole(i).ConfVol=[];
    bstDip.Dipole(i).Khi2=[];
    bstDip.Dipole(i).DOF=[];
    bstDip.Dipole(i).Probability=[];
    bstDip.Dipole(i).NoiseEstimate=[];
    bstDip.Dipole(i).Perform=[];
end
bstDip.Time=1/SR*(0:1/SR:size(dip.loc,1)/SR);
bstDip.DataFile='';
bstDip.DipoleNames={'sim'};
end

