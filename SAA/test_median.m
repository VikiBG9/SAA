  %clc;
  %u = randi([1 30000], 1, 10000);

  %disp('quicksort time');
  %tic;
  %qs = quicksort(u);
  %toc;

  %disp('find_median time')
  %tic;
  %[median, m] = find_median(u, 50);
  %toc;

  clc;

u = randi([1 100000], 1, 100000);

disp('heapsort time');
tic;
ss = shellsort(u);
toc;

k = ceil(length(u) / 2);   % позиция на медианата

disp('find_median time');
tic;
[outm, m] = find_median(u, k);
toc;
