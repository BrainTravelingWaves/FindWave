function [ A ]=precalcdist( mesh )
Vertices=mesh.Vertices;
Faces=mesh.Faces;
VertConn=tess_vertconn(Vertices,Faces);
A1 = Vertices;
B1 = VertConn;
[m,n,s] = find(B1);
% X = A1(:,1);
A = sparse(length(B1), length(B1));
for i=1:length(m)
    A(m(i),n(i)) = sqrt((A1(m(i),1) - A1(n(i),1))^2 + (A1(m(i),2) - A1(n(i),2))^2 + (A1(m(i),3) - A1(n(i),3))^2);
end
%A = A2;
end

