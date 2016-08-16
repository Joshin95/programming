library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity sintetitzador_tb is
end sintetitzador_tb;
architecture arc of sintetitzador_tb is
component my_sintetitzador
port( clk : in std_logic; key2 : in std_logic_vector(7 downto 0); s : out std_logic); 
end component;
for dut: my_sintetitzador use entity work.sintetitzador;
signal clk:std_logic;
signal key2:std_logic_vector(7 downto 0);
signal s:std_logic;

begin
dut: my_sintetitzador port map(
clk=>clk,
key2=>key2,
s=>s);
clk_proces:process
begin
clk<='0';
wait for 500.0 ns;
for i in 1 to 2000000 loop
clk<=not clk;
wait for 500.0 ns;
end loop;
wait;
end process;

process
  begin
    key2<="10010101";
    wait for 200000000 ns;
    key2<="11101110";
    wait;
end process;

end arc;
