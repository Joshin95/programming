library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ExtensioDeSigne is
	Port ( 
		l_extsign: in STD_LOGIC;
		DadaEntrada : in  STD_LOGIC_VECTOR (15 downto 0);
		DadaSortida1 : out STD_LOGIC_VECTOR (31 downto 0);
		DadaSortida2 : out std_logic_vector (31 downto 0) 
	);
end ExtensioDeSigne;

architecture Behavioral of ExtensioDeSigne is

signal sortida: STD_LOGIC_VECTOR (31 downto 0);

begin
  sortida <= ("1111111111111111" & DadaEntrada) when DadaEntrada(15) = '1' else ("0000000000000000" & DadaEntrada);
  DadaSortida1 <= sortida when l_extsign = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
  DadaSortida2 <= sortida;
end Behavioral;

