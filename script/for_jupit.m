PARAM.v_wave=0.2;
PARAM.N_step=48;
PARAM.w_frequ=11.5;
PARAM.SR=480;
PARAM.max_dist=0.02;
PARAM.ca=0.000336725;
%% Assemb Gain matrix
G=zeros(330,803727);
G(1:165,:)=G1;
G(166:330,:)=G2;
Sph267s4.Gain=G;
Sph267s4.GridLoc=Gl;
%%
s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/Sub4/V1/';
q=1000;
N=length(scout_v);
N1=fix(N/q);
N=1;
for j=1:N
  load(strcat(s,'dist',num2str(j),'.mat'));
  smeg=zeros(330,PARAM.N_step,q);
  parfor i=1:q 
    smeg(:,:,i)=emeg_sim(0,Sph267s4,cortex_edipl0(corL,dist(:,i),PARAM));
  end;
  save(strcat(s,'smeg',num2str(j)),'smeg');
end;