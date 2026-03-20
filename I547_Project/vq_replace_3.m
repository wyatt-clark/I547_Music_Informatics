function Y = vq_replace_3(Y, ID, CENT,N)

IDS = unique(ID);

for t = 1:length(IDS)
    cluster_members = find(ID == IDS(t));
    fprintf(1,'%d\t%d\n',t, length(cluster_members));

    my_complex = CENT(t,1:N)'.*exp(i.*CENT(t,N+1:2*N))';

    for j = 1:length(cluster_members)
        Y(:, cluster_members(j)) = my_complex;
    end
end
