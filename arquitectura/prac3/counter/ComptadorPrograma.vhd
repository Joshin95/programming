library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity ComptadorPrograma is
Port ( Reset : in STD_LOGIC;
clk: in STD_LOGIC;
IncPC : in STD_LOGIC;
L_PC : in STD_LOGIC;
E_PC: in STD_LOGIC;
Din: in STD_LOGIC_VECTOR (31 downto 0);
Dout: out STD_LOGIC_VECTOR (31 downto 0));
end ComptadorPrograma;

architecture PC_Arch of ComptadorPrograma is
	signal ContingutPC: STD_LOGIC_VECTOR (31 downto 0);
	begin
	process (clk, reset)
		begin
		if falling_edge(clk) then
			if reset = '1' then
				ContingutPC <= "00000000000000000000000000000000";
		   else
				if (IncPC='1') then
					ContingutPC <= ContingutPC+4;
				elsif (E_PC='1') then
					ContingutPC <= Din;
				end if;
			end if;
		end if;
	end process;
	Dout <= ContingutPC when L_PC = '1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
end Pc_Arch;