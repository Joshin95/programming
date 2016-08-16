LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 

entity or2a is 
	port (x1, x2: in std_logic; y: out std_logic); 
end or2a;

architecture rtl of or2a is 
	begin 
		y <= x1 or x2; 
end rtl;
