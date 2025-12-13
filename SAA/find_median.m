function [outm, vm] = find_median(v, k)
    vm = v;                 % работим върху копие
    L = 1;
    R = length(vm);

    while L <= R
        i = L;
        j = R;
        x = vm(floor((L + R) / 2));   % pivot

        % partition
        while i <= j
            while vm(i) < x, i++; end
            while vm(j) > x, j--; end
            if i <= j
                tmp = vm(i); vm(i) = vm(j); vm(j) = tmp;
                i++; j--;
            end
        end

        % move search boundaries
        if k <= j
            R = j;
        elseif k >= i
            L = i;
        else
            % pivot is exactly at position k
            outm = vm(k);
            return;
        end
    end

    outm = vm(k);
end
