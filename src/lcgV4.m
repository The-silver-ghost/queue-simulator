function values = lcgV4(a, c, x0)
m = 3 + (7-3)*(rand());
    if nargin < 4
        x0 = mod(round(sum(clock) * 100), m);  %time system to randomize
    end

    b = 1;
    n = 1;
    values = [];
    total = 0;

    while b > 0.01
        x0 = mod(a * x0 + c, m);
        val = round((x0 / m) * 100) / 100;
        if val > b
            val = b;
        end
        values(end+1) = val;
        total = total + val;
        b = 1 - total;
    end

    fprintf('Generated values:\n');
    disp(values);
end
