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
        lambda = 2;                   % for exponential distribution
    else
        % Longer times during non-peak hours
        refuel_range = [0.1, 0.5];     % hours (6-30 minutes)
        arrival_range = [0.05, 0.3];   % hours (3-18 minutes)
        lambda = 1.5;                    % for exponential distribution
    end

    % Convert hours to minutes for display
    hours_to_minutes = @(h) round(h * 60 * 10)/10; % Round to 1 decimal

    %define values
    refuel_prob = [];
    refuel_cdf = [];
    iArriv_prob = [];
    iArriv_cdf = [];
    refuel_table_header = {'Refuel Time' 'Probablility' 'CDF'};
    iArriv_table_header = {'Inter-Arrival Time' 'Probablility' 'CDF'};


    % Generate times based on selected method
    switch lower(method)
        case 'exponential'
            % Generate probability for refuel time and inter arrival time using exponential function
            [refuel_times,refuel_prob,refuel_cdf] = table(exponential(refuel_range(1), refuel_range(2), lambda));
            [inter_arrival_times,iArriv_prob,iArriv_cdf] = table(exponential(arrival_range(1), arrival_range(2), lambda*1.5));

        case 'lcg'
            % Generate refuel times using LCG
            a = 1664525;
            c = 1013904223;
            [refuel_times,refuel_prob,refuel_cdf] = table(lcgV4(a, c));
            % Generate inter-arrival times with different seed
            [inter_arrival_times,iArriv_prob,iArriv_cdf] = table(lcgV4(a+1, c+1)); % Different parameters for variety

        case 'uniform'
            % Generate probability using uniform function
            [refuel_times,refuel_prob,refuel_cdf] = table(uniform(0.1,1));
            [inter_arrival_times,iArriv_prob,iArriv_cdf] = table(uniform(0.1,1));
        otherwise
            error('Invalid method. Choose "exponential", "lcg", or "uniform".');
    end

    % Display results
    display_table(refuel_table_header,refuel_times,refuel_prob,refuel_cdf);
    display_table(iArriv_table_header,inter_arrival_times,iArriv_prob,iArriv_cdf);
end
