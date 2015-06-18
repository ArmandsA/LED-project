-- Color testing algorythm
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;

entity colorTest is
	port
	(
		ph0		:in 	integer;
		clk		:in 	std_logic;						
		color		:out 	std_logic_vector(23 downto 0)					
	);
end entity;

architecture rtl of colorTest is
	--------- Color signals ---------
	signal GG, RR, BB: integer range 16#00# to 16#FF# := 16#00#;
	
begin
	color <= conv_std_logic_vector((GG*2**16 + RR*2**8 + BB), 24);	
	
	----------------- Color changing algorythm -----------------
	process(clk)
	variable phase: integer range 0 to 6:=6;
	begin
	if rising_edge(clk) then
		CASE phase IS
						WHEN 0 =>					-- BLACK to RR
							IF(RR < 16#FF#) THEN
								RR <= RR +3;
							ELSE
								phase := 1;
							END IF;
						WHEN 1 =>					-- RR to BLACK
							IF(RR > 16#00#) THEN
								RR <= RR -3;
							ELSE
								phase := 2;
							END IF;
						WHEN 2 =>					-- BLACK to GG
							IF(GG < 16#FF#) THEN
								GG <= GG +3;
							ELSE
								phase := 3;
							END IF;
						WHEN 3 =>					-- GG to BLACK
							IF(GG > 16#00#) THEN
								GG <= GG -3;
							ELSE
								phase := 4;
							END IF;
						WHEN 4 =>					-- BLACK to BB
							IF(BB < 16#FF#) THEN
								BB <= BB +3;
							ELSE
								phase := 5;
							END IF;
						WHEN 5 =>					-- BB to BLACK
							IF(BB > 16#00#) THEN
								BB <= BB -3;
							ELSE
								phase := 0;
							END IF;
						WHEN 6 =>					-- Initial
							phase := ph0;
						WHEN OTHERS =>
							phase := 0;
					END CASE;
	end if;
	end process;
	
end rtl;
