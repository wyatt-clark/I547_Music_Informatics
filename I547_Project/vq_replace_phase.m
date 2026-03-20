function Y = vq_replace_phase(Y, ID, CENT)

IDS = unique(ID);

for t = 1:length(IDS)
    cluster_members = find(ID == IDS(t));
    fprintf(1,'%d\t%d\n',t, length(cluster_members));
    
    
    for j = 1:length(cluster_members)
        
        Y(:,cluster_members(j)) = abs(Y(:,cluster_members(j))).*exp(i.*CENT(t,:)');
    end 
    
end
    