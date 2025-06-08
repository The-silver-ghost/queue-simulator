function random_numbers = lcgV3(n, a, c, m, x0)

    %nargin command (number of input arguments) is used to check how many arguments are passed.  
    
    if nargin < 5, x0 = 12; end
    if nargin < 4, m = 1000; end
    if nargin < 3, c = 43; end
    if nargin < 2, a = 21; end
    
    %default numbers are assigned if no input is given.

    random_numbers = zeros(1, n); 

    for i = 1:n
        x0 = mod(a * x0 + c, m);
        random_numbers(i) = x0;
    end

    disp('the generated numbers are:');
    disp(random_numbers);
end
