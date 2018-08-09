%% Calculate 
q=1010;
N=length(scout_v);
N=fix(N/q);
Nr=length(scout_v)-N*q;
for j=1:N
dist=zeros(size(aR,1),q);
parfor i=1:q 
   dist(:,i)=graphshortestpath(aR,scout_v(i+(j-1)*q)-(306645-153616),'Directed',false); 
end;
save(strcat('dist',num2str(j)),'dist')
end;
j=j+1;
dist=zeros(size(aR,1),q);
parfor i=1:Nr 
   dist(:,i)=graphshortestpath(aR,scout_v(i+(j-1)*q)-(306645-153616),'Directed',false); 
end;
save(strcat('dist',num2str(j)),'dist')