function p=uniform(a,b)
  n = 1;
  total = 0;
  while (b > 0)
    answer = a + (b-a)*(rand);
    if answer < 0
      answer = -answer;
    else
      answer=answer;
    endif
    answer = round(answer*100)/100;
    b = b - answer;
    probability_list(n) = [answer];
    n = n+1;
  end
  for i = 1:n-1
    total = total + probability_list(i);
  endfor
  n = 1;
  while (probability_list(n) != max(probability_list))
    n=n+1;
  endwhile

  if (total < 1)
    probability_list(n) = (1-total) + probability_list(n)
  elseif (total>1)
    probability_list(n) = probability_list(n) - (total-1)
  endif
  p = probability_list;
end
