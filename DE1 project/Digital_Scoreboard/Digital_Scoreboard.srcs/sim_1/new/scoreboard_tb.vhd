-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sun, 04 May 2025 11:57:11 GMT
-- Request id : cfwk-fed377c2-6817561759014

library ieee;
use ieee.std_logic_1164.all;

entity tb_scoreboard is
end tb_scoreboard;

architecture tb of tb_scoreboard is

    component scoreboard
        port (clk    : in std_logic;
              rst    : in std_logic;
              en     : in std_logic;
              incr   : in std_logic;
              scr_1  : out std_logic_vector (3 downto 0);
              scr_10 : out std_logic_vector (3 downto 0));
    end component;

    signal clk    : std_logic;
    signal rst    : std_logic;
    signal en     : std_logic;
    signal incr   : std_logic;
    signal scr_1  : std_logic_vector (3 downto 0);
    signal scr_10 : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : scoreboard
    port map (clk    => clk,
              rst    => rst,
              en     => en,
              incr   => incr,
              scr_1  => scr_1,
              scr_10 => scr_10);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

        stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        en <= '1';
        incr <= '1';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
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

configuration cfg_tb_scoreboard of tb_scoreboard is
    for tb
    end for;
end cfg_tb_scoreboard;