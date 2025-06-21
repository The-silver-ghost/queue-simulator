function x = exponential(min_val, max_val, lambda)

    max_attempts = 10000;

    for attempt = 1:max_attempts
        x = [];
        total = 0;

        while true
            U = rand();
            val = -log(1 - U) / lambda;

            if val < min_val || val > max_val
                continue;  
            end

            if total + val < 1
                x = [x val];
                total = total + val;
            else
                last_val = 1 - total;
                if last_val >= min_val && last_val <= max_val
                    x = [x last_val];  
                    total = total + last_val;
                    return
                else
                    break;
                end
            end
        end
    end

    error('Failed to generate a valid sequence summing to 1 after many attempts.');
end
