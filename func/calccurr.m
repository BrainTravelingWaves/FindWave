surf_square = surfsquare(cortex_new,d1(505,:),PARAM.max_dist);
% number triagles
numOfSquares=sum(surf_square>0);
% number vetices
numOfVertices=sum((d1(505,:)<PARAM.max_dist)&(d1(505,:)>0));
% 
mean_triang_square=mean(surf_square(surf_square>0))*10^(6);
