%% Calculate 
%s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/S_V1r/';
%q=1010;
s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/S_V2r/';
q=1101;
N=length(scout_v);
N=fix(N/q);
for j=1:N
dist=zeros(size(aR,1),q);
parfor i=1:q 
   dist(:,i)=graphshortestpath(aR,scout_v(i+(j-1)*q)-(306645-153616),'Directed',false); 
end;
save(strcat(s,'dist',num2str(j)),'dist')
end;
%% Calculate V1 left hemi Sub4
s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/Sub4/';
q=1000;
N=length(scout_v);
N=fix(N/q);
for j=1:N
dist=zeros(size(aL,1),q);
parfor i=1:q 
   dist(:,i)=graphshortestpath(aL,scout_v(i+(j-1)*q),'Directed',false); 
end;
save(strcat(s,'dist',num2str(j)),'dist');
end;
j=j+1;
q=458;
dist=zeros(size(aL,1),q);
parfor i=1:q 
   dist(:,i)=graphshortestpath(aL,scout_v(i+(j-1)*1000),'Directed',false); 
end;
save(strcat(s,'dist',num2str(j)),'dist');
%% Calculate V2 left hemi Sub4
s='/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/rest_vs_sim/data/Sub4/';
q=1000;
N=length(scout_v2);
N=fix(N/q);
for j=1:N
dist=zeros(size(aL,1),q);
parfor i=1:q 
   dist(:,i)=graphshortestpath(aL,scout_v2(i+(j-1)*q),'Directed',false); 
end;
save(strcat(s,'dist',num2str(j)),'dist')
end;
q=836;
dist=zeros(size(aL,1),q);
j=j+1;
parfor i=1:q 
   dist(:,i)=graphshortestpath(aL,scout_v2(i+(j-1)*1000),'Directed',false); 
end;
save(strcat(s,'dist',num2str(j)),'dist')