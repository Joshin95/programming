library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity RegistreZero is
Port (E1 : in STD_LOGIC;
		E2 : in STD_LOGIC;
		Dout1:out STD_LOGIC_VECTOR(31 downto 0);
		Dout2:out STD_LOGIC_VECTOR(31 downto 0));
end RegistreZero;

architecture Behaviour of RegistreZero is

begin
	Dout1 <= "00000000000000000000000000000000" when E1='1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	Dout2 <= "00000000000000000000000000000000" when E2='1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end Behaviour;