library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Acumulador is
	Port ( 
		clk : in STD_LOGIC;
		l_acc : in  STD_LOGIC;
		e_acc : in STD_LOGIC;
		DadaEntrada : in  STD_LOGIC_VECTOR (31 downto 0);
		DadaSortida : out  STD_LOGIC_VECTOR (31 downto 0) );
end Acumulador;

architecture Behavioral of Acumulador is
	component Latch32Bits is
		Port ( 
			clk : in STD_LOGIC;
			E : in  STD_LOGIC;
			reset : in STD_LOGIC;
			Din : in  STD_LOGIC_VECTOR (31 downto 0);
			Dout : out  STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	signal Sortida : std_logic_vector (31 downto 0);

	begin
		reg: Latch32Bits port map (clk, e_acc, '0', DadaEntrada, Sortida);
		DadaSortida <= Sortida when l_acc = '1' else (others => 'Z');
end Behavioral;

