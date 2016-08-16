library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Microprocessador is
	Port ( 
		Reset : in STD_LOGIC;
		CLK : in  STD_LOGIC);
end Microprocessador;

architecture Estructural of Microprocessador is

	component UnitatDeControl is
		Port (
			Reset : in STD_LOGIC;
			clk : in  STD_LOGIC;
			co : in  STD_LOGIC_VECTOR (5 downto 0);
			func : in  STD_LOGIC_VECTOR (5 downto 0);
			paraula: in  STD_LOGIC_VECTOR (31 downto 0);
			l_sor1 : out  STD_LOGIC;
			l_sor2 : out  STD_LOGIC;
			e_reg : out  STD_LOGIC;
			e_par :out STD_LOGIC;
			mux_dest : out  STD_LOGIC_VECTOR (1 downto 0);
			l_mem : out  STD_LOGIC;
			e_mem : out  STD_LOGIC;
			e_mar : out  STD_LOGIC;
			l_mdr : out  STD_LOGIC;
			e_mdr : out  STD_LOGIC;
			e_ir : out  STD_LOGIC;
			l_pc : out  STD_LOGIC;
			e_pc : out  STD_LOGIC;
			pc_sup : out  STD_LOGIC;
			inc_pc : out  STD_LOGIC;
			l_desp1 : out  STD_LOGIC;
			l_desp2 : out  STD_LOGIC;
			l_extsign : out  STD_LOGIC;
			l_acc : out  STD_LOGIC;
			e_acc : out  STD_LOGIC;
			Tancar : out  STD_LOGIC;
			op_alu : out  STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;


	component ALU32 is
		Port (
			Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
			Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
			Operacio : in  STD_LOGIC_VECTOR (2 downto 0);
			Result : out  STD_LOGIC_VECTOR (31 downto 0);
			Paraula : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	end component;

	component BancRegistres is
		Port (
			Reset : in STD_LOGIC; 
			clk : in STD_LOGIC; 
			esc : in STD_LOGIC; 
			rdest : in STD_LOGIC_VECTOR (4 downto 0); 
			dades : in STD_LOGIC_VECTOR (31 downto 0); 
			lSor1 : in STD_LOGIC; 
			rf1 : in STD_LOGIC_VECTOR (4 downto 0); 
			lSor2 : in STD_LOGIC; 
			rf2 : in STD_LOGIC_VECTOR (4 downto 0); 
			sor1 : out STD_LOGIC_VECTOR (31 downto 0); 
			sor2 : out STD_LOGIC_VECTOR (31 downto 0) );	 
	end component;

	component PCSUP is
		Port ( 
			pc_sup : in std_logic;
			Entrada : in  STD_LOGIC_VECTOR (31 downto 0);
			Sortida : out  STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component ComptadorPrograma is
		Port (
			Reset : in STD_LOGIC;
			clk: in STD_LOGIC; 
			IncPC : in STD_LOGIC; 
			L_PC : in STD_LOGIC; 
			E_PC: in STD_LOGIC; 
			Din: in STD_LOGIC_VECTOR (31 downto 0); 
			Dout: out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component Desp25a0 is
		Port (
			l_desp2 : in std_logic;
			Entrada : in STD_LOGIC_VECTOR (25 downto 0);
			SortidaBus : out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component DespExtSign15a0 is
		Port (
			l_desp1 : in STD_LOGIC;
			Entrada : in STD_LOGIC_VECTOR (31 downto 0);
			SortidaBus : out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component ExtensioDeSigne is
		Port (
			l_extsign: in STD_LOGIC;
			DadaEntrada : in  STD_LOGIC_VECTOR (15 downto 0);
			DadaSortida1 : out  STD_LOGIC_VECTOR (31 downto 0);
			DadaSortida2 : out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component RAMSin is
		Port (
			clk : in STD_LOGIC;
			Escr : in STD_LOGIC;
			Lect : in STD_LOGIC;
			Adress : in STD_LOGIC_VECTOR (4 downto 0);
			DadesE : in  STD_LOGIC_VECTOR (31 downto 0);
			DadesS : out  STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component Mux4a1_5Bits is
		Port (
			Sel : in  STD_LOGIC_VECTOR (1 downto 0);
			E0 : in  STD_LOGIC_VECTOR (4 downto 0);
			E1 : in  STD_LOGIC_VECTOR (4 downto 0);
			E2 : in  STD_LOGIC_VECTOR (4 downto 0);
			E3 : in  STD_LOGIC_VECTOR (4 downto 0);
			S : out  STD_LOGIC_VECTOR (4 downto 0) 
		);
	end component;

	component Acumulador is
		Port (
			clk : in STD_LOGIC;
			l_acc : in  STD_LOGIC;
			e_acc : in STD_LOGIC;
			DadaEntrada : in  STD_LOGIC_VECTOR (31 downto 0);
			DadaSortida : out  STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component Latch32Bits is
		Port (
			clk: in STD_LOGIC;
			E : in  STD_LOGIC;
			reset : in STD_LOGIC;
			Din : in  STD_LOGIC_VECTOR (31 downto 0);
			Dout : out  STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component RegistreMDR is
		Port (
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			e_mdr : in  STD_LOGIC;
			l_mdr : in  STD_LOGIC;
			l_mem : in STD_LOGIC;
			DadesBus2 : in  STD_LOGIC_VECTOR (31 downto 0);
			DadesMemS : out  STD_LOGIC_VECTOR (31 downto 0);
			DadesMemE : in  STD_LOGIC_VECTOR (31 downto 0);
			DadesBus3 : out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;

	component EnllacBus is
		Port (
			Tancar : in  STD_LOGIC;
			DadesBus3 : in STD_LOGIC_VECTOR (31 downto 0);
			DadesBus1 : out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;
	

	component RegistreMAR is
		Port (
			Pas : in  STD_LOGIC;
			DadesEnt : in STD_LOGIC_VECTOR (31 downto 0);
			DadesSor : out STD_LOGIC_VECTOR (31 downto 0) 
		);
	end component;
	
	component ParaulaEstat is
	Port (
		clk : in STD_LOGIC;
		E : in STD_LOGIC;
		reset : in STD_LOGIC;
		Din : in  STD_LOGIC_VECTOR (31 downto 0);
		Dout : out  STD_LOGIC_VECTOR (31 downto 0) 
	); 
end component;
	
	constant CONST31 : std_logic_vector(4 downto 0) := "01111";
	signal co : STD_LOGIC_VECTOR(5 downto 0);
	signal func : STD_LOGIC_VECTOR (5 downto 0);
	signal z : STD_LOGIC;
	signal c : STD_LOGIC;
	signal l_sor1 : STD_LOGIC;
	signal l_sor2 : STD_LOGIC;
	signal e_reg : STD_LOGIC;
	signal mux_dest : STD_LOGIC_VECTOR (1 downto 0);
	signal l_mem : STD_LOGIC;
	signal e_mem : STD_LOGIC;
	signal e_mar : STD_LOGIC;
	signal l_mdr : STD_LOGIC;
	signal e_mdr : STD_LOGIC;
	signal e_ir : STD_LOGIC;
	signal l_pc : STD_LOGIC;
	signal e_pc : STD_LOGIC;
	signal pc_sup : STD_LOGIC;
	signal inc_pc : STD_LOGIC;
	signal l_desp1 : STD_LOGIC;
	signal l_desp2 : STD_LOGIC;
	signal l_extsign : STD_LOGIC;
	signal l_acc : STD_LOGIC;
	signal e_acc : STD_LOGIC;
	signal Tancar : STD_LOGIC;
	signal op_alu : STD_LOGIC_VECTOR (2 downto 0);
	
	signal Sel : STD_LOGIC_VECTOR (1 downto 0);
	signal E0 : STD_LOGIC_VECTOR (4 downto 0);
	signal E1 : STD_LOGIC_VECTOR (4 downto 0);
	signal E2 : STD_LOGIC_VECTOR (4 downto 0);
	signal E3 : STD_LOGIC_VECTOR (4 downto 0);
	signal S : STD_LOGIC_VECTOR (4 downto 0);
	 
	signal esc : STD_LOGIC; 
	signal rdest : STD_LOGIC_VECTOR (4 downto 0);
	signal dades : STD_LOGIC_VECTOR (31 downto 0);
	signal rf1 : STD_LOGIC_VECTOR (4 downto 0);
	signal rf2 : STD_LOGIC_VECTOR (4 downto 0); 
	signal sor1 : STD_LOGIC_VECTOR (31 downto 0); 
	signal sor2 : STD_LOGIC_VECTOR (31 downto 0);
	
	signal Entrada : STD_LOGIC_VECTOR (31 downto 0);
	signal Sortida_sup : STD_LOGIC_VECTOR (31 downto 0);
	
	signal SortidaBus : STD_LOGIC_VECTOR (31 downto 0);
		
	signal DadaEntrada : STD_LOGIC_VECTOR (15 downto 0);
	signal DadaSortida1 : STD_LOGIC_VECTOR (31 downto 0);
	signal DadaSortida2 : STD_LOGIC_VECTOR (31 downto 0);
	
	signal Escr : STD_LOGIC;
	signal Lect : STD_LOGIC;
	signal Adress : STD_LOGIC_VECTOR (5 downto 0);
	signal DadesE : STD_LOGIC_VECTOR (31 downto 0);
	signal DadesS : STD_LOGIC_VECTOR (31 downto 0);
	
	signal DadaSortida : STD_LOGIC_VECTOR (31 downto 0);
	
	signal DadesBus2 : STD_LOGIC_VECTOR (31 downto 0);
	signal DadesMemS : STD_LOGIC_VECTOR (31 downto 0);
	signal DadesMemE : STD_LOGIC_VECTOR (31 downto 0);
	signal DadesBus3 : STD_LOGIC_VECTOR (31 downto 0);
	
	signal DadesBus1 : STD_LOGIC_VECTOR (31 downto 0);
	signal BusT : STD_LOGIC_VECTOR (31 downto 0);
	
	signal Pas : STD_LOGIC;
	signal DadesEnt : STD_LOGIC_VECTOR (31 downto 0);
	signal DadesSor : STD_LOGIC_VECTOR (31 downto 0);
	
	
	signal bus_ir : STD_LOGIC_VECTOR (31 downto 0);
   signal result_alu : STD_LOGIC_VECTOR (31 downto 0);
	signal sor_ext_sign : STD_LOGIC_VECTOR (31 downto 0);
	signal sor_mar : STD_LOGIC_VECTOR (31 downto 0);
	
	signal paraula : STD_LOGIC_VECTOR (31 downto 0);
	signal flags : STD_LOGIC_VECTOR (31 downto 0);
	signal e_par: STD_LOGIC;
	
begin

	-- Unitat de Control --
  uc: UnitatDeControl port map (Reset, CLK, bus_ir(31 downto 26), bus_ir(5 downto 0), flags, l_sor1, l_sor2, e_reg, e_par, mux_dest, l_mem, e_mem, e_mar, l_mdr, e_mdr, e_ir, l_pc, e_pc, pc_sup, inc_pc, l_desp1, l_desp2, l_extsign, l_acc, e_acc, Tancar, op_alu );
  -- Registre d'Instruccio --
  ir: Latch32Bits port map (CLK, e_ir, Reset, DadesBus3, bus_ir);

  mx: Mux4a1_5Bits port map (mux_dest, bus_ir(20 downto 16), bus_ir(15 downto 11), CONST31, "ZZZZZ", rdest); 
			
  -- Banc de Registres --
  breg: BancRegistres port map (Reset, CLK, e_reg, rdest, DadesBus3, l_sor1, bus_ir(25 downto 21), l_sor2, bus_ir(20 downto 16), DadesBus1, DadesBus2);
  			
  pcs: PCSUP port map (pc_sup, DadesBus1, Sortida_sup);
  
  pc: ComptadorPrograma port map (Reset, CLK, inc_pc, l_pc, e_pc, DadesBus3, DadesBus1);
  
  d1: Desp25a0 port map (l_desp2, bus_ir(25 downto 0), DadesBus2); 
  d2: DespExtSign15a0 port map (l_desp1, sor_ext_sign, DadesBus2);
  exts: ExtensioDeSigne port map (l_extsign, bus_ir(15 downto 0), DadesBus2, sor_ext_sign );
  alu: ALU32 port map (Sortida_sup, DadesBus2, op_alu, result_alu, paraula); 
  acc: Acumulador port map (CLK, l_acc, e_acc, result_alu, DadesBus3);
	
  ma: RegistreMAR port map (e_mar, DadesBus1, sor_mar); 
  mr: RAMSin port map (CLK, e_mem, l_mem, sor_mar(6 downto 2), DadesMemS, DadesMemE); 

  mdr: RegistreMDR port map (CLK, Reset, e_mdr, l_mdr, l_mem, DadesBus2, DadesMemS, DadesMemE, DadesBus3); 
  enl:  EnllacBus port map (Tancar, DadesBus3, DadesBus1);
  
  par: ParaulaEstat port map (CLK, e_par, Reset, paraula, flags);
  
end Estructural;