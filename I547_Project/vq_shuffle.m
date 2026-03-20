function Y = vq_shuffle(Y, ID)

IDS = unique(ID);

for i = 1:length(IDS)
    cluster_members = find(ID == IDS(i));
    fprintf(1,'%d\t%d\n',i, length(cluster_members));
    shuffled = cluster_members(randperm(length(cluster_members)));
    
    Y(:,cluster_members) = Y(:,shuffled);
end
    