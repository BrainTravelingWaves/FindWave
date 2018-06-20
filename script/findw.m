% Find corralation
em=emeg.F;
N=size(em,2);      % Experimental array size
N3=size(smeg,3);   % Scout vertexes
N2=size(smeg,2);   % Points of simulated data
cc=zeros(N3,N);
for i=1:N3
   sm=smeg(:,:,i);
   ssm=zeros(size(smeg,1),N);
   for j=1:N2 % Cyclic shift of simulated data
      l=j; 
      for k=1:N
          ssm(:,k)=sm(:,l);
          l=l+1;
          if l>N2
              l=1;
          end;
      end;
      cc(i,j)=corr2(ssm,em);
   end;
end;
%% Find indexis
[mx,idx]=max(max(cc'));
[mx,ilx]=max(cc(idx,:));
%% Load dipole dinamic
amp=cor_cos_amp(graphshortestpath(Alm,scout_v(idx),'Directed',false),PARAM);
%% Load the shifted data of simulation
sm=smeg(:,:,idx);
ssm=zeros(size(smeg,1),N); % Signal
asm=zeros(size(amp,1),N);  % Current Density
l=ilx; 
for k=1:N
  ssm(:,k)=sm(:,l);
  asm(:,k)=amp(:,l);
  l=l+1;
  if l>N2
   l=1;
  end;
end;
img_cor.ImageGridAmp=zeros(size(img_cor.ImageGridAmp,1),N);
for i=1:size(amp,1)
    img_cor.ImageGridAmp(i,:)=asm(i,:);
end;
img_cor.Time=emeg.Time;
img_cor.Comment='Simulation traveling wave';