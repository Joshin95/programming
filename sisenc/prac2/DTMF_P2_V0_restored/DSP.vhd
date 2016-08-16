library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity DSP is

port (clk    : in  std_logic;
      senyal_lectura : in  std_logic;
      test1      : in  std_logic;
      test2      : in  std_logic;
		test3      : in  std_logic;
      test4      : in  std_logic;
		test5      : in  std_logic;
      test6      : in  std_logic;
		test7      : in  std_logic;
      test8      : in  std_logic;
		sortida  : out std_logic_vector(3 downto 0);
		lectura	: out std_logic
		);
end entity DSP;

architecture arch of DSP is
	
begin 
	process(clk)              
		begin
			if rising_edge(clk) and senyal_lectura = '1' then
				if test1='1' and test5='1' then
					sortida<="0001"; --valor1
				elsif test1='1' and test6='1' then
					sortida<="0010"; --valor2
				elsif test1='1' and test7='1' then
					sortida<="0011"; --valor3
				elsif test1='1' and test8='1' then
					sortida<="1010"; --valorA
				elsif test2='1' and test5='1' then
					sortida<="0100"; --valor4
				elsif test2='1' and test6='1' then
					sortida<="0101"; --valor5
				elsif test2='1' and test7='1' then
					sortida<="0110"; --valor6
				elsif test2='1' and test8='1' then
					sortida<="1011"; --valorB
				elsif test3='1' and test5='1' then
					sortida<="0111"; --valor7
				elsif test3='1' and test6='1' then
					sortida<="1000"; --valor8
				elsif test3='1' and test7='1' then
					sortida<="1001"; --valor9
				elsif test3='1' and test8='1' then
					sortida<="1100"; --valorC
				elsif test4='1' and test5='1' then
					sortida<="1110"; --valor*
				elsif test4='1' and test6='1' then
					sortida<="0000"; --valor0
				elsif test4='1' and test7='1' then
					sortida<="1111"; --valor#
				else
					sortida<="1101"; --valorD
				end if;
			end if;
	end process;		

end architecture arch;      
      
