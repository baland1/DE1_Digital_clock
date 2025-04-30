----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2025 02:30:21 PM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNL : in std_logic;
           BTNR : in std_logic;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           
           LED16_B : out std_logic;
           
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end top_level;

architecture Behavioral of top_level is

-- clock component

component clock_enable is
    Generic (
        periods : integer
    );

    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end component;

-- counter_sec component

component counter_sec is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0);
           count_10: out STD_LOGIC_VECTOR (3 downto 0);
           min: out STD_LOGIC_VECTOR (3 downto 0);
           min_10: out STD_LOGIC_VECTOR (3 downto 0);
           ht : out std_logic
           );
end component;

-- scoreboard component

component scoreboard is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           incr : in STD_LOGIC;
           scr_1 : out STD_LOGIC_VECTOR (3 downto 0);
           scr_10 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

-- anode picker

component anode_picker is
    Port ( Anodes  :out STD_LOGIC_VECTOR (7 downto 0);
          outp :out STD_LOGIC_VECTOR (3 downto 0);
          dec : out std_logic;
    
          dig7 : in std_logic_vector (3 downto 0);
          dig6 : in std_logic_vector (3 downto 0);
          dig5 : in std_logic_vector (3 downto 0);
          dig4 : in std_logic_vector (3 downto 0);
          
          dig3 : in std_logic_vector (3 downto 0);
          dig2 : in std_logic_vector (3 downto 0);
          dig1 : in std_logic_vector (3 downto 0);
          dig0 : in std_logic_vector (3 downto 0);
          
          clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          en  : in STD_LOGIC
    );
    
end component;


-- debouncer
component debounce is
    generic (
        DB_TIME : time := 25 ms
    );
    port (
        clk     : in    std_logic;
        btn_in  : in    std_logic; -- Asynchronous and noisy input
        btn_out : out   std_logic; -- Synchronised, debounced and filtered output
        edge    : out   std_logic;
        rise    : out   std_logic;
        fall    : out   std_logic
    );
end component;
-- bin2seg

component bin2seg is
    Port ( clear : in STD_LOGIC;
           bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

    signal sig_en_1khz2 : std_logic;
    signal sig_en_1hz   : std_logic;
    
    signal min10todig0 : std_logic_vector(3 downto 0);
    signal   mintodig1 : std_logic_vector(3 downto 0);
    signal sec10todig2 : std_logic_vector(3 downto 0);
    signal   sectodig3 : std_logic_vector(3 downto 0);
    
    signal lscr10todig4 : std_logic_vector(3 downto 0);
    signal  lscr1todig5 : std_logic_vector(3 downto 0);
    signal rscr10todig6 : std_logic_vector(3 downto 0);
    signal  rscr1todig7 : std_logic_vector(3 downto 0);
    
    signal toleft : std_logic;
    signal toright: std_logic;
    signal scren_l: std_logic;
    signal scren_r: std_logic;
    
    signal sig_bin : std_logic_vector(3 downto 0);

begin

    DEBOUNCER_L : component debounce
    generic map (DB_TIME=> 25 ms)
    port map(
        btn_in => BTNL,
        clk => CLK100MHZ,
        btn_out => toleft,
        rise => scren_l
    );
    
    DEBOUNCER_R : component debounce
    generic map (DB_TIME=> 25 ms)
    port map(
        btn_in => BTNR,
        clk => CLK100MHZ,
        btn_out => toright,
        rise => scren_r
    );

    CLOCK_1KHZ2 : component clock_enable
    generic map (periods=>100_000)
    port map(
        clk => CLK100MHZ,
        rst => BTNC,
        pulse => sig_en_1khz2
    );
    
    CLOCK_1HZ : component clock_enable
    generic map (periods=>2_000_000)
    port map(
        clk => CLK100MHZ,
        rst => BTNC,
        pulse => sig_en_1hz
    );
    
    SEC_COUNTER : component counter_sec
    port map(
        clk => CLK100MHZ,  -- redundant? likely - might remove them from both counter_sec.vhd and scoreboard.vhd
        rst => BTNC,
        en => sig_en_1hz,
        ht => LED16_B,
        
        min_10=> min10todig0,
        min => mintodig1,
        count_10 => sec10todig2, 
        count => sectodig3
    );
    
    SCOREBOARD_L : component scoreboard
    port map(
        clk => CLK100MHZ,
        rst => BTNC,
        incr => toleft,
        en => scren_l,
        
        scr_10 => lscr10todig4,
        scr_1 => lscr1todig5
        
    );
    
    SCOREBOARD_R : component scoreboard
    port map(
        clk => CLK100MHZ,
        rst => BTNC,
        incr => toright,
        en => scren_r,
        
        scr_10 => rscr10todig6,
        scr_1 => rscr1todig7
        
    );
    
    
    
    
            
    
    DISPLAY : component anode_picker
    port map(
        clk => CLK100MHZ,
        rst => BTNC,
        en => sig_en_1khz2,
        dec => DP,
        
        dig7 => min10todig0,
        dig6 => mintodig1,
        dig5 => sec10todig2, 
        dig4 => sectodig3,
        
        dig3 => lscr10todig4,
        dig2 => lscr1todig5,
        dig1 => rscr10todig6,
        dig0 => rscr1todig7,
        
        Anodes => AN,
        
        outp => sig_bin
    );
    
    BINSEG : component bin2seg
    port map(
        clear => BTNC,
        bin => sig_bin,
        seg(6) => CA,
        seg(5) => CB,
        seg(4) => CC,
        seg(3) => CD,
        seg(2) => CE,
        seg(1) => CF,
        seg(0) => CG
    );
    


end Behavioral;
