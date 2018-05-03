function matrix = zigzag(n,a)
    %This is very unintiutive. This algorithm parameterizes the
    %zig-zagging movement along the matrix indicies. The easiest way to see
    %what this algorithm does is to go through line-by-line and write out
    %what the algorithm does on a peace of paper. 
    % n=16;
    matrix = zeros(1,256);
    counter = 2;
    flipCol = true;
    flipRow = false;
 
    %This for loop does the top-diagonal of the matrix
    matrix(1,1)=a(1,1);
    for i = (2:n)
        row = (1:i);
        column = (1:i);
 
        % Causes the zig-zagging. Without these conditionals, you would end 
        % up with a diagonal matrix. To see what happens comment these conditionals out.         
        if flipCol
            % ·­×ª
            column = fliplr(column);
            flipRow = true;
            flipCol = false;
        elseif flipRow
            row = fliplr(row);
            flipRow = false;
            flipCol = true;           
        end
 
        %Selects a diagonal of the zig-zag matrix and places the correct
        %integer value in each index along that diagonal
        for j = (1:numel(row))
            matrix(1,counter) = a(row(j),column(j));
            counter = counter + 1;
        end   
    end
 
    %This for loop does the bottom-diagonal of the matrix
    for i = (2:n)
        row = (i:n);
        column = (i:n);
 
        %Causes the zig-zagging. Without these conditionals, you would end 
        %up with a diagonal matrix. To see what happens comment these conditionals out. 
        if flipCol
            column = fliplr(column);
            flipRow = true;
            flipCol = false;
        elseif flipRow
            row = fliplr(row);
            flipRow = false;
            flipCol = true;           
        end
 
        %Selects a diagonal of the zig-zag matrix and places the correct
        %integer value in each index along that diagonal
        for j = (1:numel(row))
            matrix(1,counter) = a(row(j),column(j));
            counter = counter + 1;
        end   
    end
end