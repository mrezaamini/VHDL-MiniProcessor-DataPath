LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE work.intunit_pack.ALL;

ENTITY miniproc_tb IS  
END miniproc_tb;

ARCHITECTURE behavioral OF miniproc_tb IS
	COMPONENT miniproc IS 
		PORT (
			clk, nrst   : IN    std_logic;
			opcode      : IN    std_logic_vector(3 DOWNTO 0)
		);
	END COMPONENT; 
	SIGNAL opcode_t 	: std_logic_vector(3 DOWNTO 0);
	SIGNAL clk_t 		: std_logic := '0';
	SIGNAL nrst_t 		: std_logic;
	SIGNAL PERIOD 		: TIME := 70 ns;
BEGIN
	
	clk_t <= NOT clk_t AFTER 5 ns;
	read_test_vector_from_file(PERIOD,nrst_t,opcode_t);
	cut: miniproc PORT MAP (clk_t, nrst_t, opcode_t);

END behavioral;
