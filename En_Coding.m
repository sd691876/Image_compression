function EC = En_Coding(A)
    m1 = [];
    m2 = [];
    N  = size(A,1);
    EC = zeros(1,size(A,1)*size(A,2));
    for i = 0:N-1
        if mod(i,2) == 0
            m1 = [m1 [1:i i+1:-1:1]];
        else
            m2 = [m2 [1:i i+1:-1:1]];
        end
    end

    for j = 1:N
        if mod(j+1,2) == 0
            m1 = [m1 [j:N N:-1:j+1]];
        else
            m2 = [m2 [j:N N:-1:j+1]];
        end
    end
    zz = [m1' m2'];

    for i = 1:N*N
        EC(1,i) = A(zz(i,1),zz(i,2));
    end
    
end