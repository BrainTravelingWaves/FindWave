N=1010;
NN=24;
smegV1s2=zeros(size(smeg,1),NN*N);
t=zeros(1,NN*N);
for i=1:N
    j=(i-1)*NN+1;
    k=j+NN-1;
    smegV1s2(:,j:k)=smeg(:,:,i);
end;
for i=1:N*NN
     t(i)=(i-1)*1/240;
end;
%%
em=emeg;
em(:,1:24)=0;
for i=1:63
  em(a(i),:)=emeg(a(i),:);
end;
%%
sm=emeg;
sm(:,1:24)=0;
for i=1:63
  sm(a(i),:)=smeg(a(i),:);
end;