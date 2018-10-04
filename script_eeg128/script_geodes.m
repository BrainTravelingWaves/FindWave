%% Geodesic distaces Left hem
Acl=precalcdist(Bl); % Bl - CortexLeft
N=length(Acl);
NNN=2000;
NN=round(N/NNN);
N=rem(N,NNN);
dis=zeros(length(Acl),NNN);
for j=1:NN
  parfor i=1:NNN 
     dis(:,i)=graphshortestpath(Acl,i,'Directed', false); 
  end
  save(strcat('dis',num2str(j)),'dis');
end;
j=j+1;
dis=zeros(length(Acl),N);
parfor i=1:N 
   dis(:,i)=graphshortestpath(Acl,i,'Directed', false); 
end;
save(strcat('dis',num2str(j)),'dis');
%% Geodesic distaces Right hem
A=precalcdist(Br); % Br - CortexRight
N=length(A);
NNN=2000;
NN=round(N/NNN);
N=rem(N,NNN);
dis=zeros(length(A),NNN);
for j=1:NN
   parfor i=1:NNN 
        dis(:,i)=graphshortestpath(A,i,'Directed', false); 
   end;
save(strcat('disR',num2str(j)),'dis');
end;
j=j+1;
dis=zeros(length(A),N);
parfor i=1:N 
   dis(:,i)=graphshortestpath(A,i,'Directed', false); 
end;
save(strcat('disR',num2str(j)),'dis');