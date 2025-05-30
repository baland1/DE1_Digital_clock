# DE1 VHDL lab project
## Team members
- Balajka Andrej
- Mikeš Martin
- Močary Filip
- Mucha Štefan

# Abstract
This project is focused on creating a digital scoreboard using FPGA board Nexys A7 50T. 
The goal is to create a digital timer that counts to 99:59 and a digital scoreboard that can count up to 99:99.
The digital timer stops at 45:00 for 900 seconds (15 minutes). A blue LED also lights up to signal the match is paused. The clock also stops for 100 seconds after reaching 99:59.
# Hardware description of demo application
[![DEMO](https://img.youtube.com/vi/V-X2oO7Ix2E/0.jpg)](https://www.youtube.com/watch?v=V-X2oO7Ix2E)<br/>
<br/>
The [top-level](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.runs/impl_1/top_level.bit) application consists of:
- 2x clock_enable: 1 Hz clock for the timer ( 50 Hz for the demo), 1 kHz clock for controlling the input for the 7-segment display.
- 2x debounce: One for the left and one for the right score. The debouncer is used to ensure the scores only get incremented by 1 at a time.
- counter_sec: Incremented with each cycle of the 1Hz clock. Also includes logic for pausing the game at given times.
- 2x scoreboard: Increments score after pressing button and receiving signal from debouncer.
- anode_picker: cycles through anodes of the 7-segment displays to display the correct digit at the correct position.
- bin2seg: convert binary code to 7-segment display code. 
![top-level](images/top_level.svg)
# Software description
### [clock_enable](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/clock_enable.vhd)
- taken from the [vhdl course](https://github.com/tomas-fryza/vhdl-labs/blob/master/solutions/lab5-counter/clock_en.vhd). Used for the timer component counter_sec (1 Hz clock, 50 Hz for demonstration purposes) and for the anode_picker component (1 kHz to ensure seamless display of digits).
- inputs: CLK100MHZ (clock) and BTNC (reset).
- output pulse to sec_counter/anode_picker. <br/>
### [debounce](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/debounce.vhd)
- Taken from the [vhdl course](https://github.com/tomas-fryza/vhdl-labs/tree/master/lab7-uart), originally from [stackoverflow](https://stackoverflow.com/questions/61630181/vhdl-button-debouncing-or-not-as-the-case-may-be). Used to debounce buttons for scoreboard_l and scoreboard_r.
- inputs: BTNL/R (btn_in) and CLK100MHZ (clk).
- outputs: btn_out and rise to the scoreboard. <br/>
### [counter_sec](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/counter_sec.vhd)
- This component increments the seconds up to 9. After reaching 9, the signal count_10 is incremented by 1 up to a maximum of 5. The signal count is reset. When count reaches 9 and count_10 reaches 5, the signal min is incremented, up to a maximum of 9. count and count_10 are reset. Once min reaches 9, the variable min_10 is incremented up to a maximum of 9. The counter stops at 45:00, and the signal sig_ht is incremented instead. When this signal reaches 900, the main counter resumes. A LED is lit up for the duration to signify correct operation. Similarly, the counter stops at 99:59 while sig_ht is incremented up to 100, after which the counter resets back to 00:00.
- inputs: CLK100MHZ (clk), BTNC (rst), pulse from clock 1HZ
- outputs: min_10, min, count_10, count to anode_picker and ht to LED16_B<br/>
<br/><br/>
![counter_sec_1](images/counter_sec_1.png) <p align="center">[simulation](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sim_1/new/counter_sec_tb.vhd)</p>
<br/><br/>
![counter_sec_2](images/counter_sec_2.png) <p align="center">first 50 seconds of the simulation</p>
<br/><br/><br/>
### [scoreboard](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/scoreboard.vhd)
- After receiving pulse and button signals from debouncer, and while signal scr is less than 99, it's incremented. The signal is then split into scr_10 and scr_1 using the modulo operation. These signals are then sent to the anode picker component.
- inputs: CLK100MHZ (clk), BTNC (rst), btn_out (incr) & rise (en) from debouncer
- outputs: scr_10 and scr_1 to anode_picker<br/><br/><br/>
![scoreboard](images/scoreboard_1.png) <p align="center">[simulation](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sim_1/new/scoreboard_tb.vhd)</p>
<br/><br/><br/>
### [anode_picker](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/new/anode_picker.vhd)
- This component cycles through the anodes of the 7-seg display, Assigning the proper value to each anode. Some positions also have the decimal point light up to act as a colon, separating minutes and seconds and the left team's and right team's scores.
- inputs: CLK100MHZ (clk), BTNC (rst), pulse from clock 1KHZ2, digits dig7-4 from counter_sec and digits dig3-0 from the scoreboards.
- outputs: outp to bin2seg, dec to DP, anodes to AN<br/><br/><br/>
![anodepicker](images/anodepicker_1.png) <p align="center">[simulation](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sim_1/new/anode_picker_tb.vhd)</p>
<br/><br/><br/>
### [bin2seg](https://github.com/baland1/DE1_Digital_clock/blob/main/DE1%20project/Digital_Scoreboard/Digital_Scoreboard.srcs/sources_1/imports/new/bin2seg.vhd)
- Taken from the [vhdl course](https://github.com/tomas-fryza/vhdl-labs/tree/master/lab3-segment). Converts binary code from anode_picker to 7-segment code for the 7-segment display.
- inputs: BTNC (clr), outp (bin) from anode_picker
- outputs: seg to each bit of the 7-segment display (CA-CG)
  
# References
- [doc. Ing. Tomáš Frýza,Ph.D github](https://github.com/tomas-fryza/vhdl-labs/tree/master)<br/>
- [digital clock vhdl](https://www.instructables.com/Digital-Clock-in-VHDL/)<br/>
- [Copilot Microsoft AI](https://copilot.microsoft.com)<br/>
- [stackoverflow](https://stackoverflow.com/questions/61630181/vhdl-button-debouncing-or-not-as-the-case-may-be)<br/>
- [vhdl.lapinoo.net](https://vhdl.lapinoo.net/)
