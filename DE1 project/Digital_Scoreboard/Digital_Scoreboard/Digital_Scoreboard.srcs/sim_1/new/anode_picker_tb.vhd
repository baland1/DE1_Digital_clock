-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Tue, 22 Apr 2025 15:21:46 GMT
-- Request id : cfwk-fed377c2-6807b40a7e5fc

library ieee;
use ieee.std_logic_1164.all;

entity tb_anode_picker is
end tb_anode_picker;

architecture tb of tb_anode_picker is

    component anode_picker
        port (AN   : out std_logic_vector (7 downto 0);
              outp : out std_logic_vector (3 downto 0);
              dig0 : in std_logic_vector (3 downto 0);
              dig1 : in std_logic_vector (3 downto 0);
              dig2 : in std_logic_vector (3 downto 0);
              dig3 : in std_logic_vector (3 downto 0);
              dig4 : in std_logic_vector (3 downto 0);
              dig5 : in std_logic_vector (3 downto 0);
              dig6 : in std_logic_vector (3 downto 0);
              dig7 : in std_logic_vector (3 downto 0);
              clk  : in std_logic;
              rst  : in std_logic;
              en   : in std_logic);
    end component;

    signal AN   : std_logic_vector (7 downto 0);
    signal outp : std_logic_vector (3 downto 0);
    signal dig0 : std_logic_vector (3 downto 0);
    signal dig1 : std_logic_vector (3 downto 0);
    signal dig2 : std_logic_vector (3 downto 0);
    signal dig3 : std_logic_vector (3 downto 0);
    signal dig4 : std_logic_vector (3 downto 0);
    signal dig5 : std_logic_vector (3 downto 0);
    signal dig6 : std_logic_vector (3 downto 0);
    signal dig7 : std_logic_vector (3 downto 0);
    signal clk  : std_logic;
    signal rst  : std_logic;
    signal en   : std_logic;

    constant TbPeriod : time := 100 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : anode_picker
    port map (AN   => AN,
              outp => outp,
              dig0 => dig0,
              dig1 => dig1,
              dig2 => dig2,
              dig3 => dig3,
              dig4 => dig4,
              dig5 => dig5,
              dig6 => dig6,
              dig7 => dig7,
              clk  => clk,
              rst  => rst,
              en   => en);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        dig0 <= "0001";
        dig1 <= "0010";
        dig2 <= "0011";
        dig3 <= "0100";
        dig4 <= "0101";
        dig5 <= "0110";
        dig6 <= "0111";
        dig7 <= "1000";
        en <= '1';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 1000 ns;
        rst <= '0';
        wait for 100 ns;

        

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_anode_picker of tb_anode_picker is
    for tb
    end for;
end cfg_tb_anode_picker;