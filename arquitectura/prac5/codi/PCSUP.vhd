library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity PCSUP is
	Port (
		pc_sup: in std_logic;
		Entrada : in  STD_LOGIC_VECTOR (31 downto 0);
		Sortida : out  STD_LOGIC_VECTOR (31 downto 0) 
	);
end PCSUP;

architecture Behavioral of PCSUP is

begin
  Sortida <= Entrada when pc_sup ='0' else (Entrada(31 downto 28) & x"0000000" );
end Behavioral;