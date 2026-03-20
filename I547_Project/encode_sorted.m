function Y = encode_sorted(Y,CENTROIDS,distance_function, COVS)
THRESH = 

[V, I_CENTROIDS] = sort(CENTROIDS,2,'descend');
[V,Y ] = sort(Y,2,'descend');
clear V;

for i = 1:size(Y,1)
    distances = zeros(1,size(CENTROIDS,1));
    for j = 1:size(CENTROIDS,1)


        %sum((V(i+1)-CENTROIDS(j)) .^2)
        %distances(j) = euclidean(V(i+1), CENTROIDS(j));
        distances(j) = sum((Y(i,:)-I_CENTROIDS(j,:)) .^2);


    end


    [distance, enc] = min(distances);
    Y(i,:) = CENTROIDS(enc,:);


end