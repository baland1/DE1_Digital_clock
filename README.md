# DE1 VHDL lab project
## Team members
- Balajka Andrej
- Mikeš Martin
- Močary Filip
- Mucha Štefan

# Abstract
This project is focused on creating a digital scoreboard using FPGA board Nexys A7 50T. 
The goal is to create a digital timer that counts to 99:59 and a digital scoreboard that can count up to 99:99.
The digital timer stops at 45:00 for 900 seconds (15minutes) and a blue LED lights up which signals that the match reached the end of the first half and also that pause is in effect. The clock also stops for 100 seconds after reaching 99:59.
# Hardware description of demo application
The top-level application consists of:
- 2x clock: 1Hz clock for the timer(50Hz for the demo), 1KHz clock for controling the output for the 7-segment display.
- 2x debouncer: One for the left and one for the right score.
- counter sec: Increments each cycle of the 1Hz clock. Also includes logic for pausing the game at the given time.
- 2x scoreboard: Increments score after pressing button and receiving signal from debouncer.
- anode picker: cycle through anodes of the 7-segment display and displays the correct digit at the correct position.
- bin2seg: convert binary code to 7-segment display code. 
![top-level](images/top_level.svg)
# Software description
[clock_enable:](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/clock_enable.vhd) taken from the vhdl course. <br/>
[debouncer:](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/debounce.vhd) taken from vhdl course, originally from [stackoverflow](https://stackoverflow.com/questions/61630181/vhdl-button-debouncing-or-not-as-the-case-may-be). <br/>
[counter_sec:](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/counter_sec.vhd) this component functions in a way that increments seconds up to 9 after reaching 9 variable sec_10 is incremented up to 5. After sec reach 9 and sec_10 reach 5 variable mins is incremented up to 9 after min reach 9 variable min_10 is incremented up to 9.<br/>
[testbench](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sim_1/new/counter_sec_tb.vhd)
![counter_sec_1](images/counter_sec_1.png) whole test.
![counter_sec_2](images/counter_sec_2.png) first 50 seconds.


# References
- to do
