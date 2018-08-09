%% Main for create waves of EEG and MEG (load data and use Run Selection)
A=precalcdist(cort_left);
%% Find the geodesic distaces 
path = {};
%N=2500; % For i7 16G Elapsed time is 525.573294 seconds.
N=1000;
d001 = zeros(N,length(A));
tic
parfor i=1:N
    [d001(i,:), path, pred]=graphshortestpath(A, i+N*(1-1),'Directed', false);
end
toc
%%
d002 = zeros(N,length(A));
tic
parfor i=1:N
    [d002(i,:), path, pred]=graphshortestpath(A, i+N*(2-1),'Directed', false);
end
toc
%%
d003 = zeros(N,length(A));
parfor i=1:N
    [d003(i,:), path, pred]=graphshortestpath(A, i+N*(3-1),'Directed', false);
end
%% Create EEG+ref or MEG : Elapsed time is 2491.841997 seconds
N=size(d8,1);
R8=zeros(N,size(BEM129.Gain,1),PARAM.N_step);
parfor i=1:N
  R8(i,:,:)=cortexwave(cortex_new,d8(i,:),BEM129.Gain,PARAM);   
end
%% Create wave amplitudes, dipoles and EEG without referent
numvertex=505;
[a,d]=cortexamp(cortex_new,d1(numvertex,:),PARAM);
eeg128=refer129(squeeze(R1(numvertex,:,:)));
%% Create the amplitude image 
% c - cortex all
e.F=eeg128;
im=zeros(size(c.ImageGridAmp));
for i=1:size(a,1)
    im(i,:)=a(i,:);
end
c.ImageGridAmp=im;
%% Corr2 : Elapsed time is 4000-6000 seconds
CR11=zeros(N,N); % N=5000;
k=1;
for i=1:N
    for j=i:N
        eeg1=refer129(squeeze(R1(i,:,:)));
        eeg2=refer129(squeeze(R1(j,:,:)));
        CR11(k)=corr2(eeg1,eeg2);
        k=k+1;
    end
end    