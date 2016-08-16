-- Componets de la llibreria work
-- Entitats
entity inv is 
	port (x: in bit; y: out bit); 
end inv;

entity and2a is 
	port (x1, x2: in bit; y: out bit); 
end and2a;

entity or2a is 
	port (x1, x2: in bit; y: out bit); 
end or2a;

-- Arquitectures
architecture rtl of inv is 
	begin 
		y <= not x; 
end rtl;

architecture rtl of and2a is 
	begin 
		y <= x1 and x2; 
end rtl;

architecture rtl of or2a is 
	begin 
		y <= x1 or x2; 
end rtl;
