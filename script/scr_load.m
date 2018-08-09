%% Load experemental MEG
N=24;
T=89.8;
e_data=m;
e_data.F=zeros(length(e_data.ChannelFlag),N);
t=e_data.Time;
e_data.Time=zeros(1,N);
emeg=m.F;
%emeg(1,:)=0;
%emeg(2,:)=0;
%emeg(301,:)=0;
%emeg(302,:)=0;
j=1;
for i=1:length(t)  
  if t(i)>=T 
      if j<=N
         e_data.F(:,j)=emeg(:,i);
         e_data.Time(1,j)=t(i);
         j=j+1;
      end;
  end;
end;
e_data.Comment='ExperimSpontMEG89.8';