----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2025 02:43:51 PM
-- Design Name: 
-- Module Name: anode_picker - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity anode_picker is
    Port ( AN  :out STD_LOGIC_VECTOR (7 downto 0);
          dig0 : in std_logic_vector (3 downto 0);
          dig1 : in std_logic_vector (3 downto 0);
          dig2 : in std_logic_vector (3 downto 0);
          dig3 : in std_logic_vector (3 downto 0);
          
          dig4 : in std_logic_vector (3 downto 0);
          dig5 : in std_logic_vector (3 downto 0);
          dig6 : in std_logic_vector (3 downto 0);
          dig7 : in std_logic_vector (3 downto 0)
    );
end anode_picker;

architecture Behavioral of anode_picker is

begin


end Behavioral;
