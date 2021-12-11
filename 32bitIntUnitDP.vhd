LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.numeric_std.ALL;
ENTITY miniproc IS
	PORT (
		clk, nrst : IN STD_LOGIC;
		opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END miniproc;

ARCHITECTURE behavioral OF miniproc IS
	TYPE state IS (T0, T1, T2, T3, T4, T5);
	SIGNAL cur_state, nxt_state : state;
	-- Control signals
	SIGNAL LD_CW : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL we : STD_LOGIC;
	SIGNAL cbus : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL func : STD_LOGIC_VECTOR(2 DOWNTO 0); -- changged to 3-bit
	SIGNAL Z : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MEMOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
	-- Registers
	SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL C : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL D : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ACC : STD_LOGIC_VECTOR(31 DOWNTO 0);

	COMPONENT sram
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
	END COMPONENT;

BEGIN

	mySram : sram PORT MAP(clk,nrst, we, A(5 DOWNTO 0), cbus, MEMOUT);
	cbus <= MEMOUT WHEN sel = "00" ELSE -- change to RAM
		B WHEN sel = "01" ELSE
		ACC WHEN sel = "10" ELSE
		(OTHERS => 'Z');

	z <= C + D WHEN func = "000" ELSE
		D - C WHEN func = "001" ELSE
		STD_LOGIC_VECTOR(shift_left(unsigned(D), to_integer(unsigned(C(4 DOWNTO 0))))) WHEN func = "010" ELSE
		C XOR D WHEN func = "011" ELSE
		C AND D WHEN func = "100" ELSE
		C WHEN func = "101" ELSE
		D;

	controlpath : PROCESS (cur_state, opcode)
	BEGIN
		LD_CW <= "00000";
		CASE cur_state IS
				------------------------------------------------------------
			WHEN T0 =>
				CASE opcode IS
					WHEN "0000" => sel <= "11";
						LD_CW <= "00001";
						func <= "101";
						we <= 'Z';
						nxt_state <= T0;
					WHEN "0001" => sel <= "11";
						LD_CW <= "00001";
						func <= "110";
						we <= 'Z';
						nxt_state <= T0;
					WHEN "0010" => sel <= "11";
						LD_CW <= "00001";
						func <= "000";
						we <= 'Z';
						nxt_state <= T0;
					WHEN "0011" => sel <= "01";
						LD_CW <= "00010";
						func <= "100";
						we <= 'Z';
						nxt_state <= T1;
					WHEN "0100" => sel <= "01";
						LD_CW <= "00010";
						func <= "011";
						we <= 'Z';
						nxt_state <= T1;
					WHEN "0101" => sel <= "00";
						LD_CW <= "00100";
						func <= "101";
						we <= '0';
						nxt_state <= T1;
					WHEN "0110" => sel <= "10";
						LD_CW <= "00000";
						func <= (OTHERS => 'Z');
						we <= '1';
						nxt_state <= T0;
					WHEN "0111" => sel <= "01";
						LD_CW <= "10000";
						func <= "101";
						we <= 'Z';
						nxt_state <= T1;
					WHEN "1000" => sel <= "01";
						LD_CW <= "10000";
						func <= "101";
						we <= 'Z';
						nxt_state <= T1;
					WHEN "1001" => sel <= "01";
						LD_CW <= "00010";
						func <= "011";
						we <= 'Z';
						nxt_state <= T1;
					WHEN "1010" => sel <= "01";
						LD_CW <= "00010";
						func <= "010";
						we <= 'Z';
						nxt_state <= T1;
					WHEN OTHERS => sel <= (OTHERS => 'Z');
						LD_CW <= (OTHERS => 'Z');
						func <= (OTHERS => 'Z');
						we <= 'Z';
						nxt_state <= T0;
				END CASE;
				------------------------------------------------------------
			WHEN T1 =>
				CASE opcode IS
					WHEN "0011" => sel <= "11";
						LD_CW <= "00001";
						func <= "100";
						we <= 'Z';
						nxt_state <= T0;
					WHEN "0100" => sel <= "11";
						LD_CW <= "00001";
						func <= "011";
						we <= 'Z';
						nxt_state <= T0;
					WHEN "0101" => sel <= "11";
						LD_CW <= "00001";
						func <= "101";
						we <= 'Z';
						nxt_state <= T0;
					WHEN "0111" => sel <= "00";
						LD_CW <= "00010";
						func <= "101";
						we <= '0';
						nxt_state <= T2;
					WHEN "1000" => sel <= "00";
						LD_CW <= "00010";
						func <= "101";
						we <= '0';
						nxt_state <= T2;
					WHEN "1001" => sel <= "11";
						LD_CW <= "00001";
						func <= "011";
						we <= 'Z';
						nxt_state <= T2;
					WHEN "1010" => sel <= "11";
						LD_CW <= "00001";
						func <= "010";
						we <= 'Z';
						nxt_state <= T2;
					WHEN OTHERS => sel <= (OTHERS => 'Z');
						LD_CW <= (OTHERS => 'Z');
						func <= (OTHERS => 'Z');
						we <= 'Z';
						nxt_state <= T0;
				END CASE;
				------------------------------------------------------------
			WHEN T2 =>
				CASE opcode IS
					WHEN "0111" => sel <= "11";
						LD_CW <= "00001";
						func <= "101";
						we <= 'Z';
						nxt_state <= T3;
					WHEN "1000" => sel <= "11";
						LD_CW <= "00001";
						func <= "101";
						we <= 'Z';
						nxt_state <= T3;
					WHEN "1001" => sel <= "10";
						LD_CW <= "00000";
						func <= (OTHERS => 'Z');
						we <= '1';
						nxt_state <= T0;
					WHEN "1010" => sel <= "10";
						LD_CW <= "00000";
						func <= (OTHERS => 'Z');
						we <= '1';
						nxt_state <= T0;
					WHEN OTHERS => sel <= (OTHERS => 'Z');
						LD_CW <= (OTHERS => 'Z');
						func <= (OTHERS => 'Z');
						we <= 'Z';
						nxt_state <= T0;
				END CASE;
				------------------------------------------------------------
			WHEN T3 =>
				CASE opcode IS
					WHEN "0111" => sel <= "10";
						LD_CW <= "10000";
						func <= "000";
						we <= 'Z';
						nxt_state <= T4;
					WHEN "1000" => sel <= "10";
						LD_CW <= "10000";
						func <= "001";
						we <= 'Z';
						nxt_state <= T4;
					WHEN OTHERS => sel <= (OTHERS => 'Z');
						LD_CW <= (OTHERS => 'Z');
						func <= (OTHERS => 'Z');
						we <= 'Z';
						nxt_state <= T0;

				END CASE;
				------------------------------------------------------------
			WHEN T4 =>
				CASE opcode IS
					WHEN "0111" => sel <= "00";
						LD_CW <= "00100";
						func <= "000";
						we <= '0';
						nxt_state <= T5;
					WHEN "1000" => sel <= "00";
						LD_CW <= "00100";
						func <= "001";
						we <= '0';
						nxt_state <= T5;
					WHEN OTHERS => sel <= (OTHERS => 'Z');
						LD_CW <= (OTHERS => 'Z');
						func <= (OTHERS => 'Z');
						we <= 'Z';
						nxt_state <= T0;

				END CASE;
				------------------------------------------------------------
			WHEN T5 =>
				CASE opcode IS
					WHEN "0111" => sel <= "11";
						LD_CW <= "00001";
						func <= "000";
						we <= 'Z';
						nxt_state <= T0;
					WHEN "1000" => sel <= "11";
						LD_CW <= "00001";
						func <= "001";
						we <= 'Z';
						nxt_state <= T0;
					WHEN OTHERS => sel <= (OTHERS => 'Z');
						LD_CW <= (OTHERS => 'Z');
						func <= (OTHERS => 'Z');
						we <= 'Z';
						nxt_state <= T0;

				END CASE;
				------------------------------------------------------------

				--WHEN OTHERS =>

		END CASE;
	END PROCESS controlpath;
	datapath : PROCESS (clk)
	BEGIN
		IF clk = '1' THEN
			IF nrst = '0' THEN
				cur_state <= T0;
				A <= X"00000001";
				B <= X"00000002";
				C <= X"00000003";
				D <= X"00000004";
			ELSE
				IF LD_CW = "10000" THEN
					A <= cbus;
				END IF;
				IF LD_CW = "01000" THEN
					B <= cbus;
				END IF;
				IF LD_CW = "00100" THEN
					C <= cbus;
				END IF;
				IF LD_CW = "00010" THEN
					D <= cbus;
				END IF;
				IF LD_CW = "00001" THEN
					ACC <= z;
				END IF;
				cur_state <= nxt_state;
			END IF;
		END IF;
	END PROCESS datapath;

END behavioral;