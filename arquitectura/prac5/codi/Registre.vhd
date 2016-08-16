library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity Registre is
	port(	Reset:in STD_LOGIC;
			clk:in STD_LOGIC;
			enable:in STD_LOGIC;
			Din:in STD_LOGIC_VECTOR(31 downto 0);
			Dout:out STD_LOGIC_VECTOR(31 downto 0)); 
end Registre;

architecture Behaviour of Registre is

	signal reg:STD_LOGIC_VECTOR(31 downto 0);
	
	begin
	process(clk,reset)
		begin
		if rising_edge(clk) then
			if reset='1' then
				reg <= "00000000000000000000000000000000";
			else
				if enable='1' then
					reg <= Din;
				end if;
			end if;
		end if;
	end process;
	Dout <= reg;	
end Behaviour;

			