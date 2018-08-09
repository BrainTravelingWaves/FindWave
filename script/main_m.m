%% Set params
PARAM.v_wave=0.2;
PARAM.N_step=24;
PARAM.w_frequ=10;
PARAM.SR=240;
PARAM.max_dist=0.02;
PARAM.ca=0.000336725;
%% Points
vindx=163334; %170270;
pointscor_minus_right=(306645-153616);
indx_r=vindx-pointscor_minus_right;
%% Calculate distances
dist=graphshortestpath(aR,indx_r,'Directed',false); 
%% Simulation MEG
[amp, dipel, dipeq]=cortex_dipl(corR, dist, PARAM);
smeg=emeg_sim(pointscor_minus_right,OpMEG300s2,dipel);
smeg(1,:)=0;
smeg(298,:)=0;
smeg(299,:)=0;
smeg(300,:)=0;
smeg=smeg/700000;
m.F=smeg;
%% Find corr
N=size(smeg,2);
ssm=zeros(size(smeg));
for j=1:N 
    l=j; 
    for k=1:N
        ssm(:,k)=smeg(:,l);
        l=l+1;
        if l>N
            l=1;
        end;
    end;
    cc(j)=corr2(ssm,em);
 end;
%% Cyclic shift of simulated data
l=17;
N=24;
ssm=zeros(300,24);
for k=1:N
    ssm(:,k)=smeg(:,l);
    l=l+1;
    if l>N
        l=1;
    end;
end;
m.F=ssm;
 %% Load img
dd=DipBsDip(dipeq,d,m.Time);
img_cor.ImageGridAmp=zeros(size(img_cor.ImageGridAmp,1),PARAM.N_step);
for i=1:size(amp,1)
    img_cor.ImageGridAmp(i+pointscor_minus_right,:)=amp(i,:);
end;
img_cor.Time=m.Time;
img_cor.Comment='Simulation TW 10Hz v0.2 78.9';
m.Comment=img_cor.Comment;