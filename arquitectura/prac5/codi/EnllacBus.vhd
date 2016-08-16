library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EnllacBus is
	Port ( 
		Tancar : in  STD_LOGIC;
		DadesBus3 : in STD_LOGIC_VECTOR (31 downto 0);
		DadesBus1 : out STD_LOGIC_VECTOR (31 downto 0) 
	);
end EnllacBus;

architecture Behavioral of EnllacBus is

begin
  DadesBus1 <= DadesBus3 when Tancar = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end Behavioral;

