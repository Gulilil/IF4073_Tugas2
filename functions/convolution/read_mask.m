function mask_mat = read_mask()
    file_name = "mask.txt";
    content = fopen(file_name,'r');

    mask_mat = [];

    % Read each line until the end of the file
    while ~feof(content)
        % Read a single line from the file
        line = fgetl(content);

        line_list = strsplit(line, ' ');
        
        % Process the line (for example, display it)
        mask_mat = [mask_mat; line_list];
    end
    
    % Close the file after reading
    fclose(content);