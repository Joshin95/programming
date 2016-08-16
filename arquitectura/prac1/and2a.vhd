LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 

entity and2a is 
	port (x1, x2: in std_logic; y: out std_logic); 
end and2a;

architecture rtl of and2a is 
	begin 
		y <= x1 and x2; 
end rtl;
