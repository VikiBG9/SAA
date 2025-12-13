function outv = heapsort(v)
%--------------------------------------------------------------------------
% Syntax:       outv = heapsort_g(v);
% Inputs:       v is a vector of length n
% Outputs:      outv is the sorted (ascending) version of v
% Description:  This function sorts the input array v in ascending order
%               using the heapsort algorithm
%
% Complexity:   O(n * log(n))    best-case performance
%               O(n * log(n))    average-case performance
%               O(n * log(n))    worst-case performance
%--------------------------------------------------------------------------

n = length(v);
% Heapsort
L = round(n/2)+1; R = n;

while L>1
  L = L - 1;
  v = sift_heap(v,L,R);
end

while R>1
  tmp = v(1); v(1) = v(R); v(R) = tmp;
  R = R - 1;
  v = sift_heap(v,L,R);
end

outv = v;

end

function a = sift_heap(a,L,R)
% Build max-heap out of a
% Note: In practice, a x should be passed by reference
i = L; j = 2*L; x = a(L);
while j <= R
    if j < R
        if a(j) < a(j+1)
            j = j + 1;
        end
    end
    if x >= a(j)
        break
    end
    a(i) = a(j); i = j; j = 2*i;
end
a(i) = x;
% out_heap = a;
end
