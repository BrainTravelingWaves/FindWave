function [ Rec ] = dipewave(dipe, Gain);
%% Rec
Rec=zeros(size(Gain,1),PARAM.N_step);
for i=1:size(dipe,3)
Rec(:,i)=Gain*reshape(((dipe(:,:,i)))',size(Gain,2), 1);
end