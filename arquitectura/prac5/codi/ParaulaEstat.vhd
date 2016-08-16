library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ParaulaEstat is
	Port (
		clk : in STD_LOGIC;
		E : in STD_LOGIC;
		reset : in STD_LOGIC;
		Din : in  STD_LOGIC_VECTOR (31 downto 0);
		Dout : out  STD_LOGIC_VECTOR (31 downto 0) 
	); 
end ParaulaEstat;

architecture Behavioral of ParaulaEstat is

begin

	process (clk, E)
	begin
		if rising_edge(clk) then
			if E = '1' then
				Dout <= Din;
			end if;
			if reset = '1' then
				Dout <= x"00000000";
			end if;
		end if;
  end process;
end Behavioral;