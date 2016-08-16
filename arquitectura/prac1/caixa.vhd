library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity caixa is
	port (A: in std_logic_vector(7 downto 0);
			B: in std_logic_vector(7 downto 0);
			selector: in std_logic;
			reset: in std_logic;
			sortida: out std_logic_vector(7 downto 0);
			mode: out std_logic_vector(2 downto 0));
end caixa;

architecture arc of caixa is
	signal mode_aux : unsigned(2 downto 0):="000";
	signal sortida_aux : unsigned(7 downto 0):="00000000";
	begin

process(selector,reset)
	begin	
	if reset='0' then
		if selector='1' then
			mode_aux <= mode_aux+1;
		else
			mode_aux <= mode_aux;
		end if;
	else
		mode_aux <= "000";
	end if;
end process;

process(A,B,mode_aux)
	begin 
	if mode_aux="000" then
	sortida <= std_logic_vector(unsigned(A)+unsigned(B));

	elsif mode_aux="001" then
	sortida <= std_logic_vector(unsigned(A)-unsigned(B));

	elsif mode_aux="010" then
	sortida <= std_logic_vector(unsigned(A(3 downto 0))*unsigned(B(3 downto 0)));

	elsif mode_aux="011" then
	sortida <= std_logic_vector(unsigned(A) xor unsigned(B));

	elsif mode_aux="100" then
	sortida <= std_logic_vector(unsigned(A) and unsigned(B));

	elsif mode_aux="101" then
	sortida <= std_logic_vector(unsigned(A) or unsigned(B));

	else
		sortida <= "00000000";
	end if;
end process;
	
mode <= std_logic_vector(mode_aux);
	
end arc;

