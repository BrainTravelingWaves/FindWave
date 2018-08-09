G=zeros(330,803727);
G(1:165,:)=G1;
G(166:330,:)=G2;
Sph267s4.Gain=G;
Sph267s4.GridLoc=Gl;
%%
Gl=Sph267s4.GridLoc;
G1=Sph267s4.Gain(1:165,:);
G2=Sph267s4.Gain(166:330,:);

