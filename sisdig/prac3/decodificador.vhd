library ieee;
use ieee.std_logic_1164.all;

entity decodificador is
  port(x,y: in std_logic_vector(3 downto 0);
       ax,bx,cx,dx,ex,fx,gx,ay,by,cy,dy,ey,fy,gy:out std_logic);
end decodificador;

architecture arc of decodificador is
  signal bus_out_x: std_logic_vector(6 downto 0);
  signal bus_out_y: std_logic_vector(6 downto 0);
  begin 
    with x select
      
	bus_out_x <= "1111110" when "0000", 
		     "0110000" when "0001", 
	     	     "1101101" when "0010", 
		     "1111001" when "0011", 
		     "0110011" when "0100", 
		     "1011011" when "0101", 
		     "1011111" when "0110", 
		     "1110000" when "0111", 
		     "1111111" when "1000", 
		     "1111011" when "1001", 
		     "-------" when others;
    with y select

      	bus_out_y <= "1111110" when "0000", 
		     "0110000" when "0001", 
	     	     "1101101" when "0010", 
		     "1111001" when "0011", 
		     "0110011" when "0100", 
		     "1011011" when "0101", 
		     "1011111" when "0110", 
		     "1110000" when "0111", 
		     "1111111" when "1000", 
		     "1111011" when "1001", 
		     "-------" when others;
	(ax,bx,cx,dx,ex,fx,gx)<= bus_out_x;
        (ay,by,cy,dy,ey,fy,gy)<= bus_out_y; 
end arc;
