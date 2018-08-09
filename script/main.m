%% Set params
PARAM.v_wave=0.2;
PARAM.N_step=5;
PARAM.w_frequ=10;
PARAM.SR=240;
PARAM.max_dist=0.01;
%% Load experemental MEG
N=PARAM.N_step;
T=89.8;
e_data=m;
e_data.F=zeros(length(e_data.ChannelFlag),N);
t=e_data.Time;
e_data.Time=zeros(1,N);
emeg=m.F;
emeg(1,:)=0;
emeg(298,:)=0;
emeg(299,:)=0;
emeg(300,:)=0;
j=1;
for i=1:length(t)  
  if t(i)>=T 
      if j<=N
         e_data.F(:,j)=emeg(:,i);
         e_data.Time(1,j)=t(i);
         j=j+1;
      end;
  end;
end;
e_data.Comment='ExperimSpontMEG89.8_';
%% Create precalc matrix
%aR=precalcdist(corR);
aL=precalcdist(cL);
%% Calculate distances
tic
parfor i=1:length(scout_v) 
   dist(:,i)=graphshortestpath(aR,scout_v(i)-(306645-153616),'Directed',false); 
end;
toc
%% Save dist scout V1
q=1010;
dist1=dist(:,q*0+1:q*1);
save('d1.mat','dist1');
dist2=dist(:,q*1+1:q*2);
save('d2.mat','dist2');
dist3=dist(:,q*2+1:q*3);
save('d3.mat','dist3');
dist4=dist(:,q*3+1:q*4);
save('d4.mat','dist4');
dist5=dist(:,q*4+1:q*5);
save('d5.mat','dist5');
%% Save dist scout 1
q=1250;
dist1=dist(:,q*0+1:q*1);
save('d1.mat','dist1');
dist2=dist(:,q*1+1:q*2);
save('d2.mat','dist2');
dist3=dist(:,q*2+1:q*3);
save('d3.mat','dist3');
dist4=dist(:,q*3+1:q*4);
save('d4.mat','dist4');
dist5=dist(:,q*4+1:q*5);
save('d5.mat','dist5');
dist6=dist(:,q*5+1:q*6);
save('d6.mat','dist6');
dist7=dist(:,q*6+1:q*7);
save('d7.mat','dist7');
dist8=dist(:,q*7+1:q*8+59);
save('d8.mat','dist8');
%% Test of simulation MEG
tic
e_data.F=zeros(length(e_data.ChannelFlag),N);
parfor i=1:q
  edip=cortex_edipl0(corR,dist(:,1),PARAM);
end;  
toc
%%
tic
  smeg=emeg_sim(306645-153616,OpMEG300s2,edip);
  smeg(1,:)=0;
  smeg(298,:)=0;
  smeg(299,:)=0;
  smeg(300,:)=0;
toc
%% Matrix Assembly
%q=size(dist1,2);
G=zeros(300,919935);
G(1:150,:)=G1;
G(151:300,:)=G2;
OpMEG300s2.Gain=G;
OpMEG300s2.GridLoc=Gl;
%% Create smeg
smeg=zeros(300,24,q); %length(scouts_v));
%% Simulation MEG 4 sec*Nepicetrs 73.5 min
tic
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist1(:,i),PARAM));
end;
toc 
%% Clear NaN
smeg(1,:,:)=0;
smeg(298,:,:)=0;
smeg(299,:,:)=0;
smeg(300,:,:)=0;
%% Clear experimental MEG 
em=mm.F;
em(1,:)=0;
em(298,:)=0;
em(299,:)=0;
em(300,:)=0;
%% Find correlation
N=size(em,2);      % Experimental array size
N3=size(smeg,3);   % Number vertexes
%N2=size(smeg,2);  % Points of simulated data
cc=zeros(N3,N);
for i=1:N3
   sm=smeg(:,:,i);
   ssm=zeros(size(smeg,1),N);
   for j=1:N % Cyclic shift of simulated data
      l=j; 
      for k=1:N
          ssm(:,k)=sm(:,l);
          l=l+1;
          if l>N
              l=1;
          end;
      end;
      cc(i,j)=corr2(ssm,em);
   end;
end;
%% Find indexis
[mx,idx]=max(max(cc'));
[mx,ilx]=max(cc(idx,:));
%% Load dipole dinamic (right)
amp=cor_cos_amp(graphshortestpath(aR,idx,'Directed',false),PARAM);
%% Load the shifted data of simulation
cori=306645-153616; % right cori=0; %left
sm=smeg(:,:,idx);
ssm=zeros(size(smeg,1),N); % Signal
asm=zeros(size(amp,1),N);  % Current Density
l=ilx; 
for k=1:N
  ssm(:,k)=sm(:,l);
  asm(:,k)=amp(:,l);
  l=l+1;
  if l>N
   l=1;
  end;
end;
img_cor.ImageGridAmp=zeros(size(img_cor.ImageGridAmp,1),N);
for i=1:size(amp,1)
    img_cor.ImageGridAmp(i+cori,:)=asm(i,:)*600;
end;
img_cor.Time=m.Time;
img_cor.Comment='Simulation TW 10Hz v0.2 78.8';
m.F=ssm*250000;
m.Comment=img_cor.Comment;