-- Sean Chow
-- 0931679
-- University of Guelph - CIS 3190 - Assignment #2
-- queensR.adb
-- This file is a recursive solution to the n-Queens problem

with Ada.Text_IO; use Ada.Text_IO;

procedure queensR is
    -- defined a array type 8x8 grid containing integers (1 represents queen, 0 represents free space)
    type game_board is array(1..8, 1..8) of integer;
    board: game_board;
    
    -- variable for output file
    output_file : Ada.Text_IO.File_Type;

    -- procedure to print out the game board
    procedure visual8Queens(board: in game_board) is
    
    begin -- visual8Queens
    -- append to file 
    Open (File => output_file, Mode => Append_File, Name => "queensR.txt");
            

    for i in 1..8 loop
        for j in 1..8 loop
            if (board(i,j)) = 1 then
                put(output_file," Q ");
            else
                put(output_file," . ");
            end if;
            end loop;
            put_line(output_file,"");
        end loop;
    put_line(output_file,"");
    -- close the file
    close(output_file);
    end visual8Queens;

    -- function to determine if the queen can be placed in a certain location
    function checkValidMove(board: in game_board; row: in integer; column: in integer) return boolean is

    diag_counter: integer;
    diag_counter2: integer;

    begin -- checkValidMove
        -- first check the column
        for i in 1..row loop
            if (board(i,column )) = 1 then
                return false;
            end if;
        end loop;

        -- next check the diagonal

        -- reset our counters
        diag_counter := row;
        diag_counter2 := column;

        while diag_counter > 0 and diag_counter2 > 0 loop
            if board(diag_counter,diag_counter2) = 1 then
                return false;
            else
            diag_counter := diag_counter - 1;
            diag_counter2 := diag_counter2 - 1;
            end if;
        end loop;

        -- next check the diagnol in the opposite direction

        -- reset our counters
        diag_counter := row;
        diag_counter2 := column;

        while diag_counter >= 1 and diag_counter2 < 9 loop
            if board(diag_counter,diag_counter2) = 1 then
                return false;
            end if;
            diag_counter := diag_counter - 1;
            diag_counter2 := diag_counter2 + 1;
        end loop;

        -- if all conditions pass, valid spot to put the queen
        return true;

    end checkValidMove;

    -- recursive function tot solve the n queens problem
    -- algorithm cited from https://www.geeksforgeeks.org/printing-solutions-n-queen-problem/

    procedure solve8Queens(board: in out game_board; row: in integer; column: in integer) is

    begin -- solve8Queens

    -- solution found, output the board
    if (column = 1 and row = 9) then
        visual8Queens(board);
    end if;

    -- place queen in each row, and recurse
    for i in 1..8 loop
        if (checkValidMove(board,row,i)) then

            -- place queen in spot
            board(row,i) := 1;

            -- recursive call, increment the row by one and set column back to 1
            solve8Queens(board,row+1,1);

            -- backtrack and remove queen from spot
            board(row,i) := 0;
        end if;
    end loop;

    end solve8Queens;

-- main
begin
    -- set the board contents to 0
    for i in 1..8 loop
            for j in 1..8 loop
                    board(i,j) := 0 ;
            end loop;
        end loop;
    
    -- creat a text file, removes previous one (if it ever existed)
    create(File => output_file, Mode => Out_File, Name => "queensR.txt");
    close(output_file);

    -- call recursive function
    solve8Queens(board,1,1);

end queensR;
