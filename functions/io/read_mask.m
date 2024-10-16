function [mask_mat, n] = read_mask()
    file_name = "mask.txt";
    content = fopen(file_name,'r');

    mask_mat = [];
    n = 0;
    % Read each line until the end of the file
    while ~feof(content)
        % Read a single line from the file
        line = fgetl(content);

        line_list = strsplit(line, ' ');
        
        % Process the line (for example, display it)
        mask_mat = [mask_mat; str2double(line_list)];

        n = n + 1;
    end
    
    % Close the file after reading
    fclose(content);