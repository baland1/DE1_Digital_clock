-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 24 Apr 2025 13:22:16 GMT
-- Request id : cfwk-fed377c2-680a3b08977a3

library ieee;
use ieee.std_logic_1164.all;

entity tb_debounce is
end tb_debounce;

architecture tb of tb_debounce is

    component debounce
        generic (
        DB_TIME: time:= 25ns
        );
        port (clk       : in std_logic;
              btn_in_R  : in std_logic;
              btn_out_R : out std_logic;
              btn_in_L  : in std_logic;
              btn_out_L : out std_logic;
              edge      : out std_logic;
              rise      : out std_logic;
              fall      : out std_logic);
    end component;

    signal clk       : std_logic;
    signal btn_in_R  : std_logic;
    signal btn_out_R : std_logic;
    signal btn_in_L  : std_logic;
    signal btn_out_L : std_logic;
    signal edge      : std_logic;
    signal rise      : std_logic;
    signal fall      : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : debounce
    port map (clk       => clk,
              btn_in_R  => btn_in_R,
              btn_out_R => btn_out_R,
              btn_in_L  => btn_in_L,
              btn_out_L => btn_out_L,
              edge      => edge,
              rise      => rise,
              fall      => fall);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        btn_in_R <= '0';
        wait for 5*TbPeriod;
        btn_in_R <= '1';

        
        wait for 10*TbPeriod;  
        btn_in_R <= '0';    
        btn_in_L <= '1';

        -- ***EDIT*** Add stimuli here
        wait for 10 * TbPeriod;
        btn_in_L <= '0';
        
        wait for 10* TbPeriod;
        
        btn_in_R <= '0';
        wait for 5*TbPeriod;
        btn_in_R <= '1';

        
        wait for 16*TbPeriod;  
        btn_in_R <= '0';    
        btn_in_L <= '1';

        -- ***EDIT*** Add stimuli here
        wait for 4 * TbPeriod;
        btn_in_L <= '0';

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_debounce of tb_debounce is
    for tb
    end for;
end cfg_tb_debounce;