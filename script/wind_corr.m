% Nw - points of windows = Rate/F(Hz) 2400/10Hz=240
Rate=240;
Fmeg=10;
Nw=Rate/Fmeg;
N=size(m.F,2);
N=N-Nw;
Nchn=297-28+1;
w=zeros(Nchn,Nw);
ww=w;
wcorr=zeros(N,N);
for i=1:N
for j=1:Nw
    w(:,j)=m.F(28:297,j+i-1);
end;
for k=i:N
    for l=1:Nw
        ww(:,l)=m.F(28:297,l+k-1);
    end;
    wcorr(i,k)=corr2(w,ww);
end;
fprintf('%d\n', i);
end;
sparse(wcorr);
save('wcorr2.mat','wcorr');