library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mini_avr_01 is
  port (clk: in std_logic;
        reset : in std_logic;
        port_a0: in std_logic_vector(7 downto 0);
        port_a1: in std_logic_vector(7 downto 0);
        r16: out std_logic_vector( 7 downto 0);
        r17: out std_logic_vector( 7 downto 0);
        r18: out std_logic_vector( 7 downto 0));
end entity;

architecture behav of mini_avr_01 is

  type out_mux_type is (mux_alu,mux_lit,mux_ram,mux_in_out);
  signal out_mux:out_mux_type:=mux_alu;
  type register_bank is
    array (15 downto 0) of std_logic_vector(7 downto 0);
  signal regs : register_bank;
  type status_reg is
      record
      Z:std_logic;
      C:std_logic;
      end record;
  signal pr_SR,nx_SR : status_reg;
  signal alu_in_a : std_logic_vector(7 downto 0):="00000000";
  signal alu_in_b : std_logic_vector(7 downto 0):="00000000";
  signal add_temp: std_logic_vector(9 downto 0):="0000000000";
  signal alu_out : std_logic_vector(7 downto 0):="00000000";
  signal nx_reg : std_logic_vector(7 downto 0):="00000000";
  signal pr_pc : std_logic_vector(7 downto 0):="00000000";
  signal k_jmp : std_logic_vector(7 downto 0):="00000000";
  signal debug_carry : std_logic:='0';
  signal debug_zero : std_logic:='0';
  signal pr_op : std_logic_vector(15 downto 0):="0000000000000000";
  signal nx_pc : std_logic_vector(7 downto 0):="00000000";
  signal r_reg : std_logic_vector(3 downto 0):="0000";
  signal d_reg : std_logic_vector(3 downto 0):="0000";
  signal k : std_logic_vector(7 downto 0):="00000000";
  signal ALU_op : std_logic_vector(2 downto 0):="000";
  signal reg_we : std_logic:='0';
  signal update_Z: std_logic:='0';
  signal timer_state : std_logic_vector(7 downto 0):="00000000";
  signal port_we : std_logic:='0';
  signal presc_tc : std_logic :='0';
  signal port_adr : std_logic_vector(3 downto 0):="0000";
  signal presc_count : std_logic_vector(15 downto 0):="0000000000000000";
  signal timer_count : std_logic_vector(7 downto 0):="00000000";
  signal timer_limit : std_logic_vector(7 downto 0) := "00000000";
  signal presyncha0 : std_logic_vector(7 downto 0):="00000000";
  signal presyncha1 : std_logic_vector(7 downto 0):="00000000";
  signal syncha0 : std_logic_vector(7 downto 0):="00000000";
  signal syncha1 : std_logic_vector(7 downto 0):="00000000";
  signal in_data : std_logic_vector(7 downto 0):="00000000";
  signal port_a8i : std_logic_vector(7 downto 0):="00000000";
  signal port_a9i : std_logic_vector(7 downto 0):="00000000";
  signal ram_q : std_logic_vector(7 downto 0):="00000000";
    
  constant presc_count_limit : std_logic_vector(15 downto 0):="0010011100010000";
  constant ALU_B: std_logic_vector(3 downto 0):="0010"; 
  constant ALU_B_AND:std_logic_vector(1 downto 0):="00";
  constant ALU_B_EOR:std_logic_vector(1 downto 0):="01";
  constant ALU_B_OR:std_logic_vector(1 downto 0):="10"; 
  constant ALU_B_MOV:std_logic_vector(1 downto 0):="11";
  constant ALU_EOR:std_logic_vector(2 downto 0):="110";
  constant ALU_AND : std_logic_vector(2 downto 0):="101";
  constant ALU_OR : std_logic_vector(2 downto 0):="011";
  constant BREQ:std_logic_vector(3 downto 0):="1111";
  constant NOP:std_logic_vector(3 downto 0):="0000";
  constant LDI:std_logic_vector(3 downto 0):="1110";
  constant ADC:std_logic_vector(3 downto 0):="0001";
  constant MOV:std_logic_vector(3 downto 0):="0010";
  constant ALU_MOV:std_logic_vector(2 downto 0):="010";
  constant ALU_ADC:std_logic_vector(2 downto 0):="001";
  constant BRANCH: std_logic_vector(3 downto 0):="1111";
  constant RJMP : std_logic_vector(3 downto 0):="1100";
  constant c_r16: std_logic_vector(3 downto 0):="0000";
  constant c_r17: std_logic_vector(3 downto 0):="0001";
  constant in_out : std_logic_vector(3 downto 0):= "1011";
  
  begin
    
    alu_in_a <= regs(to_integer(unsigned(d_reg)));
    alu_in_b <= regs(to_integer(unsigned(r_reg)));
    r16 <=regs(0);
    r17 <=regs(1);
    r18 <=regs(2);
    debug_carry <= pr_SR.C;
    debug_zero <= pr_SR.Z;
    timer_state <= x"00" when timer_count=timer_limit
                   else x"01";
    presc_tc <= '1' when presc_count=presc_count_limit
                else '0';
    

    process(clk,reset)
    begin
      if reset='1' then
        pr_pc<=(others=>'0');
        pr_SR.C <='0';
        pr_SR.Z <='0';
      elsif(rising_edge(clk)) then
        pr_pc<=nx_pc;
        pr_SR<=nx_SR;
        presynchA0 <= port_A0;
        synchA0 <= presynchA0;
        presynchA1 <= port_A1;
        synchA1 <= presynchA1;
      end if;
    end process;

    ROM:process(pr_pc)
    begin
      case pr_pc is
       when X"00" => pr_op <= NOP & "0000" & "00000000";
       when X"01" => pr_op <= LDI & "1001" & "0000" & "0101"; 
       when X"02" => pr_op <= LDI & "1001" & "0001" & "0111"; 
       when X"03" => pr_op <= LDI & "1001" & "0010" & "1001"; 
       when X"04" => pr_op <= LDI & "1100" & "0011" & "1000"; 
       when X"05" => pr_op <= IN_OUT & "1000" & "0011" & "1010";
       when X"06" => pr_op <= IN_OUT & "0000" & "0101" & "0010";
       when X"07" => pr_op <= ALU_B & ALU_B_OR & "00" & "0101" & "0101";
       when X"08" => pr_op <= BRANCH & "0111" & "1110" & "1001";
       when X"09" => pr_op <= LDI & "0000" & "0000" & "0000";
       when X"0A" => pr_op <= LDI & "0000" & "0001" & "0000";
       when X"0B" => pr_op <= LDI & "0000" & "0010" & "0000";
       when X"0C" => pr_op <= RJMP & "----" & "1111" & "1111";
       when others => pr_op <= (others => '-');
      end case;
    end process;

    
    ALU : process (ALU_op,alu_in_a,alu_in_b,pr_SR.C,add_temp)
    begin
      nx_SR.C <= pr_SR.C;
      update_Z <= '1';
      
      case ALU_op is
        when ALU_MOV =>
          alu_out <= alu_in_b;
          update_Z <= '0';
        when ALU_AND =>
          alu_out <= alu_in_a and alu_in_b;
        when ALU_OR =>
          alu_out <= alu_in_a or alu_in_b;
        when ALU_EOR =>
          alu_out <= alu_in_a xor alu_in_b;
        when ALU_ADC =>
          add_temp <= std_logic_vector(unsigned('0' & alu_in_a & '1')+unsigned('0' & alu_in_b & pr_SR.C));
          alu_out <= add_temp(8 downto 1);
          nx_SR.C <= add_temp(9);
        when others =>
          alu_out <= (others => '-');
      end case;
    end process;

    MUX : process (out_mux,alu_out,k)
    begin
      case out_mux is
        when mux_alu => nx_reg <= alu_out;                 
        when mux_lit => nx_reg <= k;
        when mux_ram => nx_reg <= ram_q;
        when mux_in_out => nx_reg <= in_data;
        when others => nx_reg <= (others => '-');
      end case;
    end process;

    RegW : process(clk)
    begin
      if rising_edge(clk) then
        if reg_we='1' then 
          regs (to_integer(unsigned(d_reg))) <= nx_reg;
        end if;
      end if;
    end process RegW;

    NEXT_PC : process(pr_pc,k_jmp)
      variable tmp_pc : std_logic_vector(8 downto 0);
      begin
        tmp_pc := std_logic_vector(signed(pr_pc&'1')+signed(k_jmp&'1'));
        nx_pc <= tmp_pc(8 downto 1);
        end process;

    CONTROL:process(pr_op,pr_pc,pr_SR)
    begin
      out_mux <= mux_alu;
      r_reg <= pr_op(3 downto 0);
      d_reg <= pr_op(7 downto 4);
      reg_we <= '0';
      k_jmp <= (others => '0');
      k <= (others => '-');
      ALU_op <= (others => '-');
      reg_we <= '0';
      port_we <= '0';
      
      case pr_op(15 downto 12) is
        when IN_OUT =>
          if pr_op(11)='1' then
            port_we <= '1';
            port_adr <= pr_op(3 downto 0);
            r_reg <= pr_op(7 downto 4);
          else
            out_mux <= mux_in_out;
            d_reg <= pr_op (7 downto 4);
            reg_we <= '1';
          case pr_op (1 downto 0) is
            when "00" => in_data <= synchA0;
            when "01" => in_data <= synchA1;
            when "10" => in_data <= timer_state;
            when others => null;
          end case;
      end if;
        when BRANCH =>
          if pr_op (10)='0' then
            if pr_SR.Z='1' then
              k_jmp(6 downto 0)<=pr_op(9 downto 3);
              k_jmp(7)<=pr_op(9);
            end if;
          else
            if pr_SR.Z='0' then
              k_jmp(6 downto 0)<=pr_op(9 downto 3);
              k_jmp(7)<=pr_op(9);
            end if;
          end if;
        when RJMP =>
          k_jmp(7 downto 0)<=pr_op(7 downto 0);
        when NOP =>
          null;
        when LDI =>
          d_reg <= pr_op(7 downto 4);
          out_mux <= mux_lit;
          k <= pr_op(11 downto 8)&pr_op(3 downto 0);
          reg_we <= '1';
        when ALU_B=>
          reg_we <= '1';
          case pr_op (11 downto 10) is
            when ALU_B_MOV => ALU_op <= ALU_MOV;
            when ALU_B_EOR => ALU_op <= ALU_EOR;
            when ALU_B_AND => ALU_op <= ALU_AND;
            when ALU_B_OR => ALU_op <= ALU_OR;
            when others => null ;
          end case ;
        when ADC =>
          r_reg <= pr_op(3 downto 0);
          d_reg <= pr_op(7 downto 4);
          out_mux <= mux_alu;
          reg_we <= '1';
          ALU_op <= ALU_ADC;
        when others =>
          null;
      end case;
    end process;

    UPD_z : process(update_Z,alu_out,pr_SR)
    begin
      if update_Z='1' then
        if alu_out=x"00" then
          nx_SR.Z <= '1';
        else
          nx_SR.Z <= '0';
        end if ;
      else
        nx_SR.Z <= pr_SR.Z;
      end if;
    end process;

  PortW:process(clk)
  begin
    if rising_edge(clk) then
      if port_we = '1' then
        case port_adr is
          when "1000" =>
            port_A8i <= regs(to_integer(unsigned(r_reg)));
          when "1001" =>
            port_A9i <= regs(to_integer(unsigned(r_reg)));
          when "1010" =>
            timer_limit <= regs(to_integer(unsigned(r_reg)));
          when others => null;
        end case;
      end if;
    end if;
  end process PortW;

  process(clk)
  begin
    if rising_edge(clk) then
      if port_we = '1' and port_adr = "1010" then
        timer_count <= (others => '0');
        presc_count <= ( others => '0'); 
      else
         if timer_state /=x"00" and presc_tc ='1' then
            timer_count <=std_logic_vector(unsigned(timer_count)+1);
         end if ;
         if presc_tc = '1' then
            presc_count <= (others =>'0');
         else
            presc_count <=std_logic_vector(unsigned(presc_count)+1);
         end if ;
      end if ;
    end if ;
  end process ;

 end behav;
