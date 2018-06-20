%Alm=precalcdist(cor_lm);
%%
%Arm=precalcdist(cor_rm);
%% Clear NaN
OpMEGsph302.Gain(isnan(OpMEGsph302.Gain)) = 0;
emeg(1,:)=0;
emeg(2,:)=0;
emeg(301,:)=0;
emeg(302,:)=0;
%% Set params
PARAM.v_wave=0.2;
PARAM.N_step=481;
PARAM.w_frequ=18;
PARAM.SR=1200;
PARAM.max_dist=0.01;
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
%scout_v=Scouts.Vertices;
N=length(scout_v);
dist=zeros(length(Alm),N);
%% 13.1 min
tic
parfor i=1:N 
   dist(:,i)=graphshortestpath(Alm,scout_v(i),'Directed', false); 
end;
toc
%% Simulation MEG and compare it with experimental data
Nparam=3;
corr_meg=zeros(length(scout_v)*Nparam,1);
smeg=zeros(size(emeg));
k=0;
for j=1:Nparam
  PARAM.v_wave=0.2*j;
  if j==3  
     PARAM.v_wave=0.4;
  end;
  PARAM.max_dist=PARAM.N_step/PARAM.SR*PARAM.v_wave;    
  tic
  parfor i=1:N 
    smeg=emeg_sim(0,OpMEGsph302,cortex_edipl0(cor_lm,dist(:,i),PARAM));
    corr_meg(k+i)=corr2(smeg,emeg);
  end;
  toc
  k=k+N
end;
%% Find max
[mx,idx]=max(corr_meg); 
j=mod(idx,length(scout_v))+1; % Params index
ix=rem(idx,length(scout_v));  % Epiceter index
v=scout_v(ix)                 % Epiceter 
% Set params
PARAM.v_wave=0.1*j;
PARAM.max_dist=PARAM.N_step/PARAM.SR*PARAM.v_wave;
distv=graphshortestpath(Alm,v,'Directed', false);
dipoles=cortex_edipl0(cor_lm,distv,PARAM);
smeg=emeg_sim(0,OpMEGsph302,dipoles);
%% Counting timing
i=1;
tic
dist(:,i)=graphshortestpath(Alm,scout_v(i),'Directed', false);
toc
%%
tic
i=1;
%[dist,path,pred]=graphshortestpath(Alm,scout_v(i),'Directed', false);
ElemDip=cortex_edipl0(cor_lm,dist,PARAM);
smeg=emeg_sim(0,OpMEGsph302,ElemDip);
toc
%% Load resultation for show
m.F=smeg;
m.Time=[];
for i=1:PARAM.N_step
   m.Time(i)=(i-1)*1/PARAM.SR; 
end;  
%% Load experemental MEG
N=68;
e_data=m;
e_data.F=zeros(length(e_data.ChannelFlag),N);
t=e_data.Time;
e_data.Time=zeros(N);
emeg=m.F;
emeg(1,:)=0;
emeg(2,:)=0;
emeg(301,:)=0;
emeg(302,:)=0;
j=1;
for i=1:length(t)  
  if t(i)>=0.023 
      if j<N
         e_data.F(:,j)=emeg(:,i);
         e_data.Time(j)=t(i);
         j=j+1;
      end;
  end;
end;
e_data.Comment='Experimental MEG for compare';
%%
dist58434=graphshortestpath(Alm,58434,'Directed', false);
%%
smeg58434=emeg_sim(0,OpMEGsph302,cortex_edipl0(cor_lm,dist58434,PARAM));
%% Load simulation
s_meg=zeros(length(m.ChannelFlag),length(m.Time));
for i=153:153+66 s_meg(:,i)=smeg(:,i-27); end;
m.F=smeg62078*0.0000000004;
%%
m.F=smeg*PARAM.ca
m.Comment='s_megV0.2D0.01F18HzE59660';