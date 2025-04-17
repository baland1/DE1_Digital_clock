----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2025 01:41:06 PM
-- Design Name: 
-- Module Name: scoreboard - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scoreboard is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           incr_L : in STD_LOGIC;
           incr_R : in STD_LOGIC;
           L_scr_1 : out STD_LOGIC_VECTOR (3 downto 0);
           L_scr_10 : out STD_LOGIC_VECTOR (3 downto 0);
           R_scr_1 : out STD_LOGIC_VECTOR (3 downto 0);
           R_scr_10 : out STD_LOGIC_VECTOR (3 downto 0));
end scoreboard;

architecture Behavioral of scoreboard is

    signal l_scr : std_logic_vector (6 downto 0); 
    signal r_scr : std_logic_vector (6 downto 0); 

begin
    process (clk) is 
    begin
    if rising_edge(clk) then
        if rst = '1' then
        l_scr <=(others => '0');
        r_scr <=(others => '0');
        elsif (incr_L = '1') then
        l_scr <= l_scr+1;
        elsif (incr_R = '1') then
        r_scr <= r_scr+1;
        end if;
    end if;
    end process;

L_scr_10 <= std_logic_vector(to_unsigned(to_integer(unsigned(l_scr)) / 10, 4));
L_scr_1  <= std_logic_vector(to_unsigned(to_integer(unsigned(l_scr)) mod 10, 4));

R_scr_10 <= std_logic_vector(to_unsigned(to_integer(unsigned(r_scr)) / 10, 4));
R_scr_1  <= std_logic_vector(to_unsigned(to_integer(unsigned(r_scr)) mod 10, 4));

end Behavioral;

