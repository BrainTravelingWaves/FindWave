function [ newDip ] = DipBsDip( dip, bstDip, time)
newDip=bstDip;
for i=1:size(dip.loc,1)
   newDip.Dipole(i).Loc=dip.loc(i,:)';
   newDip.Dipole(i).Amplitude=dip.amp(i,:)';
   newDip.Dipole(i).Time=time(i);
end   
newDip.Time=time;
end