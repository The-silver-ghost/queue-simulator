function values = lcgV4(numOfVehicles)
initial = randi([1, 100]); %generates random initial number between 1 and 100;
a = 21; % value a is set to default as 21;
c = 43; % value c is set to default as 43;
x0 = 100; % value x0 is set to default as 100;
x = mod((a * initial + c), x0);  % lcg formula is used to generate first number;
for i = 1:numOfVehicles % for loop is used to iterate from 1 to the number of vehicles present at the gas station;
    x = mod((a * x + c), x0); % the same lcg formula is used to generate new number for each iteration and stores in an array;
    values(i) = x; % after iteration is completed, function returns array which contains the random values; 
end
end
