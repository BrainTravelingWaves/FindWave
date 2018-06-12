%Alm=precalcdist(cor_lm);
%%
%Arm=precalcdist(cor_rm);
%% Set params
PARAM.v_wave=0.4;
PARAM.N_step=35;
PARAM.w_frequ=18;
PARAM.SR=1200;
PARAM.max_dist=PARAM.N_step/PARAM.SR*PARAM.v_wave;
%% Load experemental MEG
emeg=zeros(length(m.ChannelFlag),PARAM.N_step);
for i=1:length(m.Time)
  if m.Time(i)<=0.035 
      t_plus=i;
  end;
end;
for i=1:PARAM.N_step
emeg(:,i)=m.F(:,i+t_plus);
end;
%% Geodesic
scout_v=Scouts.Vertices; tic
dist=zeros(length(Alm),length(scout_v)); 
parfor i=1:length(scout_v) 
dist(:,i)=graphshortestpath(Alm,scout_v(i),'Directed', false); 
end; toc
%% Simulation MEG and compare it with experimental data
Nparam=4;
corr_meg=zeros(length(scout_v)*Nparam,1);
k=0;
for j=1:Nparam
PARAM.v_wave=0.1*j;
PARAM.max_dist=PARAM.N_step/PARAM.SR*PARAM.v_wave;    
%tic
parfor i=1:length(scout_v) 
%ElemDip=cortex_edipl0(cor_lm,dist(i,:),PARAM);
smeg=emeg_sim(0,OpMEGsph302,cortex_edipl0(cor_lm,dist(:,i),PARAM));
corr_meg(k+i)=corr2(smeg,emeg);
end;
%toc
k=i;
end;
%% Counting timing
tic
i=1;
[dist,path,pred]=graphshortestpath(Alm,scout_v(i),'Directed', false);
ElemDip=cortex_edipl0(cor_lm,dist,PARAM);
smeg=emeg_sim(0,OpMEGsph302,ElemDip);
toc
%% Load resultation for show
m.F=smeg;
m.Time=[];
for i=1:PARAM.N_step
   m.Time(i)=(i-1)*1/PARAM.SR; 
end;  
%save(strcat('smeg',currFile(1:end),num2str(j)),'smeg');