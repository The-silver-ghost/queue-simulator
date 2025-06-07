    function x = exponential(min_val, max_val, lambda, n)

    x = zeros(1, n);

    for i = 1:n
        valid = false;
        while ~valid
            U = rand();
            val = -log(1 - U) / lambda;
            if val >= min_val && val <= max_val
                x(i) = val;
                valid = true;
            end
        end
    end
end
