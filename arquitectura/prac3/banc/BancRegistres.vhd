library work;
use work.all;
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity BancRegistres is
port (Reset : in STD_LOGIC;
		clk : in STD_LOGIC;	
		esc : in STD_LOGIC;
		rdest : in STD_LOGIC_VECTOR(4 downto 0);
		dades : in STD_LOGIC_VECTOR(31 downto 0);
		lSor1: in STD_LOGIC;
		rf1 : in STD_LOGIC_VECTOR(4 downto 0);
		lSor2: in STD_LOGIC;
		rf2 : in STD_LOGIC_VECTOR(4 downto 0);
		sor1 : out STD_LOGIC_VECTOR(31 downto 0);
		sor2 : out STD_LOGIC_VECTOR(31 downto 0));
end BancRegistres;

architecture Behaviour of BancRegistres is

component RegSortida3Estats is
Port (Reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		WE : in STD_LOGIC:='0';
		Din : in STD_LOGIC_VECTOR (31 downto 0);
		E1 : in STD_LOGIC:='0';
		E2 : in STD_LOGIC:='0';
		Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
		Dout2 : out STD_LOGIC_VECTOR (31 downto 0));

end component;

component RegistreZero is
Port (E1 : in STD_LOGIC;
		E2 : in STD_LOGIC;
		Dout1:out STD_LOGIC_VECTOR(31 downto 0);
		Dout2:out STD_LOGIC_VECTOR(31 downto 0));
end component;

component Descodificador5 is
Port (Habilitacio: in STD_LOGIC ;
		Ent : in STD_LOGIC_VECTOR (4 downto 0);
		Sort : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal RegSel1: STD_LOGIC_VECTOR (31 downto 0);
signal RegSel2: STD_LOGIC_VECTOR (31 downto 0);
signal RegEsc: STD_LOGIC_VECTOR(31 downto 0);

begin -- començem el behaviour del banc de registres

dec1: Descodificador5 port map (esc, rdest, RegEsc);
dec2: Descodificador5 port map (lSor1, rf1, RegSel1);
dec3: Descodificador5 port map (lSor2, rf2, RegSel2);

reg0: RegistreZero port map (RegSel1(0),RegSel2(0),Sor1,Sor2);
reg1: RegSortida3Estats port map (Reset,clk,RegEsc(1),Dades,RegSel1(1),RegSel2(1),Sor1, Sor2);
reg2: RegSortida3Estats port map (Reset,clk,RegEsc(2),Dades,RegSel1(2),RegSel2(2),Sor1, Sor2);
reg3: RegSortida3Estats port map (Reset,clk,RegEsc(3),Dades,RegSel1(3),RegSel2(3),Sor1, Sor2);
reg4: RegSortida3Estats port map (Reset,clk,RegEsc(4),Dades,RegSel1(4),RegSel2(4),Sor1, Sor2);
reg5: RegSortida3Estats port map (Reset,clk,RegEsc(5),Dades,RegSel1(5),RegSel2(5),Sor1, Sor2);
reg6: RegSortida3Estats port map (Reset,clk,RegEsc(6),Dades,RegSel1(6),RegSel2(6),Sor1, Sor2);
reg7: RegSortida3Estats port map (Reset,clk,RegEsc(7),Dades,RegSel1(7),RegSel2(7),Sor1, Sor2);
reg8: RegSortida3Estats port map (Reset,clk,RegEsc(8),Dades,RegSel1(8),RegSel2(8),Sor1, Sor2);
reg9: RegSortida3Estats port map (Reset,clk,RegEsc(9),Dades,RegSel1(9),RegSel2(9),Sor1, Sor2);
reg10: RegSortida3Estats port map (Reset,clk,RegEsc(10),Dades,RegSel1(10),RegSel2(10),Sor1, Sor2);
reg11: RegSortida3Estats port map (Reset,clk,RegEsc(11),Dades,RegSel1(11),RegSel2(11),Sor1, Sor2);
reg12: RegSortida3Estats port map (Reset,clk,RegEsc(12),Dades,RegSel1(12),RegSel2(12),Sor1, Sor2);
reg13: RegSortida3Estats port map (Reset,clk,RegEsc(13),Dades,RegSel1(13),RegSel2(13),Sor1, Sor2);
reg14: RegSortida3Estats port map (Reset,clk,RegEsc(14),Dades,RegSel1(14),RegSel2(14),Sor1, Sor2);
reg15: RegSortida3Estats port map (Reset,clk,RegEsc(15),Dades,RegSel1(15),RegSel2(15),Sor1, Sor2);
reg16: RegSortida3Estats port map (Reset,clk,RegEsc(16),Dades,RegSel1(16),RegSel2(16),Sor1, Sor2);
reg17: RegSortida3Estats port map (Reset,clk,RegEsc(17),Dades,RegSel1(17),RegSel2(17),Sor1, Sor2);
reg18: RegSortida3Estats port map (Reset,clk,RegEsc(18),Dades,RegSel1(18),RegSel2(18),Sor1, Sor2);
reg19: RegSortida3Estats port map (Reset,clk,RegEsc(19),Dades,RegSel1(19),RegSel2(19),Sor1, Sor2);
reg20: RegSortida3Estats port map (Reset,clk,RegEsc(20),Dades,RegSel1(20),RegSel2(20),Sor1, Sor2);
reg21: RegSortida3Estats port map (Reset,clk,RegEsc(21),Dades,RegSel1(21),RegSel2(21),Sor1, Sor2);
reg22: RegSortida3Estats port map (Reset,clk,RegEsc(22),Dades,RegSel1(22),RegSel2(22),Sor1, Sor2);
reg23: RegSortida3Estats port map (Reset,clk,RegEsc(23),Dades,RegSel1(23),RegSel2(23),Sor1, Sor2);
reg24: RegSortida3Estats port map (Reset,clk,RegEsc(24),Dades,RegSel1(24),RegSel2(24),Sor1, Sor2);
reg25: RegSortida3Estats port map (Reset,clk,RegEsc(25),Dades,RegSel1(25),RegSel2(25),Sor1, Sor2);
reg26: RegSortida3Estats port map (Reset,clk,RegEsc(26),Dades,RegSel1(26),RegSel2(26),Sor1, Sor2);
reg27: RegSortida3Estats port map (Reset,clk,RegEsc(27),Dades,RegSel1(27),RegSel2(27),Sor1, Sor2);
reg28: RegSortida3Estats port map (Reset,clk,RegEsc(28),Dades,RegSel1(28),RegSel2(28),Sor1, Sor2);
reg29: RegSortida3Estats port map (Reset,clk,RegEsc(29),Dades,RegSel1(29),RegSel2(29),Sor1, Sor2);
reg30: RegSortida3Estats port map (Reset,clk,RegEsc(30),Dades,RegSel1(30),RegSel2(30),Sor1, Sor2);
reg31: RegSortida3Estats port map (Reset,clk,RegEsc(31),Dades,RegSel1(31),RegSel2(31),Sor1, Sor2);
end Behaviour;