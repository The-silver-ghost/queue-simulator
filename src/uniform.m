function probability_list = uniform(a, b)

    probability_list = [];
    remaining = b;
    n = 1;
    
    while remaining > 0
        answer = a + (remaining - a)*rand();
        
        if remaining - answer < a && remaining - answer > 0
            answer = remaining;
        elseif remaining - answer <= 0
            answer = remaining;
            probability_list(n) = answer;
            break;
        end
        
        answer = round(answer*100)/100;
        
        probability_list(n) = answer;
        remaining = remaining - answer;
        n = n + 1;
    end
    
    total = sum(probability_list);
    if abs(total - b) > 0.01  % Only adjust if difference is significant
        [max_val, max_idx] = max(probability_list);
        probability_list(max_idx) = probability_list(max_idx) + (b - total);
        probability_list(max_idx) = round(probability_list(max_idx)*100)/100;
    end
end