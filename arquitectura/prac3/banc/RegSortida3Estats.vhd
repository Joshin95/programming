library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity RegSortida3Estats is
	Port(	Reset:in STD_LOGIC;
			clk:in STD_LOGIC;
			WE:in STD_LOGIC;
			Din:in STD_LOGIC_VECTOR(31 downto 0);
			E1:in STD_LOGIC;
			E2:in STD_LOGIC;
			Dout1:out STD_LOGIC_VECTOR(31 downto 0);
			Dout2:out STD_LOGIC_VECTOR(31 downto 0));
			
end RegSortida3Estats;

architecture Behaviour of RegSortida3Estats is

component Registre is
	port(	Reset:in STD_LOGIC;
			clk:in STD_LOGIC;
			enable:in STD_LOGIC;
			Din:in STD_LOGIC_VECTOR(31 downto 0);
			Dout:out STD_LOGIC_VECTOR(31 downto 0)); 
end component;

signal SortidaReg:STD_LOGIC_VECTOR(31 downto 0);
	begin
	-- comprovar el nom de sortidareg i veure on s'ha de conectar la Dout
	reg: Registre port map(Reset,clk,WE,Din,SortidaReg);
	
	Dout1 <= SortidaReg when E1='1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	Dout2 <= SortidaReg when E2='1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
	
end Behaviour;
	
