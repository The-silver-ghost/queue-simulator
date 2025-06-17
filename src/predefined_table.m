function predefined_tables()
  
    peak_inter_arrival_data = {
        '1 min', 0.12, '1-12';
        '2 min', 0.16   '13-28';
        '3 min', 0.20   '29-48';
        '4 min', 0.20   '49-68';
        '5 min', 0.12   '69-80';
        '6 min', 0.10   '81-90';
        '7 min', 0.05   '91-95';
        '8 min', 0.05   '96-100';
    };
    
    non_peak_inter_arrival_data = {
        '1 min', 0.08, '1-8';
        '2 min', 0.08, '9-16';
        '3 min', 0.09, '17-25';
        '4 min', 0.09, '26-34';
        '5 min', 0.09, '35-43';
        '6 min', 0.10, '44-53';
        '7 min', 0.11, '54-64';
        '8 min', 0.11, '65-75';
        '9 min', 0.09, '76-84';
        '10 min', 0.09, '85-93';
        '11 min', 0.07, '94-100';
    };
    
    petrol_type_data = {
        'Primax95',      0.5, '1-50';
        'Primax97',      0.4, '51-90';
        'Dynamic Diesel', 0.1, '91-100';
    };
    
    refuel_time_data = {
        '1 min', 0.10, '1-10';
        '2 min', 0.15   '11-25';
        '3 min', 0.22   '26-47';
        '4 min', 0.25   '48-72';
        '5 min', 0.18   '73-90';
        '6 min', 0.10   '91-100';
    };
    
    % Generate all tables
    peak_table = generate_table('PEAK HOURS INTER-ARRIVAL TIME', peak_inter_arrival_data);
    non_peak_table = generate_table('NON-PEAK HOURS INTER-ARRIVAL TIME', non_peak_inter_arrival_data);
    petrol_table = generate_table('PETROL TYPE DISTRIBUTION', petrol_type_data);
    refuel_table = generate_table('REFUEL TIME DISTRIBUTION', refuel_time_data);
    
    % Display tables
    disp(' ');
    disp(peak_table);
    disp(' ');
    disp(non_peak_table);
    disp(' ');
    disp(petrol_table);
    disp(' ');
    disp(refuel_table);
end

function complete_table = generate_table(title, data)
    % GENERATE_TABLE Creates formatted table with CDF
    
    % Calculate CDF
    probabilities = [data{:,2}];
    cdf = cumsum(probabilities);
    
    % Create header
    header = sprintf('%25s %12s %10s %20s\n', title, 'Probability', 'CDF', 'Random number range');
    separator = repmat('-', 1, 72);
    
    % Create rows
    rows = '';
    for i = 1:size(data,1)
        if length(data(i,:)) == 3  % Ensure we have exactly 3 columns
            rows = sprintf('%s%25s %12.2f %12.2f %20s\n', rows, ...
                          data{i,1}, data{i,2}, cdf(i), data{i,3});
        else
            error('Row %d has incorrect number of elements', i);
        end
    end
    
    % Combine everything
    complete_table = sprintf('%s%s\n%s%s', header, separator, rows, separator);
end