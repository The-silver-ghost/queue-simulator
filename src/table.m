function [col_time,col_prob,col_cdf] = table(prob_array)
  %generate table from probability array
  %define var
  numberOfValues = 0;
  beginValue = randi([1,3]);
  col_prob = prob_array;
  tempNum = 0;
  %cdf = [];

  %find number of values generated
  numOfValues = length(prob_array);

  for i = 1:numOfValues
    % generate refuel times
    col_time(i) = beginValue;
    beginValue += 1;

    % calculate cdf
    tempNum += prob_array(i);
    col_cdf(i) = tempNum;
  endfor
end
