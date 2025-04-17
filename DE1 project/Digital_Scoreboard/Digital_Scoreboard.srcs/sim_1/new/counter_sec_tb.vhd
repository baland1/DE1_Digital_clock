-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 17 Apr 2025 11:34:19 GMT
-- Request id : cfwk-fed377c2-6800e73be13e3

library ieee;
use ieee.std_logic_1164.all;

entity tb_counter_sec is
end tb_counter_sec;

architecture tb of tb_counter_sec is

    component counter_sec
        port (clk      : in std_logic;
              rst      : in std_logic;
              en       : in std_logic;
              count    : out std_logic_vector (3 downto 0);
              count_10 : out std_logic_vector (2 downto 0);
              min      : out std_logic_vector (3 downto 0);
              min_10   : out std_logic_vector (3 downto 0);
              ht       : out std_logic_vector (3 downto 0));
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal en       : std_logic;
    signal count    : std_logic_vector (3 downto 0);
    signal count_10 : std_logic_vector (2 downto 0);
    signal min      : std_logic_vector (3 downto 0);
    signal min_10   : std_logic_vector (3 downto 0);
    signal ht       : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 1 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : counter_sec
    port map (clk      => clk,
              rst      => rst,
              en       => en,
              count    => count,
              count_10 => count_10,
              min      => min,
              min_10   => min_10,
              ht       => ht);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        en <= '1';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;

        -- EDIT Add stimuli here
        wait for 1000 * TbPeriod;
        
        en <= '0';
        wait for 21 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_counter_sec of tb_counter_sec is
    for tb
    end for;
end cfg_tb_counter_sec;