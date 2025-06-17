function display_table(header,time,probability,cdf)
  %displays tables
  %display header
%  for i = 1:length(header)
%    fprintf('%5s',header{i});
  %endfor
  fprintf('%10s %10s %5s\n',header{1},header{2},header{3});

  if (strcmp(header{1},'Refuel Time')==1)
      % display table content
    for i = 1:length(time)
      fprintf('%5.0f %15.4f %8.2f\n',time(i),probability(i),cdf(i));
    endfor
  elseif (strcmp(header{1},'Inter-Arrival Time') == 1)
    for i = 1:length(time)
      fprintf('%10.0f %17.4f %8.2f\n',time(i),probability(i),cdf(i));
    endfor
  endif
end
