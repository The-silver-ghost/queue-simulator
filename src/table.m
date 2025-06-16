function [col_time,col_prob,col_cdf] = table(prob_array)
  %generate table from probability array
  %define var
  numberOfValues = 0;
  beginValue = randi([1,3]);
  col_prob = prob_array;

  %find number of values generated
  numOfValues = length(prob_array);

  % generate refuel times
  for i = 1:numOfValues
    col_time(i) = beginValue;
    beginValue += 1;
  endfor
end
