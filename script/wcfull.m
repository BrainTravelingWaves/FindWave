for i=1:N
    for j=i:N
        wcorr(j,i)=wcorr(i,j);
    end;
end;
%%
rm=zeros(1,N);
for i=1:N
    for j=1:N
        rm(i)=rm(i)+wcorr(i,j);
    end;
    rm(i)=rm(i)/N;
end;
%%
rrm=zeros(1,N);
for i=1:N
    if rm(i)>0.0004
        rrm(i)=rm(i);
    end
end;
%%
rmi=zeros(1,N);
for i=1:N
    for j=1:N
        if wcorr(i,j)>0.75
           rmi(i)=rmi(i)+1;
        end;
    end;
end;
%%
N=size(wcorr,1);
p=11354;
k=1;
for j=1:N
    if wcorr(p,j)>0.75
      tj(k)=j;
      k=k+1;
    end;
end;