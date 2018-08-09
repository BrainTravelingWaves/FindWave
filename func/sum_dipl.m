function [ dipl ] = sum_dipl( meshsum, ElemDip1 , ElemDip2 )
% Load mesh
Vertices=meshsum.Vertices;
VertNormals = meshsum.VertNormals;

ElemDip=zeros(size(ElemDip1,1)+size(ElemDip2,1),size(ElemDip1,2),size(ElemDip1,3));
for i=1:size(ElemDip1,1) 
    ElemDip(i,:,:)=ElemDip1(i,:,:);
end
ii=i;
for i=1:size(ElemDip2,1) 
    ElemDip(i+ii,:,:)=ElemDip2(i,:,:);
end
DipAmplitude=zeros(size(ElemDip,3),size(ElemDip,2));
DipLoc=zeros(size(ElemDip,3),size(ElemDip,2));
Dip_proj=zeros(size(ElemDip,1),size(ElemDip,3));
for i=1:size(ElemDip,3)
DipAmplitude(i,:)=sum(ElemDip(:,:,i),1);  
Dip_proj(:,i)=sum(ElemDip(:,:,i).*repmat(DipAmplitude(i,:),size(VertNormals,1),1),2);
Dip_proj((Dip_proj(:,i))<0,i)=0;
DipLoc(i,:)=sum(Vertices.*repmat(Dip_proj(:,i),1,3),1)/sum(Dip_proj(:,i));
end
dipl.loc=DipLoc;
dipl.amp=DipAmplitude;
end