library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mux4a1_5Bits is
	Port (
		Sel : in  STD_LOGIC_VECTOR (1 downto 0);
		E0 : in  STD_LOGIC_VECTOR (4 downto 0);
		E1 : in  STD_LOGIC_VECTOR (4 downto 0);
		E2 : in  STD_LOGIC_VECTOR (4 downto 0);
		E3 : in  STD_LOGIC_VECTOR (4 downto 0);
		S : out  STD_LOGIC_VECTOR (4 downto 0) 
	);
end Mux4a1_5Bits;

architecture Behavioral of Mux4a1_5Bits is

begin
	S <= E0 when Sel = "00" else E1 when Sel = "01" else E2 when Sel = "10" else E3;
end Behavioral;

