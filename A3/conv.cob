*> 0931679 - Sean Chow
*> CIS 3190 - A3
*> conv.cob 
*> March 23rd, 2018
*> this file holds the algorithm to convert roman numeral to decimal

identification division.
program-id. conv.
environment division.
input-output section.
file-control. 
    select standard-output assign to display.

data division.
file section.
fd standard-output. 
    01 stdout-record picture x(80).

working-storage section.
77 i picture s99 usage is computational.
77 valid-roman picture s99 usage is computational.
77 prev picture s9(8) usage is computational.
77 d picture s9(4) usage is computational.
77 sum1 picture 9(8) usage is computational.
linkage section.
77 user-input picture x(30).
01 string-length picture 9(2) value 0.              

procedure division using user-input, string-length.
    
    *> reset our variables
    move 0 to sum1.
    move 1001 to prev.
    move 0 to valid-roman

    *> for loop which iterates through every character of the string
    perform varying i from 1 by 1 until i is greater than string-length

        *> if/else block for every possible roman character
        *> algorithm modified from source code 
        *> https://courselink.uoguelph.ca/content/enforced/492028-CIS_3190_DE_W18/Assignments/W18/A3_conv.pdf?_&d2lSessionVal=KOW4roXg9V56JKaoBrlgwvurp&ou=492028
        *> looks at individual character, if equal then adds to sum. if the previous character is greater than the roman numeric value does subtraction instead
        if user-input(i:1) is equal to 'I'
            move 1 to d
            add d to sum1
            if d > prev
                compute sum1 = sum1 - 2 * prev
            end-if
            move d to prev
        else if user-input(i:1) is equal to 'V'
            move 5 to d
            add d to sum1
            if d > prev
                compute sum1 = sum1 - 2 * prev
            end-if
            move d to prev
        else if user-input(i:1) is equal to 'X'
            move 10 to d
            add d to sum1
            if d > prev
                compute sum1 = sum1 - 2 * prev
            end-if
            move d to prev
        else if user-input(i:1) is equal to 'L'
            move 50 to d
            add d to sum1
            if d > prev
                compute sum1 = sum1 - 2 * prev
            end-if
            move d to prev
        else if user-input(i:1) is equal to 'C'
            move 100 to d
            add d to sum1
            if d > prev
                compute sum1 = sum1 - 2 * prev
            end-if
            move d to prev
        else if user-input(i:1) is equal to 'D'
            move 500 to d
            add d to sum1
            if d > prev
                compute sum1 = sum1 - 2 * prev
            end-if
            move d to prev
        else if user-input(i:1) is equal to 'M'
            move 1000 to d
            add d to sum1
            if d > prev
                compute sum1 = sum1 - 2 * prev
            end-if
            move d to prev
        *> there is an in-correct character in the roman numeral
        *> set our invalid flag
        else
            move 1 to valid-roman
        end-if

    end-perform.

    *> if a valid roman numeral was inputted, output the sum
    if valid-roman is equal to 0
        display "Roman Numeral = " user-input "Decimal Form = " sum1
    *> error was found in input, print statement to user
    else 
        display "Invalid roman numeral try again!"
    end-if.
