function p=uniform(a,b)
  answer = a + (b-a)*(rand);
  if answer < 0
    answer = -answer;
  else
    answer=answer;
  endif
  p = answer;
  fprintf('%0.2f\n',p);
end
