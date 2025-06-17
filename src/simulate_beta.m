function gas_station_simulation()
    
    disp('=== Gas Station Simulation ===');
    
    % Get number of vehicles
    while true
        num_vehicles = input('Enter number of vehicles to simulate (1-1000): ');
        if isnumeric(num_vehicles) && num_vehicles >= 1 && num_vehicles <= 1000
            break;
        end
        disp('Invalid input! Please enter a number between 1 and 1000.');
    end
    
    % Get RNG type
    disp('Select random number generator type:');
    disp('1. Uniform Distribution');
    disp('2. Exponential Distribution');
    disp('3. LCG (Linear Congruential Generator)');
    
    while true
        rng_choice = input('Enter your choice (1-3): ');
        if any(rng_choice == [1 2 3])  
            break;
        end
        disp('Invalid input! Please enter 1, 2, or 3.');
    end
    
    % Map choice to RNG type
    if rng_choice == 1
        selected_rng = 'uniform';
    elseif rng_choice == 2
        selected_rng = 'exponential';
    else
        selected_rng = 'lcg';
    end
    
 