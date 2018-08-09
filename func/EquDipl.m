function [ dipl ] = EquDipl( ElemDip )
for i=1:size(ElemDip,3)
DipAmp(i,:)=sum(ElemDip(:,:,i),1);  
Dip_proj(:,i)=sum(ElemDip(:,:,i).*repmat(DipAmp(i,:),size(VertNormals,1),1),2);
Dip_proj((Dip_proj(:,i))<0,i)=0;
DipLoc(i,:)=sum(Vertices.*repmat(Dip_proj(:,i),1,3),1)/sum(Dip_proj(:,i));
end
dipl.loc=DipLoc;
dipl.amp=DipAmp;
end

