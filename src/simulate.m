function [refuel_times, inter_arrival_times] = simulate(method, num_vehicles, is_peak_hours)
% SIMULATE Generates refuel times and inter-arrival times using specified RNG methods
%   Uses external functions: exponential.m, lcgV4.m, uniform.m

    % Handle missing inputs
    if nargin < 3
        % Get user input if arguments not provided
        disp('=== Gas Station Time Generator ===');
        
        if nargin < 1
            disp('Select random number generator type:');
            disp('1. Exponential');
            disp('2. LCG (Linear Congruential Generator)');
            disp('3. Uniform');
            choice = input('Enter choice (1-3): ');
            
            switch choice
                case 1
                    method = 'exponential';
                case 2
                    method = 'lcg';
                case 3
                    method = 'uniform';
                otherwise
                    error('Invalid choice. Please enter 1, 2, or 3.');
            end
        end
        
        if nargin < 2
            num_vehicles = input('Enter number of vehicles to simulate: ');
        end
        
        if nargin < 3
            peak = input('Is it peak hours? (1 for yes, 0 for no): ');
            is_peak_hours = logical(peak);
        end
    end

    % Set parameters based on peak/non-peak hours
    if is_peak_hours
        % Shorter times during peak hours
        refuel_range = [0.05, 0.3];    % hours (3-18 minutes)
        arrival_range = [0.02, 0.2];   % hours (1.2-12 minutes)
        lambda = 10;                   % for exponential distribution
    else
        % Longer times during non-peak hours
        refuel_range = [0.1, 0.5];     % hours (6-30 minutes)
        arrival_range = [0.05, 0.3];   % hours (3-18 minutes)
        lambda = 5;                    % for exponential distribution
    end

    % Convert hours to minutes for display
    hours_to_minutes = @(h) round(h * 60 * 10)/10; % Round to 1 decimal
    
    % Generate times based on selected method
    switch lower(method)
        case 'exponential'
            % Generate refuel times using exponential function
            refuel_hours = exponential(refuel_range(1), refuel_range(2), lambda);
            inter_arrival_hours = exponential(arrival_range(1), arrival_range(2), lambda*1.5);
            
            % Convert to minutes
            refuel_times = arrayfun(hours_to_minutes, refuel_hours);
            inter_arrival_times = arrayfun(hours_to_minutes, inter_arrival_hours);
            
            % Ensure we have enough values
            refuel_times = refuel_times(1:min(num_vehicles, length(refuel_times)));
            inter_arrival_times = inter_arrival_times(1:min(num_vehicles, length(inter_arrival_times)));
            
            % Pad with zeros if needed
            if length(refuel_times) < num_vehicles
                refuel_times = [refuel_times, zeros(1, num_vehicles-length(refuel_times))];
            end
            if length(inter_arrival_times) < num_vehicles
                inter_arrival_times = [inter_arrival_times, zeros(1, num_vehicles-length(inter_arrival_times))];
            end

        case 'lcg'
            % Generate refuel times using LCG
            a = 1664525;
            c = 1013904223;
            lcg_results = lcgV4(a, c);
            refuel_times = hours_to_minutes(lcg_results * (refuel_range(2)-refuel_range(1)) + refuel_range(1));
            
            % Generate inter-arrival times with different seed
            lcg_results = lcgV4(a+1, c+1); % Different parameters for variety
            inter_arrival_times = hours_to_minutes(lcg_results * (arrival_range(2)-arrival_range(1)) + arrival_range(1));
            
            % Take first num_vehicles elements
            refuel_times = refuel_times(1:min(num_vehicles, end));
            inter_arrival_times = inter_arrival_times(1:min(num_vehicles, end));

        case 'uniform'
            % Generate refuel times using uniform function
            refuel_hours = uniform(refuel_range(1), refuel_range(2));
            inter_arrival_hours = uniform(arrival_range(1), arrival_range(2));
            
            % Convert to minutes
            refuel_times = arrayfun(hours_to_minutes, refuel_hours);
            inter_arrival_times = arrayfun(hours_to_minutes, inter_arrival_hours);
            
            % Take first num_vehicles elements
            refuel_times = refuel_times(1:min(num_vehicles, end));
            inter_arrival_times = inter_arrival_times(1:min(num_vehicles, end));

        otherwise
            error('Invalid method. Choose "exponential", "lcg", or "uniform".');
    end
    
    % Display results
    disp('=== Generated Times ===');
    disp('Refuel Times (minutes):');
    disp(refuel_times);
    fprintf('Average refuel time: %.2f minutes\n', mean(refuel_times));
    
    disp('Inter-Arrival Times (minutes):');
    disp(inter_arrival_times);
    fprintf('Average inter-arrival time: %.2f minutes\n', mean(inter_arrival_times));
end