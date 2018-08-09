function [cutcortex] = cut_cortex(cortex)
cutcortex=cortex;
v=find(cortex.Vertices(:,1)>-0.024);
[Vertices, Faces]=tess_remove_vert(cortex.Vertices,cortex.Faces,v);
[cutcortex.Vertices, cutcortex.Faces]=tess_clean(Vertices,Faces);
cutcortex.VertConn=tess_vertconn(cutcortex.Vertices,cutcortex.Faces);
cutcortex.Comment='cut_cortex';
cutcortex.VertNormals= tess_normals(Vertices,Faces,cutcortex.VertConn);
end