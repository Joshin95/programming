library ieee;
use ieee.std_logic_1164.all;
entity decodificador_tb is
end decodificador_tb;

architecture behav of decodificador_tb is
component my_decodificador
port(x,y: in std_logic_vector(3 downto 0);
       ax,bx,cx,dx,ex,fx,gx,ay,by,cy,dy,ey,fy,gy:out std_logic);
end component;
for dut: my_decodificador use entity work.decodificador;
signal x,y :std_logic_vector(3 downto 0);
signal ax,bx,cx,dx,ex,fx,gx,ay,by,cy,dy,ey,fy,gy:std_logic;
begin
  dut: my_decodificador port map(
    x=>x,
    y=>y,
    ax=>ax,
    bx=>bx,
    cx=>cx,
    dx=>dx,
    ex=>ex,
    fx=>fx,
    gx=>gx,
    ay=>ay,
    by=>by,
    cy=>cy,
    dy=>dy,
    ey=>ey,
    fy=>fy,
    gy=>gy);


process
  begin
    x<="0001";
    y<="0011";
    wait for 1 sec;
    x<="0000";
    y<="0001";
    wait;
end process;
end behav;
