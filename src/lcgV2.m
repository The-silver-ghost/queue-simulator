m = 1000;   
a = 21;      
c = 43;    
x0 = 12;   
n = 10;

random_numbers = zeros(1, n);

for i = 1:n
    x0 = mod(a * x0 + c, m);
    random_numbers(i) = x0;
end

disp('random numbers are:');
disp(random_numbers);