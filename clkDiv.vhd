-- Clock divider
library ieee;
use ieee.std_logic_1164.all;

entity freqDiv is
	port(
		den	:in integer range 0 to 2**16;			-- Input clock division by {2*den}
		clkIN		:in 	std_logic;							-- Input clock	
		clkOUT	:out 	std_logic							-- Output clock
		);
end entity;

architecture rtl of freqDiv is
signal slowClock :std_logic:='0';

begin
   clkOUT <= slowClock;
   process(clkIN)
   variable a :integer range 0 to 2**16:=1;
	begin
		if rising_edge(clkIN) then
			if a < den then
			  a := a+1;
			else
			  slowClock <= not slowClock;
			  a := 1;
			end if;
		end if;

	end process;
end rtl;
