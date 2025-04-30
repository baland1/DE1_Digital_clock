
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity scoreboard is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           incr : in STD_LOGIC;
           scr_1 : out STD_LOGIC_VECTOR (3 downto 0);
           scr_10 : out STD_LOGIC_VECTOR (3 downto 0));
end scoreboard;

architecture Behavioral of scoreboard is

    signal scr : std_logic_vector (6 downto 0); 

begin
    process (clk) is 
    begin
    if rising_edge(clk) then
        if rst = '1' then
        scr <=(others => '0');
        elsif (incr = '1' and en ='1') and scr < x"63" then
        scr <= scr+1;
        end if;
    end if;
    end process;

-- split the integers using modulo into 2 values on the 10 and 1 position respectively

scr_10 <= std_logic_vector(to_unsigned(to_integer(unsigned(scr)) / 10, 4));
scr_1  <= std_logic_vector(to_unsigned(to_integer(unsigned(scr)) mod 10, 4));


end Behavioral;

