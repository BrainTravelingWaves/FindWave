PARAM.v_wave=0.2;
PARAM.N_step=24;
PARAM.w_frequ=12;
PARAM.SR=240;
PARAM.max_dist=0.02;
PARAM.ca=0.000336725;
%%
s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/S_V1r/';
q=1010;
N=length(Scouts.Vertices);
N=fix(N/q);
%Nr=length(Scouts.Vertices)-N*q;
for j=1:N
  load(strcat(s,'dist',num2str(j),'.mat'));
  smeg=zeros(300,PARAM.N_step,q);
  parfor i=1:q 
    smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist(:,i),PARAM));
  end;
  save(strcat(s,'smeg',num2str(j)),'smeg');
end;
%% Find correlation
N=5;    % Number smeg files
load(strcat(s,'smeg1.mat'));
N1=size(smeg,3);
N2=24; % Points of smeg
N3=24; % 5 % Points of experimental MEG *****
em=m.F(:,10:14); %******
em(1,:)=0;
em(298,:)=0;
em(299,:)=0;
em(300,:)=0;
p=1;
for i=1:N
  load(strcat(s,'smeg',num2str(i),'.mat'));
  for j=1:N1 
    sm=smeg(:,:,j);
    sm(1,:)=0;
    sm(298,:)=0;
    sm(299,:)=0;
    sm(300,:)=0;
    ssm=zeros(size(smeg,1),N3);
    for k=1:N2 % Cyclic shift of simulated data
      l=k; 
      for kk=1:N3
          ssm(:,kk)=sm(:,l);
          l=l+1;
          if l>N2
              l=1;
          end;
      end;
      cc(p)=corr2(ssm,em);
      %if p==363013
       %   eem=em;
        %  ssmm=ssm;
      %end;
      p=p+1;
    end;
  end;
end;
[mx,idx]=max(cc);
%save(strcat(s,'corrRO4.mat'),'cc');