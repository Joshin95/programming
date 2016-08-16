library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity crono_tb is
end crono_tb;

architecture arc of crono_tb is
component my_crono
port(clk,start,stop,reset: in std_logic;
     a,b: out std_logic_vector(3 downto 0));
end component;
for dut: my_crono use entity work.crono;

signal clk: std_logic;
signal start: std_logic;
signal stop: std_logic;
signal reset: std_logic;
signal a: std_logic_vector(3 downto 0);
signal b: std_logic_vector(3 downto 0);
begin
  dut: my_crono port map(
    clk=>clk,
    start=>start,
    stop=>stop,
    reset=>reset,
    a=>a,
    b=>b);
  clk_process:process
    begin
      clk<='0';
      wait for 10000 ns;
      for i in 1 to 1000000 loop
        clk<=not clk;
        wait for 10000 ns;
      end loop;
      wait;
    end process clk_process;
    reset<='0',
           '1' after 7000000000 ns;
    start<='1';
    stop<='0',
          '1' after 5000000000 ns;
end arc;
