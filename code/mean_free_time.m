function [MFT]=mean_free_time(JXY,NumP)

for i=1:NumP
    N=nnz(JXY(i,:));
    MFT(i,1)=sum(JXY(i,:)/N);
end


end