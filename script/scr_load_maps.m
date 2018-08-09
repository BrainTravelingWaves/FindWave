%% Set params
PARAM.v_wave=0.2;
PARAM.N_step=24;
PARAM.w_frequ=10;
PARAM.SR=240;
PARAM.max_dist=0.02;
PARAM.ca=1;
%% Vertex of epicenr
vindx=153360;
pointscor_minus_right=(306645-153616);
indx_r=vindx-pointscor_minus_right;
shift=18;
%% Calculate distances
dist=graphshortestpath(aR,indx_r,'Directed',false); 
%% Simulation MEG
[amp, dipel, dipeq]=cortex_dipl(corR, dist, PARAM);
am=amp;
dpl=dipel;
diq=dipeq;
j=shift;
for i=1:PARAM.N_step
    amp(:,i)=am(:,j);
    dipel(:,:,i)=dpl(:,:,j);
    dipeq.loc(i,:)=diq.loc(j,:);
    dipeq.amp(i,:)=diq.amp(j,:);
    j=j+1;
    if j>PARAM.N_step
        j=1;
    end;
end;
%smeg=emeg_sim(pointscor_minus_right,OpMEG300s2,dipel);
%% Load img
dd=DipBsDip(dipeq,d,m.Time);
img_cor.ImageGridAmp=zeros(size(img_cor.ImageGridAmp,1),PARAM.N_step);
for i=1:size(amp,1)
    img_cor.ImageGridAmp(i+pointscor_minus_right,:)=amp(i,:);
end;
img_cor.Time=m.Time;
img_cor.Comment='Simul TW10Hz v0.2 0.1 sub2';
m.Comment=img_cor.Comment;