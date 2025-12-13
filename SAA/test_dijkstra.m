clc;
disp("=== Running Dijkstra Test ===");

%
% --- Step 1: Initialize graph ---
%

const_infinity = 1.0e30;
v_num = 6;

source = 1;
terminal = 6;

l_weight = const_infinity * ones(1, v_num);
l_weight(source) = 0;

flag = zeros(1, v_num);
flag(source) = 1;

permanent = source;
path = zeros(1, v_num);

% weighted adjacency matrix
c = [0 2 4 0 8 12;
     2 0 3 11 5 13;
     4 3 0 6 0 0;
     0 11 6 0 10 0;
     8 5 0 10 0 1;
     12 13 0 0 1 0];


%
% --- Step 2: Run Dijkstra ---
%

while permanent ~= terminal
    i = permanent;

    % relax edges
    for j = 1:v_num
        if c(i,j) ~= 0
            if l_weight(j) > l_weight(i) + c(i,j)
                l_weight(j) = l_weight(i) + c(i,j);
                path(j) = i;
            end
        end
    end

    % find next permanent vertex
    min_l_weight = const_infinity;
    next_perm = permanent;

    for k = 1:v_num
        if flag(k) ~= 1
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
% --- Step 3: Reconstruct shortest path ---
%

route = terminal;
min_path = terminal;

while terminal ~= source
    terminal = path(terminal);
    min_path = [terminal min_path];
end


%
% --- Expected results ---
%

expected_path = [1 2 5 6];
expected_distance = 8;


%
% --- Tests ---
%

if isequal(min_path, expected_path)
    disp("Path test: PASSED");
else
    disp("Path test: FAILED");
    disp("Expected path:"); disp(expected_path);
    disp("Got:"); disp(min_path);
end

if l_weight(route) == expected_distance
    disp("Distance test: PASSED");
else
    disp("Distance test: FAILED");
    fprintf("Expected distance: %d\n", expected_distance);
    fprintf("Got: %d\n", l_weight(route));
end
