PARAM.v_wave=0.2;
PARAM.N_step=24;
PARAM.w_frequ=10;
PARAM.SR=240;
PARAM.max_dist=0.01;
PARAM.ca=0.000336725;
%%
s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/RO4/';
q=1010;
N=length(Scouts.Vertices);
N=fix(N/q);
Nr=length(Scouts.Vertices)-N*q;
for j=1:N
  load(strcat(s,'dist',num2str(j),'.mat'));
  smeg=zeros(300,PARAM.N_step,q);
  parfor i=1:q 
    smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist(:,i),PARAM));
  end;
  save(strcat(s,'smeg',num2str(j)),'smeg');
end;
j=j+1;
load(strcat(s,'dist',num2str(j),'.mat'));
smeg=zeros(300,PARAM.N_step,Nr);
parfor i=1:Nr 
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist(:,i),PARAM));
end;
save(strcat(s,'smeg',num2str(j)),'smeg');