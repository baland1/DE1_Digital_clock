library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity counter_sec is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0);
           count_10: out STD_LOGIC_VECTOR (3 downto 0);
           min: out STD_LOGIC_VECTOR (3 downto 0);
           min_10: out STD_LOGIC_VECTOR (3 downto 0);
           ht : out std_logic
           );
end counter_sec;

architecture Behavioral of counter_sec is
    signal sig_cnt: std_logic_vector (3 downto 0);
    signal sig_cnt_10: std_logic_vector (3 downto 0);
    signal sig_min: std_logic_vector (3 downto 0);
    signal sig_min_10: std_logic_vector (3 downto 0);
    signal sig_ht: std_logic_vector (9 downto 0);
begin
    process (clk)
begin
   if rising_edge(clk) then
   
      if rst ='1' or sig_ht = x"3e8" then -- 3e8 is 1000 seconds
         sig_cnt <= (others => '0');
         sig_cnt_10 <= (others => '0');
         sig_min <= (others => '0');
         sig_min_10 <= (others => '0');
         sig_ht <= (others => '0');
      elsif en ='1' then
        ht <= '0';
         
         -- after reaching 45:00 continue incrementing sig_ht instead of the timer
         -- while sig_ht < 900, send 1 on ht, lighting up a LED
         -- after reaching 99:59 the timer stops, an d sig_ht is incremented again, up to 1000 seconds, where it resets 
        if ((sig_min_10 = 4 and sig_min = 5 and sig_cnt_10 = 0 and sig_cnt = 0 and sig_ht < x"384") -- 384 is 900 seconds
        or (sig_min_10 = 9 and sig_min = 9 and sig_cnt_10 = 5 and sig_cnt = 9)) then 
        
            sig_ht <= sig_ht +1;
            ht <= '1';

        else
        sig_cnt <= sig_cnt + 1;
         if sig_cnt = x"9" then                 -- when the second counter reaches 9, reset it and increment the ten-second counter
            sig_cnt <= (others => '0');         -- when the ten-second counter reaches 5, reset it and increment the minute counter
            sig_cnt_10 <= sig_cnt_10 + 1;       -- and then the ten-minute counter
            if sig_cnt_10 = x"5" then 
                sig_cnt_10 <= (others => '0');
                sig_min <= sig_min +1;
                if sig_min =x"9" then 
                sig_min <= (others => '0');
                sig_min_10 <= sig_min_10 +1;
                end if;
            end if;
        end if;
        end if; 
      end if;
   end if;
   

end process;

count <= sig_cnt;
count_10 <= sig_cnt_10;
min <= sig_min;
min_10 <= sig_min_10;
end Behavioral;

