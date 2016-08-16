library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Desp25a0 is
  Port ( 
		l_desp2 : in std_logic;
		Entrada : in STD_LOGIC_VECTOR (25 downto 0);
		SortidaBus : out STD_LOGIC_VECTOR (31 downto 0) 
	);
end Desp25a0;

architecture Behavioral of Desp25a0 is

begin
  SortidaBus <= ("0000" & Entrada & "00") when l_desp2 = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end Behavioral;

