%% Find correlation
N=9; %16;    % Number smeg files
s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/S_V2r/';
load(strcat(s,'smeg1.mat'));
N1=size(smeg,3);
% load(strcat(s,'smeg16.mat'));
% Ne=size(smeg,3);
% cc=zeros(N*N1+Ne,1);
N2=24; % Points of smeg
N3=5; % Points of experimental MEG *****
em=m.F(:,10:14); %******
em(1,:)=0;
em(298,:)=0;
em(299,:)=0;
em(300,:)=0;
p=1;
for i=1:N
  load(strcat(s,'smeg',num2str(i),'.mat'));
  if i==16
      N1=Ne;
  end;
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
      if p==226289
       eem=em;
       ssmm=ssm;                        
      end;
      p=p+1;
    end;
  end;
end;
[mx,idx]=max(cc);
%save(strcat(s,'corrRO4.mat'),'cc');