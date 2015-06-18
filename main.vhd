-- Main entity

library ieee;
use ieee.std_logic_1164.all;

entity main is
port
(
	clock		:in 	std_logic	
);

end entity;

architecture rtl of main is
------------------------------ RAM ------------------------------
component accesRAM IS
	port
	(
		data				: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdclock			: IN STD_LOGIC ;
		wraddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wrclock			: IN STD_LOGIC  := '1';
		wren				: IN STD_LOGIC  := '0';
		q					: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
end component accesRAM;
	
begin

	

end rtl;
