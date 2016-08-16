library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.Programes.all;

entity RAMSin is
	Port ( 
		clk : in STD_LOGIC;
		Escr : in STD_LOGIC;
		Lect: in STD_LOGIC;
		Adress : in STD_LOGIC_VECTOR (4 downto 0);
		DadesE : in  STD_LOGIC_VECTOR (31 downto 0);
		DadesS : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end RamSin;

architecture RAMSin of RAMSin is

signal RAM : MemoriaRAM := programa2;

	begin process(clk)
	begin
		if rising_edge(clk) then
			if Escr ='1' then
				RAM(to_integer(unsigned(Adress))) <= DadesE;
			end if;
		end if;
	end process;

	DadesS <= RAM(to_integer(unsigned(Adress)));
end RAMSin;