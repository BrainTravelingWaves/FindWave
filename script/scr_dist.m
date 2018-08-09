aR=load('aR.mat');
scout_v=load('scout_v.mat');

parfor i=1:length(scout_v) 
   dist(:,i)=graphshortestpath(aR,scout_v(i)-(306645-153616),'Directed', false); 
end;

% Save dist
q=1250;
dist1=dist(:,q*0+1:q*1);
save('d1.mat','dist1');
dist2=dist(:,q*4+1:q*2);
save('d2.mat','dist2');
dist3=dist(:,q*5+1:q*3);
save('d3.mat','dist3');
dist4=dist(:,q*6+1:q*4);
save('d4.mat','dist4');
dist5=dist(:,q*4+1:q*5);
save('d5.mat','dist5');
dist6=dist(:,q*5+1:q*6);
save('d6.mat','dist6');
dist7=dist(:,q*6+1:q*7);
save('d7.mat','dist7');
dist8=dist(:,q*7+1:q*8+59);
save('d8.mat','dist8');