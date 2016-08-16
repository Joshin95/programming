library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity ALU32 is
	port ( ControlALU: in STD_LOGIC_VECTOR (2 downto 0);
			Op1, Op2: in STD_LOGIC_VECTOR (31 downto 0);
			Res: out STD_LOGIC_VECTOR (31 downto 0);
			Z, C: out STD_LOGIC);
end ALU32;

architecture arc of ALU32 is
	signal Res_aux : STD_LOGIC_VECTOR(32 downto 0):="000000000000000000000000000000000";
	signal Z_aux : STD_LOGIC :='0';
	signal C_aux : STD_LOGIC :='0';
	begin
	process(ControlALU,Res_aux)
		begin	
		case ControlALU is
			when "000" =>  Res_aux(31 downto 0) <= Op1 and Op2;
			               if Res_aux(31 downto 0)="00000000000000000000000000000000" then
									Z <='1';
								else
									Z <='0';
								end if;
								C <= '0';
			when "001" =>  Res_aux(31 downto 0) <= Op1 or Op2;
								if Res_aux(31 downto 0)="00000000000000000000000000000000" then
									Z <='1';
								else
									Z <='0';
								end if;
								C <= '0';
			when "010" =>  Res_aux <= std_logic_vector(unsigned('0' & Op1) + unsigned('0' & Op2));
								if Res_aux(31 downto 0)="00000000000000000000000000000000" then
									Z <='1';
								else
									Z <='0';
								end if;
								C <= Res_aux(32);
			when "110" =>  Res_aux <= std_logic_vector(unsigned('0' & Op1) - unsigned('0' & Op2));
								if Res_aux(31 downto 0)="00000000000000000000000000000000" then
									Z <='1';
								else
									Z <='0';
								end if;
								C <= Res_aux(32);
			when "111" => 	if (Op1 < Op2) then
									Res_aux(31 downto 0) <="00000000000000000000000000000001";
									Z <='0';
									C <='0';
								else
									Res_aux(31 downto 0) <="00000000000000000000000000000000";
									Z <='0';
									C <='0';
								end if;
			when others => Res_aux <= "000000000000000000000000000000000";
		end case;
	end process;
	Res <= Res_aux(31 downto 0);
end arc;

