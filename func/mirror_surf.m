function [ mirror ] = mirror_surf( surf )
% mirror cortex
mirror=surf;
mirror.Vertices(:,2)=surf.Vertices(:,2)*-1;
mirror.Faces=surf.Faces;
mirror.Faces(:,1)=surf.Faces(:,3);
mirror.Faces(:,3)=surf.Faces(:,1);
mirror.Comment='cor_o_r_m';
end

