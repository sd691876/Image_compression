function rlc = RLC(EC)
    rlc = cell(size(EC,1),1);
    for i = 1 : size(EC,1)
        count_zero = 0;
        reg = {};
        for j  = 1 : size(EC,2)
            if(EC(i,j)==0)
                count_zero = count_zero + 1;
            else
                reg = [reg [num2str(count_zero,'{%d'),num2str(EC(i,j),',%d}')]];
            end
        end
        rlc{i,1} = [reg  '{EOB}'];
    end
end