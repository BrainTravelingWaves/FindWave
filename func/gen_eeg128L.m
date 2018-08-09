%gen_eeg128L left 20Hz 0.04 m/s 0.4 m
%name={'V1l','V2l'};
name={'V1r','V2r'};
%dist=[];
%cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/cortexleft');
%cd('/Users/vitaliyverkhlyutov/Documents/MATLAB/lib_find_wave/data/brodmann/V1_V2/');
%cd('/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/data/brodmann/V1_V2/');
cdr='/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/data/cortexright';
cdl='/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/data/cortexleft';
cdb='/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/data/cortex';
cda='/Users/vitaliy/Documents/MATLAB/BrainVector 2.0/data/brodmann/V1_V2/';
cd(cdb);
load OpMEEGbem129.mat;
cd(cda);
%N2=3; % paces
for k=1:length(name)
    vertFiles=dir(strcat(name{k},'*.mat'));
    tmpVertCell=strsplit(vertFiles.name,'.');
    load(vertFiles.name); 
    vert=eval(tmpVertCell{1});  
    eval(['clear',' ',tmpVertCell{1}]);
    currFile=tmpVertCell{1};
    N=length(vert);
    clear vert;
    if currFile(3)== 'l'
        ii=0;
        cd(cdl);
        %load Al.mat;
        %A=Al;
        %clear Al;
        load cor_l.mat;
        cor=cor_l;
        clear cor_l;
        if currFile(2)== '1' %%%%%%%%%%%%%%  
          q=7;
        else
          q=1;
        end; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else
        ii=152854;
        cd(cdr);
        %load Ar.mat;
        %A=Al;
        %clear Ar;
        load cor_r.mat;
        cor=cor_r;
        clear cor_r;
    end;
    if currFile(2)== '1'
      N2=3;  
      q=2;
    else
      N2=8;
      q=0;
    end;
    cd(cda);
    N=fix(N/N2);
    %ElemDip=zeros(length(Al),3,PARAM.N_step);     
    %dist=zeros(length(Al),N);
    seeg=zeros(size(OpMEEGbem129.Gain,1)-1,PARAM.N_step,N);
    % ii=152854; % if left ii=0;
    for j=q:N2
        load(strcat('dist',currFile,int2str(j),'.mat')); 
        tic   
        parfor i=1:N  
            %[dist(:,i),path,pred]=graphshortestpath(Al,vert(i+N*(j-1))-ii,'Directed', false);
            %ElemDip=cortex_edipl0(cor_l, dist(:,i), PARAM );
            seeg(:,:,i)=refer129(emeg_sim(ii,OpMEEGbem129,cortex_edipl0(cor, dist(:,i), PARAM ))); %Elapsed time is 4.196281 seconds
        end;
        toc
        %save(strcat('dist',currFile(1:end),num2str(j)),'dist');
        save(strcat('seeg',currFile(1:end),num2str(j)),'seeg');
        clear dist;
    end
    clear seeg;
end