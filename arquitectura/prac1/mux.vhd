library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 

entity mux is
   port (a,b,ctrl : in std_logic;
			z : out std_logic);
end mux;


architecture Estructura of Mux is
	component inv is port(x:in  std_logic; y:out std_logic); end component;
	component and2a is port(x1,x2:in std_logic; y:out std_logic); end component;
	component or2a is port(x1,x2:in std_logic; y:out std_logic); end component;

	signal ctrl_n, n1,n2: std_logic;

begin
  U0: entity work.inv port map (x => ctrl,y => ctrl_n);
  U1: entity work.and2a port map (x1 => ctrl_n, x2 => a, y => n1);
  U2: entity work.and2a port map (X1 => ctrl, X2 => b, y => n2);
  U3: entity work.or2a port map (x1 => n1, x2 => n2, y => z);
end Estructura; 

