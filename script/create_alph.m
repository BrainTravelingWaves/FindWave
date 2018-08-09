%11354 11380 11404 13305
N=24;
P1=11354;
P=11404;
mm=m;
mm.F=zeros(length(m.ChannelFlag),N);
mm.Time=zeros(1,N);
for i=1:N
    mm.F(:,i)=m.F(:,i-1+P);
    mm.Time(i)=m.Time(i-1+P1);
end;
mm.Comment='24 alpha wave 11404';