

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
          
          dec : out std_logic;
          
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
    -- start cycling
    
    if rising_edge(clk) then
        if rst = '1' or sig_AN = "00000000" then -- return back to the first position
            sig_AN  <="10000000";
            sig_outp <=(others => '0');
        
        elsif(en = '1') then
        
            sig_AN <= '0' & sig_AN(7 downto 1);

        end if;
        
        case sig_AN is
        
        -- assign the proper integer to the proper position
        
        when "10000000" =>
            sig_outp <= dig7;
            dec <= '1';
        
        when "01000000" =>
            sig_outp <= dig6;
            dec <= '0'; -- lighting up the DP when on position 6, using it as a stand-in for a colon
            
        when "00100000" =>
            sig_outp <= dig5;
            dec <= '1';
        
        when "00010000" =>
            sig_outp <= dig4;
            dec <= '1';
            
        when "00001000" =>
            sig_outp <= dig3;
            dec <= '1';
            
        when "00000100" =>
            sig_outp <= dig2;
            dec <= '0'; -- lighting up the DP when on position 2, using it as a stand-in for a colon
            
        when "00000010" =>
            sig_outp <= dig1;
            dec <= '1';
            
        when others =>
            sig_outp <= dig0;
            dec <= '1';    
            
        end case;
        
    end if;
    
    
    end process;

Anodes <= not sig_AN;
outp <= sig_outp;
end Behavioral;
