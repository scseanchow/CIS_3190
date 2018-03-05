-- Sean Chow
-- 0931679
-- University of Guelph - CIS 3190 - Assignment #2
-- queensNR.adb
-- This file is utility library used for a stack referenced from https://craftofcoding.wordpress.com/2017/02/13/ada-generic-stacks-i/

with Ada.Text_IO; use Ada.Text_IO;
-- stack object, for this question i made it 1..8 integer size (one for each row)
package body gstack is
type list is array(1..8) of integer;
    type ob_stack is
        record
            item : list;
            top : natural := 0;
        end record;
st : ob_stack;

-- function to push an integer to the stack
procedure push(x : in integer) is
    begin
        if st.top = 8 then -- max limit for this usage
            return;
        else
            st.top := st.top + 1;
            st.item(st.top) := x;
        end if;
end push;

-- function to pop an integer off the stack
procedure pop(x : out integer) is
    begin
        if st.top = 0 then
        put_line("stack is empty");
    else
        x := st.item(st.top);
        st.top := st.top - 1;
end if;
end pop;

-- function to return an integer off the stack_top
function stack_top return integer is
    begin
        return st.item(st.top);
end stack_top;

-- function to return the size of the stack
function get_size return integer is
    begin
        return st.top;
end get_size;

-- function to return the get the index of the stack
function get_index(index: integer) return integer is
    begin 
        return st.item(index);
end get_index;

end gstack;