%u = randi([1 100000], 1, 100000)

%disp('heapsort');
%tic;
%hs = heapsort(u);
%toc;

%u = randi([1 100000], 1, 500000)

%disp('quicksort');
%tic;
%qs = quicksort(u);
%toc;

u = randi([1 100000], 1, 100000)

disp('heapsort');
tic;
hs = heapsort(u);
toc;
