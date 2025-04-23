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
    Port ( Anodes  :out STD_LOGIC_VECTOR (7 downto 0);
          outp :out STD_LOGIC_VECTOR (3 downto 0);
    
          dig0 : in std_logic_vector (3 downto 0);
          dig1 : in std_logic_vector (3 downto 0);
          dig2 : in std_logic_vector (3 downto 0);
          dig3 : in std_logic_vector (3 downto 0);
          
          dig4 : in std_logic_vector (3 downto 0);
          dig5 : in std_logic_vector (3 downto 0);
          dig6 : in std_logic_vector (3 downto 0);
          dig7 : in std_logic_vector (3 downto 0);
          
          clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          en  : in STD_LOGIC
    );
end anode_picker;

architecture Behavioral of anode_picker is
    signal sig_AN : std_logic_vector(7 downto 0);
    signal sig_outp : std_logic_vector(3 downto 0);
begin
    process (clk)
    begin
    if rising_edge(clk) then
        if rst = '1' or sig_AN = "00000001" then
            sig_AN  <="10000000";
            sig_outp <=(others => '0');
        
        elsif(en = '1') then
        
            sig_AN <= '0' & sig_AN(7 downto 1);

        end if;
        
        case sig_AN is
        
        when "10000000" =>
            sig_outp <= dig7;
        
        when "01000000" =>
            sig_outp <= dig6;
            
        when "00100000" =>
            sig_outp <= dig5;
        
        when "00010000" =>
            sig_outp <= dig4;
            
        when "00001000" =>
            sig_outp <= dig3;
            
        when "00000100" =>
            sig_outp <= dig2;
            
        when "00000010" =>
            sig_outp <= dig1;
            
        when others =>
            sig_outp <= dig0;    
            
        end case;
        
    end if;
    
    
    end process;

Anodes <= not sig_AN;
outp <= sig_outp;
end Behavioral;
