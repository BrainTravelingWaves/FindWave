%% Geodesic
scout_v=Scouts.Vertices;
N=length(scout_v);
dist=zeros(length(Alm),N);
%% 53 sec
tic
parfor i=1:N 
   dist(:,i)=graphshortestpath(Alm,scout_v(i),'Directed', false); 
end;
toc
%% MEG simulation 15 sec 1 smeg  356s=5.9 m
smeg=zeros(302,PARAM.N_step,N);
tic 
parfor i=1:N 
   smeg(:,:,i)=emeg_sim(0,OpMEGsph302,cortex_edipl0(cor_lm,dist(:,i),PARAM));
end;
toc