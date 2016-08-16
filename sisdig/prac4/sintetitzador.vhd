library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sintetitzador is
  port( clk : in std_logic;
        key2 : in std_logic_vector(7 downto 0);
        s : out std_logic);
end sintetitzador;

architecture arc of sintetitzador is
  signal comptador : unsigned(6 downto 0):= "0000000";
  signal play: std_logic:='0';
  signal clk_aux : std_logic:='0';
  signal cicles : integer:=0;
  signal key : unsigned(6 downto 0):= "0000000";
  signal count : unsigned(14 downto 0):="000000000000000";
  signal sortida : std_logic:='0';
                                         
begin

  play<=std_logic(key2(7));
  key<=unsigned(key2(6 downto 0));
  
    cicles<= 18182 when key=21 else
             17161 when key=22 else
             16198 when key=23 else
             15289 when key=24 else
             14431 when key=25 else
             13621 when key=26 else
             12856 when key=27 else
             12135 when key=28 else
             11454 when key=29 else
             10811 when key=30 else
             10204 when key=31 else
             9631 when key=32 else
             9091 when key=33 else
             8581 when key=34 else
             8099 when key=35 else
             7645 when key=36 else
             7215 when key=37 else
             6810 when key=38 else
             6428 when key=39 else
             6067 when key=40 else
             5727 when key=41 else
             5405 when key=42 else
             5102 when key=43 else
             4816 when key=44 else
             4545 when key=45 else
             4290 when key=46 else
             4050 when key=47 else
             3822 when key=48 else
             3608 when key=49 else
             3405 when key=50 else
             3214 when key=51 else
             3034 when key=52 else
             2863 when key=53 else
             2703 when key=54 else
             2551 when key=55 else
             2408 when key=56 else
             2273 when key=57 else
             2145 when key=58 else
             2025 when key=59 else
             1911 when key=60 else
             1804 when key=61 else
             1703 when key=62 else
             1607 when key=63 else
             1517 when key=64 else
             1432 when key=65 else
             1351 when key=66 else
             1276 when key=67 else
             1204 when key=68 else
             1136 when key=69 else
             1073 when key=70 else
             1012 when key=71 else
             956 when key=72 else
             902 when key=73 else
             851 when key=74 else
             804 when key=75 else
             758 when key=76 else
             716 when key=77 else
             676 when key=78 else
             638 when key=79 else
             602 when key=80 else
             568 when key=81 else
             536 when key=82 else
             506 when key=83 else
             478 when key=84 else
             451 when key=85 else
             426 when key=86 else
             402 when key=87 else
             379 when key=88 else
             358 when key=89 else
             338 when key=90 else
             319 when key=91 else
             301 when key=92 else
             284 when key=93 else
             268 when key=94 else
             253 when key=95 else
             239 when key=96 else
             225 when key=97 else
             213 when key=98 else
             201 when key=99 else
             190 when key=100 else
             179 when key=101 else
             169 when key=102 else
             159 when key=103 else
             150 when key=104 else
             142 when key=105 else
             134 when key=106 else
             127 when key=107 else
             119 when key=108 else
             113 when key=109 else 
             106 when key=110 else
             100 when key=111 else
             95 when key=112 else
             89 when key=113 else
             84 when key=114 else
             80 when key=115 else
             75 when key=116 else
             71 when key = 117 else
             0;
        
    process(clk)
      begin
        if rising_edge(clk) then
          if play='1' then
            if count=(cicles/2) then
              sortida<=not(sortida);
              count<="000000000000000";
            else
              count<=count+"000000000000001";
            end if;
          else
            sortida<='0';
          end if;
        end if;
    end process;
    s<=sortida;
end arc;
     
             
          
          
