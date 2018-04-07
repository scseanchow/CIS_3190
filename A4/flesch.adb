--  Sean Chow
--  0931679
-- University of Guelph - CIS 3190 - Assignment #4
-- flesch.adb
-- This file is the Flesch readability algorithm 

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics; use Ada.Numerics;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;

procedure flesch is
    file : file_type;
    input_line : Unbounded_String;
    letter : character;
    vowel_counter : integer;
    word_counter : integer;
    sentence_counter : integer;
    suffix_lookup : integer;
    flesch_index : float;
    file_name : string(1 .. 15);
    Last : natural;

    -- function to calculate the flesch grade level, returns a float
    function fleschGradeLevel(word_counter: in integer; sentence_counter: in integer; vowel_counter: in integer) return float is
    
    grade_level_float : float;

    begin -- fleschGradeLevel
        grade_level_float := (0.39 * (float(word_counter) / float(sentence_counter))) + 11.8 * ((float(vowel_counter) / float(word_counter))) - 15.59;
        return grade_level_float;
    end fleschGradeLevel;

begin   
    
    -- user prompt for file name
    put_Line("Enter the file name:");
    get_line(file_name,last);
    file_name := trim(file_name,Right);
    open(file,in_file,file_name);

    -- set our vars to 0
    word_counter := 0;
    vowel_counter := 0;
    sentence_counter := 0;
    suffix_lookup := 0;

    -- loop through file line by line
    loop
        exit when end_of_file(File);
        get_line(file,input_line);
        -- add one to word counter because of first word not being counted per line
        word_counter := word_counter + 1;

        -- loop through file character by character
        for i in 1..length(input_line) loop
            letter := element(input_line, i);
            if (letter = 'a' or letter = 'e' or letter = 'i' or letter = 'o' or letter = 'u') then
                
                vowel_counter := vowel_counter + 1;

                -- check the suffix of the word (ES, ED, E)
                -- check for es
                suffix_lookup := i + 2;
                if (suffix_lookup <= length(input_line)) then
                    if ((element(input_line,i) = 'e') and (element(input_line,i+1) = 's' )) then
                        vowel_counter := vowel_counter -1;
                    end if;
                end if;
                -- check for ed
                if (suffix_lookup <= length(input_line)) then
                    if ((element(input_line,i) = 'e') and (element(input_line,i+1) = 'd' )) then
                        vowel_counter := vowel_counter -1;
                    end if;
                end if;
                -- check for e
                if (suffix_lookup <= length(input_line)) then
                    if ((element(input_line,i) = 'e') and not is_letter(element(input_line,i+1))) then
                        vowel_counter := vowel_counter -1;
                    end if;
                end if;
                -- check for duplicates
                if (suffix_lookup <= length(input_line)) then
                    if (element(input_line,i) = element(input_line,i+1)) then
                        vowel_counter := vowel_counter -1;
                    end if;
                end if;
            
            -- if encounter a space, it is a word
            elsif (letter = ' ') then
                word_counter := word_counter + 1;
            -- punctuation means end of sentence
            elsif (letter = '.' or letter = '!' or letter = '?') then
                sentence_counter := sentence_counter + 1;
            end if;
        end loop;
    end loop;

    -- calculate the flesch index
    flesch_index := 206.835 - (1.015 * Float(word_counter) / Float(sentence_counter) + 84.6 * Float(vowel_counter) / Float(word_counter));
    
    -- output the summary 
    put_line("Flesch Index:");
    put(flesch_index,2,0,0);
    put_line("");
    put_line("Flesch Grade Level:");
    put(fleschGradeLevel(word_counter,sentence_counter,vowel_counter),2,0,0);
    put_line("");
    
end flesch;