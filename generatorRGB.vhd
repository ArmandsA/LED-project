-- RGB ģenerator & RAM arbiter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity generatorRGB is
port
(
	data				: out STD_LOGIC_VECTOR (3 DOWNTO 0);
	activeBank		: out STD_LOGIC:='0';	-- 1"nepara adreses", 0"pāra adreses"
	wrAddress		: out STD_LOGIC_VECTOR (7 DOWNTO 0);
	clock				: in STD_LOGIC  := '0'
);

end entity;

architecture rtl of generatorRGB is
--------------------------------------------------
------------------- Components -------------------
--------------------------------------------------
component colorTest is
	port
	(
		ph0		:in 	integer;
		clk		:in 	std_logic;						
		color		:out 	std_logic_vector(23 downto 0)					
	);
end component;

component freqDiv is
	port(
		den		:in 	integer range 0 to 2**16;			-- Input clock division by {2*den}
		clkIN		:in 	std_logic;								-- Input clock	
		clkOUT	:out 	std_logic								-- Output clock
		);
end component;

-----------------------------------------------
------------------- Signals -------------------
-----------------------------------------------
signal clk2, clk3    :std_logic:= '0';
signal address0		:std_logic:= '0';
-- Chain A
signal color_A1, color_A2, color_A3, color_A4	:std_logic_vector(23 downto 0):= X"000000";
signal color_A	:std_logic_vector(95 downto 0);


begin

	process(clock)
	variable n: integer range 0 to 23:=0;
	begin
	if rising_edge(clock) then
		if n<23 then
			-- Pāra adreses vienai bankai, nepāra - otrai
			if address0 = '0' then 
				wrAddress <= conv_std_logic_vector(2*n, 8);
			else 
				wrAddress <= conv_std_logic_vector(2*n+1, 8);
			end if;
						
			for I in 0 to 3 loop
				data(I) <= color_A(n+24*I) ;
			end loop;
			n := n+1;
		else
			n := 0;
			address0 <= not address0;
		end if;
		
	end if;
	end process;
	
	-- 
	activeBank<=address0;

----------- COLOR SIGNALS -----------
-- A1	|	B1	|	C1	|	D1
-- A2	|	B2	|	C2	|	D2
-- .....................
	color_testA1: colorTest port map(0, clk3, color_A1);
	color_testA2: colorTest port map(2, clk3, color_A2);
	color_testA3: colorTest port map(4, clk3, color_A3);
	color_A4 <= color_A1;
	color_A <= color_A1 & color_A2 & color_A3 & color_A4;
	
	-------------- COLOR CLOCK --------------
	colorClk1: freqDiv port map (2**16, clock, clk2);
	colorClk2: freqDiv port map (1, clk2, clk3);

end rtl;
