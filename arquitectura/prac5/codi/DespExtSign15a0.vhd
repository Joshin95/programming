library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DespExtSign15a0 is
	Port ( 
		l_desp1 : in STD_LOGIC;
		Entrada : in STD_LOGIC_VECTOR (31 downto 0);
		SortidaBus : out STD_LOGIC_VECTOR (31 downto 0) 
	);
end DespExtSign15a0;

architecture Behavioral of DespExtSign15a0 is

	signal Sortida: std_logic_vector (31 downto 0);

	begin
		Sortida <= Entrada (29 downto 0) & "00";
		SortidaBus <= Sortida when l_desp1 = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end Behavioral;