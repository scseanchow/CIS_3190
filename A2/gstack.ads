-- Sean Chow
-- 0931679
-- University of Guelph - CIS 3190 - Assignment #2
-- queensNR.adb
-- This file is the header for a library used for a stack referenced from https://craftofcoding.wordpress.com/2017/02/13/ada-generic-stacks-i/

package gstack is
    procedure push(x : in integer);
    procedure pop(x : out integer);
    function get_size return integer;
    function stack_top return integer;
    function get_index(index: integer) return integer;
end gstack;