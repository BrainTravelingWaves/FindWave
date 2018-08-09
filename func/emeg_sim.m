function [ emeg ] = emeg_sim(firstVertex, BEM, ElemDip) % EEG or MEG simulation
N_step=size(ElemDip,3);
Edip=zeros(size(BEM.GridLoc,1),3,N_step);
for i=1:size(ElemDip,1)
   Edip(i+firstVertex,:,:)=ElemDip(i,:,:);
end
emeg=zeros(size(BEM.Gain,1),N_step);
for i=1:size(Edip,3)
    emeg(:,i)=BEM.Gain*reshape(((Edip(:,:,i)))',size(BEM.Gain,2), 1);
end
end
% emeg = emegsim( BEM, ElemDip, PARAM);