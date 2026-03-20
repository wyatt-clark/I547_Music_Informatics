load A

non_zero = sum(1:size(A,2)-1)

A = triu(A);
while length(find(A > 0)) < non_zero

    for i = 1:size(A) -1 %ROWS
        for j = i+1:size(A) %COLUMNS
            if A(i,j) > 0
                %find all nodes that each one are linked too
                R = setdiff(union( find(A(:,i)>0), find(A(i,:)> 0)), [i,j]);
                C = setdiff(union( find(A(j,:)>0), find(A(:,j)> 0)), [i,j]);
                i
                j
                for k = 1:length(R)
                    ind = R(k);
                    tvals_1 = [i,ind];
                    new_val = A(min(tvals_1), max(tvals_1) ) + A(i,j);
                    tvals = [j,ind];
                    if A(min(tvals),max(tvals)) == 0
                        A(min(tvals),max(tvals)) = new_val;
                    end

                    if new_val < A(min(tvals),max(tvals))
                        A(min(tvals),max(tvals)) = new_val;
                    end
                end

                for k = 1:length(C)
                    ind = C(k);
                    tvals_1 = [j,ind];
                    new_val = A(min(tvals_1), max(tvals_1)) + A(i,j);
                    tvals = [i,ind];
                    if A(min(tvals),max(tvals)) == 0
                        A(min(tvals),max(tvals)) = new_val;
                    end

                    if new_val < A(min(tvals),max(tvals))
                        A(min(tvals),max(tvals)) = new_val;
                    end
                end

            end
        end
    end

end