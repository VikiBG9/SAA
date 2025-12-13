%
%  Step 1: initialize the graph.
%

const_infinity = 1.0E+30;

v_num = 6;
source = 1;
terminal = 6;

l_weight(1:v_num) = const_infinity;
l_weight(source) = 0;

flag(1:v_num) = 0;
flag(source) = 1;

permanent = source;
path = zeros(1, v_num);

% Weighted adjacency matrix:
c = [0 2 4 0  8 12;
     2 0 3 11 5 13;
     4 3 0 6  0  7;
     0 11 6 0  10 0;
     8 5 0 10 0  1;
     12 13 7 0 1  0];

%
%  Step 2: Relax edges repeatedly.
%

while permanent ~= terminal
    i = permanent;

    % --- Relaxation ---
    for j = 1:v_num
        if c(i,j) ~= 0
            % find minimal path
            if l_weight(i) + c(i,j) < l_weight(j)
                l_weight(j) = l_weight(i) + c(i,j);

                % update path array
                path(j) = i;
            end
        end
    end

    % --- Find next permanent vertex ---
    min_l_weight = const_infinity;
    next_perm = permanent;

    for k = 1:v_num
        if flag(k) ~= 1
            % find minimal label
            if l_weight(k) < min_l_weight
                min_l_weight = l_weight(k);
                next_perm = k;
            end
        end
    end

    permanent = next_perm;
    flag(permanent) = 1;
end

%
%  Step 3: Output path.
%

min_path = [];
v = terminal;

while v ~= source
    min_path = [v min_path];
    v = path(v);
end

min_path = [source min_path];

disp('Shortest path:')
disp(min_path)

disp('Minimal distance:')
disp(l_weight(terminal))
