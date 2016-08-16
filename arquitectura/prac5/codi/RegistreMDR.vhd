library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RegistreMDR is
	Port ( 
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		e_mdr : in  STD_LOGIC;
		l_mdr : in  STD_LOGIC;
		l_mem : in STD_LOGIC;
		DadesBus2 : in  STD_LOGIC_VECTOR (31 downto 0);
		DadesMemS : out  STD_LOGIC_VECTOR (31 downto 0);
		DadesMemE : in  STD_LOGIC_VECTOR (31 downto 0);
		DadesBus3 : out STD_LOGIC_VECTOR (31 downto 0) 
	);
end RegistreMDR;

architecture Behavioral of RegistreMDR is

component Latch32Bits is
	Port (
		clk : in STD_LOGIC;
		E : in  STD_LOGIC; -- Senyal d'habilitacio / escriptura
		reset : in STD_LOGIC;
		Din : in  STD_LOGIC_VECTOR (31 downto 0);
		Dout : out  STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

signal DadaEntrada, DadaSortida : STD_LOGIC_VECTOR (31 downto 0);

begin
	DadaEntrada <= DadesBus2 when (l_mem = '0') else DadesMemE;
	reg: Latch32Bits port map (clk, e_mdr, reset, DadaEntrada, DadaSortida);
	DadesMemS <= DadaSortida;
	DadesBus3 <= DadaSortida when (l_mdr = '1') else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end Behavioral;
