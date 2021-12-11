LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD_UNSIGNED.ALL;
ENTITY sram IS
    GENERIC (
        N : INTEGER := 6;
        M : INTEGER := 32);
    PORT (
        clk : IN STD_LOGIC;
	NRST : IN STD_LOGIC;
        we : IN STD_LOGIC;
        adr : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        din : IN STD_LOGIC_VECTOR(M - 1 DOWNTO 0);
        dout : OUT STD_LOGIC_VECTOR(M - 1 DOWNTO 0));
END;

ARCHITECTURE synth OF sram IS
    TYPE mem_array IS ARRAY ((2 ** N - 1) DOWNTO 0)
    OF STD_LOGIC_VECTOR (M - 1 DOWNTO 0);
    SIGNAL mem : mem_array;

    IMPURE FUNCTION INITMEM RETURN mem_array IS
	variable myVar :  mem_array;

	BEGIN
    for i in 0 to (2 ** N - 1)-1 loop
        myVar(i) := X"00000001";
    end loop ; -- identifier
	RETURN myVar;
    END FUNCTION INITMEM;

BEGIN
    PROCESS (clk) BEGIN
	IF NRST='0' THEN 
		MEM<=INITMEM;
	END IF;
        IF rising_edge(clk) THEN
            IF we = '1' THEN
                mem(TO_INTEGER(adr)) <= din;
            END IF;
        END IF;
    END PROCESS;
    dout <= mem(TO_INTEGER(adr));
END;