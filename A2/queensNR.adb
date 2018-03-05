-- Sean Chow
-- 0931679
-- University of Guelph - CIS 3190 - Assignment #2
-- queensNR.adb
-- This file is a non-recursive solution to the n-Queens problem


with Ada.Text_IO; use Ada.Text_IO;
with gstack; use gstack;

procedure queensNR is
    -- defined a array type 8x8 grid containing integers (1 represents queen, 0 represents free space)
    type game_board is array(1..8, 1..8) of integer;
    board: game_board;

    -- variable for output file
    output_file : Ada.Text_IO.File_Type;

    -- procedure to print out the game board
    procedure visual8Queens(board: in game_board) is
    
    begin 
    -- append to file 
    Open (File => output_file, Mode => Append_File, Name => "queensNR.txt");
            

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

	function checkValidMove return boolean is
	row : integer; 
	column : integer;
    index: integer;

	begin

        row := gstack.stack_top;
        column := gstack.get_size;
        
        -- if the last queen is beyond the chess board (8x8) return false
        if row > 7 then
            return false;
        end if;

		-- loop through all queens and check validity
		for i in 1..gstack.get_size-1 loop

            index := gstack.get_index(i);

			-- check if one of the queens is on the same diag
			if abs(row-index) = abs(column-i) then
				return false;
			end if;

			-- check if one of the queens is on  same row
			if row = index then
				return false;
			end if;
		end loop;
		
        -- if no incorrect move, then return true
        return true;
		
	end checkValidMove;


    -- the back tracking algorithm for solving the N queens problem iteratively
    procedure solve8Queens(board: in out game_board) is

	more_solutions : boolean;
	row : integer;
    column: integer;
    last_piece: integer;

	begin 
        last_piece := 7;
        -- set the contents of the board to 0
        for i in 1..8 loop  
            for j in 1..8 loop
                board(i,j) := 0;
            end loop;
        end loop;

        -- start off with queen in top left corner
		gstack.push(0);

        -- set while loop to true
        more_solutions := true;

		-- loop still all solutions are found
		while more_solutions = true loop
			if checkValidMove = false then
            
				-- hold the last row in temp variable
				row := gstack.stack_top;
				
				-- if row is outside of the board backtrack to valid piece
				if row > 7 then
                    -- loop until all queens have been placed
					while gstack.stack_top >= 7 loop
						-- if all solutions have not been found
						if gstack.get_size > 1 then
							-- last added piece is causing conflict
                            -- backtrack to last step which was correct and solve next sub-problem
							gstack.pop(last_piece);
							row := gstack.stack_top;
							gstack.pop(last_piece);
							gstack.push(row + 1);
							row := gstack.stack_top;
						else
                            -- stack is empty, all queens placed
							more_solutions := false;
							exit when more_solutions = false;
						end if;
					end loop;
				else
					gstack.pop(last_piece);
					gstack.push(row+1);
				end if;

			-- if last placed queen is valid
			else
				-- solution has been found
				if gstack.get_size = 8 then

					-- set the contesnts of the board to 0
                    for i in 1..8 loop
                        for j in 1..8 loop
                            board(i,j) := 0;
                        end loop;
                    end loop;

					-- place pieces on board
                    column := 1;

					for i in 1..gstack.get_size loop
                        board(column, gstack.get_index(i)+1) := 1;
                        column := column +1;
                    end loop;
                    
                    -- print out the board to text file
					visual8Queens(board);

					-- continue to find solutions if any
					row := gstack.stack_top;
					gstack.pop(last_piece);
					gstack.push(row + 1);

				-- if no solutions move to next column
				else
					gstack.push(0);
				end if;
			end if;
		end loop;
	end solve8Queens;

begin 
    -- creat a text file, removes previous one (if it ever existed)
    create(File => output_file, Mode => Out_File, Name => "queensNR.txt");
    close(output_file);
    -- start 
	solve8Queens(board);
end queensNR;
