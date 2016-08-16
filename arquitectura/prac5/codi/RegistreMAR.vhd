library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegistreMAR is
	Port ( 
		Pas : in  STD_LOGIC;
		DadesEnt : in STD_LOGIC_VECTOR (31 downto 0);
		DadesSor : out STD_LOGIC_VECTOR (31 downto 0) 
	);
end RegistreMAR;

architecture Behavioral of RegistreMAR is

begin
  DadesSor <= DadesEnt when Pas = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end Behavioral;

