program tictactoe
    implicit none
    integer :: inputVal
    do 
        write(*,*) 
        write(*,*) '+---------------------------------------------+'   
        write(*,*) '| Play Tic-Tac-Toe. Enter 1-9 To Play         |'
        write(*,*) '| Enter any other number else to exit program |'
        write(*,*) '+---------------------------------------------+'   
        write(*,*) 
        write(*,*) ' 1 | 2 | 3 '
        write(*,*) '---+---+---'
        write(*,*) ' 4 | 5 | 6 '
        write(*,*) '---+---+---'
        write(*,*) ' 7 | 8 | 9 '
        write(*,*) 
        read(*,*) inputVal
            if (inputVal < 10 .and. inputVal > 0) then
                call playTicTacToe()
            else 
                write(*,*) 'Exiting Program'
                exit 
            endif
    end do
end

! getMove subroutine, validates user input and returns an integer for their move
subroutine getMove(move)
    implicit none
    integer :: move
    do
        write(*,*) 'Enter a move between 1-9:'
        read(*,*) move
        if (move < 10 .and. move > 0) exit
            write(*,*) 'Error, try again'
    end do
    return
end

! showBoard subroutine, displays the current board game state to the user
subroutine showBoard(board_array)
    implicit none
    character, dimension(3,3) :: board_array
    integer :: x, y
    character(len=50) :: board_format

    board_format = "(2X,A1,1X,'|',1X,A1,1X,'|',1X,A1,2X)"

    do x = 1,3
        write(*,board_format) (board_array(x,y), y=1,3)
        if (x < 3) then
            write(*,*) "---+---+---"
        endif
    end do

    return
end

logical function same(unit1,unit2,unit3)
    implicit none
    character * 1 :: unit1, unit2, unit3
    if (unit1 == unit2 .and. unit2 == unit3 .and. unit1 == unit3) then
        same = .TRUE.
    else 
        same = .FALSE.
    end if
end function same

logical function CHKPLAY(move, board_array)
    character, dimension(3,3) :: board_array
    integer :: move

    if (move == 1 .and. board_array(1,1) == " ") then
        CHKPLAY = .TRUE.
    else if (move == 2 .and. board_array(1,2) == " ")  then
        CHKPLAY = .TRUE.
    else if (move == 3 .and. board_array(1,3) == " ")  then
        CHKPLAY = .TRUE.
    else if (move == 4 .and. board_array(2,1) == " ")  then
        CHKPLAY = .TRUE.
    else if (move == 5 .and. board_array(2,2) == " ")  then
        CHKPLAY = .TRUE.
    else if (move == 6 .and. board_array(2,3) == " ")  then
        CHKPLAY = .TRUE.
    else if (move == 7 .and. board_array(3,1) == " ")  then
        CHKPLAY = .TRUE.
    else if (move == 8 .and. board_array(3,2) == " ")  then
        CHKPLAY = .TRUE.
    else if (move == 9 .and. board_array(3,3) == " ")  then
        CHKPLAY = .TRUE.
    else
        CHKPLAY = .FALSE.
    end if
end function CHKPLAY


subroutine CHKOVR(board_array, winner)
    implicit none
    character, dimension(3,3) :: board_array
    integer :: row, column
    logical :: same, dsame, over
    character * 1 :: winner, blank, draw

    parameter (blank = ' ', draw = 'D')

    ! check all rows first
    do row = 1,3
        if (same(board_array(row,1),board_array(row,2),board_array(row,3))) then
            winner = board_array(row,1)
            return
        endif
    end do

    ! check columns
    do column = 1,3
        if (same(board_array(1,column),board_array(2,column),board_array(3,column))) then
            winner = board_array(1,column)
            return
        endif
    end do


    ! check diagonal
    dsame = same(board_array(1,1),board_array(2,2),board_array(3,3)) & 
        .OR. same(board_array(1,3),board_array(2,2),board_array(3,1)) 
    if (dsame) THEN
        winner = board_array(2,2)
        return
    endif

    ! check for draw
    do row = 1,3
        do column = 1,3
        if (board_array(row,column) == blank) then
            return
        end if
        end do
    end do
    
    ! all spaces are occupied, determine draw
    winner = DRAW

    return
end subroutine CHKOVR

! pickMOve subroutine, controls the computers move
subroutine pickMove(board_array)
    implicit none
    character, dimension(3,3) :: board_array
    integer :: sum, row, col, randomize_number_col, randomize_number_row


    ! first check the columns for a valid win
    do col = 1,3
        ! set sum to 0 on every loop execution 
        sum = 0 
        if (board_array(1,col) == 'O') sum = sum + 4
        if (board_array(2,col) == 'O') sum = sum + 4
        if (board_array(3,col) == 'O') sum = sum + 4
        if (board_array(1,col) == 'X') sum = sum + 1
        if (board_array(2,col) == 'X') sum = sum + 1
        if (board_array(3,col) == 'X') sum = sum + 1
        ! computer has a win on this column, find the one that it needs to fill
        if (sum == 8) then 
            if (board_array(1,col) == ' ') then 
                board_array(1,col) = 'O'
                return
            else if (board_array(2,col) == ' ') then 
                board_array(2,col) = 'O'
                return
            else
                board_array(3,col) = 'O'
                return
            endif
        end if
    end do

    ! checking diagonal paths
    sum = 0
    if (board_array(1,1) == 'O') sum = sum + 4
    if (board_array(2,2) == 'O') sum = sum + 4
    if (board_array(3,3) == 'O') sum = sum + 4
    if (board_array(1,1) == 'X') sum = sum + 1
    if (board_array(2,2) == 'X') sum = sum + 1
    if (board_array(3,3) == 'X') sum = sum + 1

    ! computer has a win on the diagnol, find the one that it needs to fill
    if (sum == 8) then 
        if (board_array(1,1) == ' ') then 
            board_array(1,1) = 'O'
            return
        else if (board_array(2,2) == ' ') then 
            board_array(2,2) = 'O'
            return
        else
            board_array(3,3) = 'O'
            return
        endif
    
    
    ! player has a win on this diagonal, find the one that it needs to block
    else if (sum == 2) then 
        if (board_array(1,1) == ' ') then 
            board_array(1,1) = 'O'
            return
        else if (board_array(2,2) == ' ') then 
            board_array(2,2) = 'O'
            return
        else
            board_array(3,3) = 'O'
            return
        endif
    end if

    ! check the rows for a valid win
    do row = 1,3
        
        sum = 0

        if (board_array(row,1) == 'O') sum = sum + 4
        if (board_array(row,2) == 'O') sum = sum + 4
        if (board_array(row,3) == 'O') sum = sum + 4
        if (board_array(row,1) == 'X') sum = sum + 1
        if (board_array(row,2) == 'X') sum = sum + 1
        if (board_array(row,3) == 'X') sum = sum + 1
        ! computer has a win on this row, find the one that it needs to fill
        if (sum == 8) then 
            if (board_array(row,1) == ' ') then 
                board_array(row,1) = 'O'
                return
            else if (board_array(row,2) == ' ') then 
                board_array(row,2) = 'O'
                return
            else
                board_array(row,3) = 'O'
                return
            endif
        end if
    end do

    ! check the rows for a valid block
    do row = 1,3
        
        sum = 0

        if (board_array(row,1) == 'X') sum = sum + 1
        if (board_array(row,2) == 'X') sum = sum + 1
        if (board_array(row,3) == 'X') sum = sum + 1
        if (board_array(row,1) == 'O') sum = sum + 4
        if (board_array(row,2) == 'O') sum = sum + 4
        if (board_array(row,3) == 'O') sum = sum + 4

        ! player has a win on this row, find the one that it needs to block
        if (sum == 2) then 
            write(*,*) 'block row'
            if (board_array(row,1) == ' ') then 
                board_array(row,1) = 'O'
                return
            else if (board_array(row,2) == ' ') then 
                board_array(row,2) = 'O'
                return
            else if (board_array(row,3) == ' ') then 
                board_array(row,3) = 'O'
                return
            endif
        end if
    end do

    ! check the columns for a valid block
    do col = 1,3
        sum = 0
        if (board_array(1,col) == 'X') sum = sum + 1
        if (board_array(2,col) == 'X') sum = sum + 1
        if (board_array(3,col) == 'X') sum = sum + 1
        if (board_array(1,col) == 'O') sum = sum + 4
        if (board_array(2,col) == 'O') sum = sum + 4
        if (board_array(3,col) == 'O') sum = sum + 4
        ! player has a win on this column, find the one that it needs to block
        if (sum == 2) then 
            write(*,*) 'block col'
            if (board_array(1,col) == ' ') then 
                board_array(1,col) = 'O'
                return
            else if (board_array(2,col) == ' ') then 
                board_array(2,col) = 'O'
                return
            else if (board_array(3,col) == ' ') then 
                board_array(3,col) = 'O'
                return
            endif
        end if
    end do

    ! finally, randomize a spot to put a random move
    do 
        randomize_number_col = int(RAND(0)*3)+1
        randomize_number_row = int(RAND(0)*3)+1
        if (board_array(randomize_number_col, randomize_number_row) == ' ') then
            board_array(randomize_number_col, randomize_number_row) = 'O'
            write(*,*) 'rando'
            return
        endif
    end do
end subroutine pickMove

! playTicTacToe subroutine, plays the game
subroutine playTicTacToe()
    implicit none
    logical :: user_move, CHKPLAY
    integer :: move_number, x, y
    character, dimension(3,3) :: board_array
    character * 1 :: winner

    user_move = .TRUE.

    ! initialize the board to all blank 
    do x = 1,3
        do y = 1,3
            board_array(x,y) = ' '
        end do
    end do


    ! main game loop
    do
        ! human's move
        if (user_move) then
            user_move = .FALSE.

            ! loop to get user input, while validating the space isn't occupied
            do
                call getMove(move_number)
                if (CHKPLAY(move_number,board_array)) exit    
                write(*,*) 'ERROR: Board space is occupied'     
            end do       

            ! fill in the user's move on board
            select case (move_number)
                case  (1)
                    board_array(1,1) = 'X'
                case  (2)
                    board_array(1,2) = 'X'
                case  (3)
                    board_array(1,3) = 'X'
                case  (4)
                    board_array(2,1) = 'X'
                case  (5)
                    board_array(2,2) = 'X'
                case  (6)
                    board_array(2,3) = 'X'
                case  (7)
                    board_array(3,1) = 'X'
                case  (8)
                    board_array(3,2) = 'X'
                case  (9)
                    board_array(3,3) = 'X'
            end select 

            ! print out game board state after player move (your is human)
            write(*,*) 'After your move...'
            call showBoard(board_array)

            ! check for winner of game
            call CHKOVR(board_array, winner)
            if (winner == 'X') then
                write(*,*) 'You win!'
                exit
            else if (winner == 'O') then
                write(*,*) 'You Lose!'
                exit
            else if (winner == 'D') then
                write(*,*) 'Draw Game!'
                exit
            end if

        ! computers move     
        else
            user_move = .TRUE.
            ! print out game board state after computer move (my is cpu)
            call pickMove(board_array)
            write(*,*) 'After my move...'
            call showBoard(board_array)

            ! check for winner of game
            call CHKOVR(board_array, winner)
            if (winner == 'X') then
                write(*,*) 'You win!'
                exit
            else if (winner == 'O') then
                write(*,*) 'You Lose!'
                exit
            else if (winner == 'D') then
                write(*,*) 'Draw Game!'
                exit
            end if
        endif
    end do
end subroutine playTicTacToe
