function Y = encode(Y,CENTROIDS,distance_function, COVS)


for i = 1:size(Y,1)
   distances = zeros(1,size(CENTROIDS,1));
    for j = 1:size(CENTROIDS,1)

        switch distance_function
            case 'euclidean'
                %sum((V(i+1)-CENTROIDS(j)) .^2)
                %distances(j) = euclidean(V(i+1), CENTROIDS(j));
                distances(j) = sum((Y(i,:)-CENTROIDS(j,:)) .^2);

            case 'mahalanobis'
                warning off
                distances(j) = (Y(i,:)-CENTROIDS(j,:))*inv(COVS{j})*(Y(i,:)-CENTROIDS(j,:))';
                %distances(j) = mahalanobis(V(i+1,:), CENTROIDS(j), COVS{j});
                warning on
        end

    end
    
    
   [distance, enc] = min(distances);
    Y(i,:) = CENTROIDS(enc,:);
    
    
end