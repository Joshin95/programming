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
	process(E1,E2)
	begin
	if E1='1' then
		Dout1 <= "00000000000000000000000000000000"; else Dout1 <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	end if;
	if E2='1' then
		Dout2 <= "00000000000000000000000000000000"; else Dout2 <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	end if;
	end process;
end Behaviour;