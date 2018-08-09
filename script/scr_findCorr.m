%% Find correlation
em=e_data.F;
N=size(em,2);      % Experimental array size
N3=100 %size(smeg,3);   % Scout vertexes
N2=size(smeg,2);   % Points of simulated data
cc=zeros(N3,N);
for i=1:N3
   sm=smeg(:,:,i);
   ssm=zeros(size(smeg,1),N);
   for j=1:N2 % Cyclic shift of simulated data
      l=j; 
      for k=1:N
          ssm(:,k)=sm(:,l);
          l=l+1;
          if l>N2
              l=1;
          end;
      end;
      cc(i,j)=corr2(ssm,em);
   end;
end;