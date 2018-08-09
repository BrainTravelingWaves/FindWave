% gen_eeg128L left 
name={'V1r'};
dist=[];
%cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/cortexleft');
%cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/brodmann');
cd('/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/data/brodmann/V1_V2/');
N2=3; % paces
for k=1:length(name)
    vertFiles=dir(strcat(name{k},'*.mat'));
    tmpVertCell=strsplit(vertFiles.name,'.');
    load(vertFiles.name); 
    vert=eval(tmpVertCell{1});  
    eval(['clear',' ',tmpVertCell{1}]);
    currFile=tmpVertCell{1};
    N=length(vert);
    N=fix(N/N2);
    %ElemDip=zeros(length(Ar),3,PARAM.N_step);  
    %dist=zeros(length(Ar),N);
    seeg=zeros(size(OpMEEGbem129.Gain,1)-1,PARAM.N_step,N);  
    % if rigth ii=152854; % if left ii=0
    ii=152854;
    for j=3:N2
    load(strcat('dist',currFile,int2str(j),'.mat'));     
    tic   
    parfor i=1:N    
      %[dist(:,i),path, pred]=graphshortestpath(Ar,vert(i+N*(j-1))-ii,'Directed', false);
      %ElemDip=cortex_edipl0(cor_r, dist(:,i), PARAM );
      seeg(:,:,i)=refer129(emeg_sim(ii,OpMEEGbem129,cortex_edipl0(cor_r, dist(:,i), PARAM ))); %Elapsed time is 4.196281 second
    end
    toc
    %save(strcat('dist',currFile(1:end),num2str(j)),'dist');
    save(strcat('seeg',currFile(1:end),num2str(j)),'seeg');
    end
end