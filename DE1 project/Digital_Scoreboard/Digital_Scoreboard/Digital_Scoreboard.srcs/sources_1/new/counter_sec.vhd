-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 01:11:03 PM
-- Design Name: 
-- Module Name: counter_sec - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_sec is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0);
           count_10: out STD_LOGIC_VECTOR (3 downto 0);
           min: out STD_LOGIC_VECTOR (3 downto 0);
           min_10: out STD_LOGIC_VECTOR (3 downto 0);
           ht : out STD_LOGIC_VECTOR (9 downto 0)
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
      if rst ='1' or sig_ht = x"3e8" then
         sig_cnt <= (others => '0');
         sig_cnt_10 <= (others => '0');
         sig_min <= (others => '0');
         sig_min_10 <= (others => '0');
         sig_ht <= (others => '0');
      elsif en ='1' then
         
        if ((sig_min_10 = 4 and sig_min = 5 and sig_cnt_10 = 0 and sig_cnt = 0 and sig_ht < x"384") 
        or (sig_min_10 = 9 and sig_min = 9 and sig_cnt_10 = 5 and sig_cnt = 9)) then
        
            sig_ht <= sig_ht +1;

        else
        sig_cnt <= sig_cnt + 1;
         if sig_cnt = x"9" then 
            sig_cnt <= (others => '0');
            sig_cnt_10 <= sig_cnt_10 + 1;
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

ht <= sig_ht;
count <= sig_cnt;
count_10 <= sig_cnt_10;
min <= sig_min;
min_10 <= sig_min_10;
end Behavioral;

