function [ Rec ] = refer129( Rec )
% minus the referent channal 129->128
N=size(Rec,1);
Rec=Rec-repmat(Rec(N,:),N,1);
Rec(N,:)=[];
end

%function [ Rec ] = refer129( Rec )
% minus the referent channal 129->128
%N=size(Rec,1);
%for i=1:N-1
%    Rec(i,:)=Rec(i,:)-Rec(N,:);
%end
%Rec(N,:)=[];
%end

