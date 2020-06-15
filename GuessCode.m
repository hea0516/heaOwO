% My homework long time ago /w\
% It is a game similar to mastermind
% The computer randomly generate secret code and provide infomation for user to guess

aga = 'y';
while aga == 'y'
    r = input('Input the number of rows: ');
    c = input('Input the number of columns: ');
    m = input('Input the max number: ');
    g = input('Input the max number of guesses: ');
    guess = 1;
    win = 0;
    %Get information from user

    n = eye(r,c);
    temp = randperm(m,r*c);
    % use function randperm to generate an array of random integers
    % that have no repeated values
    for i =1:r*c
        n(i) = temp(i);
    end
    % n is the secret code

    d = input('Display the secret code for testing (y/n)?','s');
    if d=='y'
        disp('Secret Code:');
        disp(n);
    end
    %Display the secret code generated if the user want
    
    
    result = zeros(1,m);
    for i=1:r*c
        result(n(i)) = i;
    end
    % result is to indicate the numbers appear in sercet code with the
    % correct index

    while(win == 0 && guess <= g)
        disp(['Guess ', num2str(guess), ':']);
        % display the number of guessing time
        code = input('Input your guess: ');
        % ask user to guess the secret code

        appear = 0;
        corr = 0;
        row = 0;
        crow = 0;
        col = 0;
        ccol = 0;

        for i = 1:r*c

            if result(code(i)) ~= 0
                appear = appear + 1;
            end
            % check the number of entries appear in the secret code

            if code(i)== n(i)
                corr = corr + 1;
            end
            % check the number of entries at the correct position

            for j = 1:r*c
                if (mod(i,r) == mod(j,r))
                    if (n(j) == code(i))
                        crow = crow + 1;
                    end
                end
            end
            row = crow - corr;
            % check the number of entries at the correct row but not correct 
            % position

            s = r*(ceil(i/r)-1)+1;
            for k = s:s+r-1
                if n(k) == code(i)
                    ccol = ccol + 1;
                end
            end
            col = ccol - corr;
            % s:s+r-1 is the column of the guess code appear
            % check the number of entries at the correct column but not correct
            % position

        end

        if corr == c*r
            win = 1;
        else
            disp(['The number of entries appear in the secret code: ', num2str(appear)]);
            disp(['The number of entries at the correct position: ', num2str(corr)]);
            disp(['The number of entries at the correct row, but not at the correct position: ', num2str(row)]);
            disp(['The number of entries at the correct column, but not at the correct position: ',num2str(col)]);
        end
        guess = guess + 1;

    end

    if win == 1
        disp('Correct answer.');
    else
        disp('Exceed the max number of guesses.');
        disp('You lost.')
    end

    aga = input('Try again (y/n)? ','s');

end

