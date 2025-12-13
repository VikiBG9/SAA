%
%  Step 1: initialize the graph.
%

  const_infinity = 1.0E+30;
  v_num = <number of vertexs>;

  source = <begin vertex>;
  terminal = <end vertex>;

  l_weight(1:v_num) = const_infinity;
  l_weight(source) = 0;
  flag(1:v_num) = 0; % not constant label
  flag(source) = 1; % constant label
  permanent = source;
  path = zeros(1,v_num);

  c = [xxxxxx]; % weighted adjacency matrix

c = [0 2 4 0 8 12; 2 0 3 11 5 13;...

%  Step 2: Relax edges repeatedly.
%

  while permanent ~= terminal
      i = permanent;
      for j = 1:v_num  % find minimal path
          if c(i,j) ~= 0
              %<find minimal path>
			  %<update path array>
		  end
      end
      min_l_weight = const_infinity;
      for k = 1:v_num  % find next permanent vertex
          if flag(k) ~= 1
              <find minimal label>
			  <set next permanent vertex>
          end
      end
      flag(permanent) = 1;
  end

%
%  Step 3: Output path.
%

  min_path = 0;
  while terminal ~= source
      <output path between source and terminal vertexs>
  end
