% gen_ElDip_eeg128L 
%name={'V1L','V2L'};
name={'V14L'};
dist=[];
cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/cortexleft');
%cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/brodmann');
%cd('/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/brodmann');
for k=1:length(name)
    vertFiles=dir(strcat(name{k},'*.mat'));
    tmpVertCell=strsplit(vertFiles.name,'.');
    load(vertFiles.name);
    vert=eval(tmpVertCell{1});  
    currFile=tmpVertCell{1};
    N=length(vert);
    dist=zeros(1,length(Al));
    seeg=zeros(size(OpMEEGbem129.Gain,1)-1,PARAM.N_step,N);
    ElemDip=zeros(length(Al),3,PARAM.N_step,N);
    ii=0;   % if rigth ii=152854; % if left ii=0
    tic   
    for i=1:N
      [dist,path, pred]=graphshortestpath(Al,vert(i)-ii,'Directed', false);
      ElemDip(:,:,:,i)=cortex_edipl(cor_l, dist, PARAM );
      seeg(:,:,i)=refer129(emeg_sim(ii,OpMEEGbem129,ElemDip(:,:,:,i))); %Elapsed time is 4.196281 seconds
    end;
    toc
    save(strcat('seeg',currFile(1:end)),'seeg');
end