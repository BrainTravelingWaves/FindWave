name={'dV1l','dV1r','dV2l','dV2r'};
%name={'dV1l','dV2l'};
eeg=e003118;
dist=[];
cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/brodmann/1');
%cd('/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/brodmann');
for k=1:length(name)
    distFiles=dir(strcat(name{k},'*.mat'));
    for l=1:length(distFiles)
    tmpDistCell=strsplit(distFiles(l).name,'.');
    load(distFiles(l).name); % reload
    dist=eval(tmpDistCell{1});
    currFile=tmpDistCell{1};
    N=size(dist,1);
    c=zeros(1,N);
    % if 'l' then
    for i=1:N
       ElemDip=cortex_edipl(cort_left, dist(i), PARAM );
       simeeg=refer129(emeg_sim(0,OpMEEGbem129,ElemDip));
       c(i)=corr2(simeeg,eeg);
       %Elapsed time is 4.196281 seconds
    end;
    % else
    % parfor i=1:N
    %   ElemDip=cortex_edipl(cort_right, dist(i), PARAM );
    %   simeeg=refer129(emeg_sim(152854,OpMEEGbem129,ElemDip, PARAM));
    %   c(i)=corr2(simeeg,eeg);
    % end;
    % unload(distFiles(l).name)
    save(strcat('c',currFile(2:end)),'c');
    end
end