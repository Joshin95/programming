library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity crono is
  port(clk,start,stop,reset:in std_logic;
       a,b:out std_logic_vector(3 downto 0));
end crono;
architecture arc of crono is
  signal a_aux:unsigned(3 downto 0):="0000";
  signal b_aux:unsigned(3 downto 0):="0000";
  signal Ea:std_logic;
  signal Eb:std_logic;
  signal count:unsigned(12 downto 0):="0000000000000";
  signal start_aux:std_logic;
  signal stop_aux:std_logic;
  begin
    process(clk,reset)
      begin
        if rising_edge(clk) then
          if reset='1' then
            a_aux<="0000";
            b_aux<="0000";
          else
            if count="1001110000111" then
              count<="0000000000000";
              if (start='1' and stop='0') then
                b_aux<=b_aux+1;
                if Eb='1' then
                  a_aux<=a_aux+1;
		  b_aux<="0000";	
                  if Ea='1' then
                    a_aux<="0000";
                    b_aux<="0000";
                  end if;
                end if;
              end if;
            else
              count<=count+1;
            end if;
          end if;
        end if;
      end process;
    Ea<='1' when a_aux="1001" else '0';
    Eb<='1' when b_aux="1001" else '0';
    a<=std_logic_vector(a_aux);
    b<=std_logic_vector(b_aux);
end arc;
