library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU32 is
	Port ( 
		Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
		Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
		Operacio : in  STD_LOGIC_VECTOR (2 downto 0);
		Result : out  STD_LOGIC_VECTOR (31 downto 0);
		Paraula : out STD_LOGIC_VECTOR (31 downto 0)
		);
end ALU32;

architecture arch_ALU32 of ALU32 is
--	signal result_int : STD_LOGIC_VECTOR (31 downto 0);
	signal res33 : STD_LOGIC_VECTOR (32 downto 0);
	
	begin

	process (Operacio, Op1, Op2)
	begin
		--- Operacio de l'ALU ---
		
		case Operacio is
			when "000" => res33 <= ('0' & Op1) and ('0' & Op2);	  
			when "001" => res33 <= ('0' & Op1) or ('0' & Op2);
			when "011" => res33 <= '0' & std_logic_vector(unsigned(Op2) srl to_integer(unsigned(Op1)));
			when "010" => res33 <= std_logic_vector(unsigned('0' & Op1) + unsigned('0' & Op2));
			when "110" => res33 <= std_logic_vector(unsigned('0' & Op1) - unsigned('0' & Op2));
			when "111" => 
				if Op1 < Op2 then
					res33 <= "000000000000000000000000000000001";
				else
					res33 <= "000000000000000000000000000000000";
				end if;
			when others => res33 <= "000000000000000000000000000000000";
		end case;
	end process;

	Result <= res33(31 downto 0);
	Paraula(1) <= res33(32);
	Paraula(2) <= res33(31);
	Paraula(31 downto 3) <= "00000000000000000000000000000";

	process (res33) --Zero
	begin
		if res33(31 downto 0) = x"00000000" then
			Paraula(0) <= '1' ;
			Paraula(31 downto 3) <= "00000000000000000000000000000";
		else
			Paraula(0) <= '0' ;
			Paraula(31 downto 3) <= "00000000000000000000000000000";
		end if;
	end process;	
	
end arch_ALU32;

