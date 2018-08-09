function [ Rec ] = cortexwave(mesh, dist, Gain, PARAM)
%% Load mesh
Vertices=mesh.Vertices;
%Faces=mesh.Faces;
VertNormals = mesh.VertNormals;
%% Load amp
% dist(dist==Inf)=0;
Amp=zeros(size(Vertices,1),PARAM.N_step);
md=(dist<PARAM.max_dist); %-(dist==0); %-(dist==Inf);
for i=1:PARAM.N_step 
    Amp(:,i)=sin(2*pi*dist/PARAM.l_wave-2*pi*i*PARAM.w_frequ/PARAM.SR).*md; 
end
Amp=Amp*PARAM.ca;
%PARAM.ca=0.16?0.77 nAm/mm2 * 1.6 ??2 = 0.256-1,232 nAm * 10^(-9); 16-80 mkV
%% Create dipole
ElemDip=zeros(size(Vertices,1),size(Vertices,2),PARAM.N_step);
for i=1:PARAM.N_step 
    ElemDip(Amp(:,i)~=0,:,i)=(VertNormals(Amp(:,i)~=0,:).*repmat(Amp(Amp(:,i)~=0,i),1,3));
end
%% Rec
Rec=zeros(size(Gain,1),PARAM.N_step);
for i=1:size(ElemDip,3)
Rec(:,i)=Gain*reshape(((ElemDip(:,:,i)))',size(Gain,2), 1);
end