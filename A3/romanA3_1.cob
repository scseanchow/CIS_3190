*> 0931679 - Sean Chow
*> CIS 3190 - A3
*> romanA3_1.cob 
*> March 23rd, 2018
*> this file is the driver for the roman number convertor

identification division.
program-id. romannumerals.
environment division.
input-output section.
file-control.
select standard-input assign to keyboard.
select standard-output assign to display.
select roman-file
assign to roman-file-name
organization is line sequential.

data division.
file section.
fd standard-input.
01 stdin-record picture X(80).
fd standard-output.
01 stdout-record picture X(80).
fd  roman-file.
01 roman-file-record picture X(20). 

working-storage section.
77 i  picture s99 usage is computational.
77 file_found picture 9(1) value 0.
77 temp picture s9(8) usage is computational.
77 user-input picture x(30) value " ".
77 count-of-trailing-spaces picture 9(4).
77 string-length picture 9(2).
01 formatted-integer picture z(04)9.
01 roman-file-name picture x(64) VALUE ' '.
01 ws-eof picture a(1).

procedure division.
    *> open input/output so we can write to the screen and get user input
    open input standard-input, output standard-output.
    *> print out the header text
    display " ".
    display "Enter a filename (.txt) to convert, or enter a roman numeral to be converted".
    display "type q to quit".
    display "-------------ROMAN NUMERAL CONVERTER---------------".

    *> "while" loop until user types in Q or q
    perform until user-input is equal to 'q' or is equal to 'Q'
        display "Enter a roman numeral or text file:"
        read standard-input into user-input
        
        *> reset our variables
        move 0 to file_found
        move 0 to string-length
        move 0 TO count-of-trailing-spaces                                     
        move 0 to i 


        *> get length of string
        *> referenced from: https://stackoverflow.com/questions/24777344/compute-length-string-of-variable-with-cobol
        *> reverses the string and then finds the location of leading space
        inspect function reverse (user-input)                       
            tallying count-of-trailing-spaces                                        
            for leading space
        
        *> calculate the length of string
        subtract count-of-trailing-spaces                                     
            from length of user-input
            giving string-length
        
        *> "for" loop over the string and look for a . signfying text file
        perform varying i from 1 by 1 until i > string-length
            if user-input(i:1) = '.'
                move 1 to file_found
            end-if
        end-perform

        *> if a file is found
        if file_found = 1

            move 0 to string-length

            *> set it to some random letter
            move 'X' to ws-eof
            
            *> set our file name to user input
            move user-input to roman-file-name

            *> open the file
            open input roman-file

            *>for loop untill eof
            perform until ws-eof = 'Y'
                read roman-file into roman-file-record
                *> at end of file, break out of our loop
                at end 
                    move 'Y' to ws-eof
                
                *> functionality that runs on every line being read in
                not at end
                
                    move roman-file-record to user-input
                    move 0 to string-length
                    move 0 TO count-of-trailing-spaces                                     
                    move 0 to i 

                    *> get length of string
                    inspect function reverse (user-input)                       
                        tallying count-of-trailing-spaces                                        
                        for leading space
                    
                    subtract count-of-trailing-spaces                                     
                        from length of user-input
                        giving string-length
                    
                    perform varying i from 1 by 1 until i > string-length
                        if user-input(i:1) = '.'
                            move 1 to file_found
                        end-if
                    end-perform
                    
                    *> force uppercase
                    move function upper-case(user-input) to user-input 

                    if string-length < 1
                        display "Invalid input try again!"
                    end-if

                    *> call our convert function
                    call "conv" using user-input, string-length
                end-read
            end-perform
            close roman-file

        *> regular user input
        else if file_found = 0
            *> force uppercase and call convert function
            move function upper-case(user-input) TO user-input 

            if string-length < 1
                display "Invalid input try again!"
            end-if

            call "conv" using user-input, string-length

    end-perform.
