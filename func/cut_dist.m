function [ dist ] = cut_dist( dist,N )
% CUT distances
for i=N:size(dist,2)
dist(i)=1;
end
end

