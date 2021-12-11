library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
PACKAGE intunit_pack IS  

    PROCEDURE read_test_vector_from_file (
                    SIGNAL pr : IN  TIME; 
                    SIGNAL r : OUT std_logic;
                    SIGNAL opcode : OUT std_logic_vector(3 downto 0));
END PACKAGE intunit_pack;

PACKAGE BODY intunit_pack IS  
    PROCEDURE read_test_vector_from_file (
                    SIGNAL pr : IN  TIME; 
                    SIGNAL r : OUT std_logic;
                    SIGNAL opcode : OUT std_logic_vector(3 DOWNTO 0) ) IS
        TYPE myfile IS FILE OF character;
        FILE fp : myfile;
        VARIABLE c : character;
        VARIABLE current_time : TIME := 3 ns;
        VARIABLE line_number : integer := 1;
    BEGIN
        FILE_OPEN(fp, "myinput.txt", READ_MODE);
       -- ignore line 1
      FOR i IN 0 TO 9 LOOP
       READ(fp, c);  
      END LOOP;

       -- ignore line 2
       FOR i IN 0 TO 9 LOOP
        READ(fp, c);
      END LOOP;       
       
      for col in 0 to 11 loop

            -- Read r
            READ(fp, c);
            IF c = '0' THEN
                r <= TRANSPORT '0' AFTER current_time;
            ELSE
                r <= TRANSPORT '1' AFTER current_time;
            END IF;

            READ(fp, c);
            
            -- Read OPCODE
            FOR i IN 0 TO 3 LOOP
                READ(fp, c);   
                IF c = '0' THEN
                    opcode(3-i) <= TRANSPORT '0' AFTER current_time;
                ELSE
                    opcode(3-i) <= TRANSPORT '1' AFTER current_time;
                END IF;
            END LOOP;

            READ(fp, c);
            -- Read carriage return
            READ(fp, c);
            -- Read line feed
            current_time := current_time + pr;
            line_number := line_number + 1;
       END LOOP;
      FILE_CLOSE(fp);
    END read_test_vector_from_file;
END PACKAGE BODY intunit_pack;
                    
                    
