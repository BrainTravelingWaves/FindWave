% gen_eeg128L left 
name={'V2l'};
dist=[];
%cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/cortexleft');
%cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/brodmann');
cd('/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/data/brodmann/V1_V2/');
N2=8; % paces
for k=1:length(name)
    vertFiles=dir(strcat(name{k},'*.mat'));
    tmpVertCell=strsplit(vertFiles.name,'.');
    load(vertFiles.name); 
    vert=eval(tmpVertCell{1});  
    eval(['clear',' ',tmpVertCell{1}]);
    currFile=tmpVertCell{1};
    N=length(vert);
    N=round(N/N2);
    dist=zeros(length(Al),N);
    seeg=zeros(size(OpMEEGbem129.Gain,1)-1,PARAM.N_step,N);
    ElemDip=zeros(length(Al),3,PARAM.N_step); 
    % ii=152854; % if left 
    ii=0;
    for j=1:N2
    tic   
    parfor i=1:N  
      [dist(:,i),path, pred]=graphshortestpath(Al,vert(i+N*(j-1))-ii,'Directed', false);
      ElemDip=cortex_edipl0(cor_l, dist(:,i), PARAM );
      seeg(:,:,i)=refer129(emeg_sim(ii,OpMEEGbem129,ElemDip)); %Elapsed time is 4.196281 seconds
    end;
    toc
    save(strcat('dist',currFile(1:end),num2str(j)),'dist');
    save(strcat('seeg',currFile(1:end),num2str(j)),'seeg');
    end
end