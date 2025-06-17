function display_table(header,time,probability,cdf)
  %displays tables
  %display header
  for i = 1:length(header)
    fprintf('%5s\n',header(i));
  endfor

  % display table content
  for i = 1:length(time)
    fprintf('%5f %5.4f %5.2f\n',time(i),probability(i),cdf(i));
  endfor

