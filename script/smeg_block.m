% Simulation MEG 4 sec*Nepicetrs 73.5 min
q=size(dist2,2)

smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist1(:,i),PARAM));
end;
save('smeg2.mat','smeg');

smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist2(:,i),PARAM));
end;
save('smeg2.mat','smeg');

smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist3(:,i),PARAM));
end;
save('smeg3.mat','smeg');

smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist4(:,i),PARAM));
end;
save('smeg4.mat','smeg');

smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist5(:,i),PARAM));
end;
save('smeg5.mat','smeg');

smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist6(:,i),PARAM));
end;
save('smeg6.mat','smeg');

smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist7(:,i),PARAM));
end;
save('smeg7.mat','smeg');
q=size(dist8,2)
smeg=zeros(300,24,q);
parfor i=1:q %length(scouts_v)
  smeg(:,:,i)=emeg_sim(306645-153616,OpMEG300s2,cortex_edipl0(corR,dist8(:,i),PARAM));
end;
save('smeg8.mat','smeg');