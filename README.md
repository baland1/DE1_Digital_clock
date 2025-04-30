# DE1 VHDL lab project
## Team members
- Balajka Andrej
- Mikeš Martin
- Močary Filip
- Mucha Štefan

# Abstract
## possible additions
- switching +- on scoreboard
- pulldown - preventing multiple increments on one button press
- Speaker sound (Start, Half-time, Stop, Goal) 
## components
- 4x - counter (min, sec, score 1, score 2)
- Clock enable
- Bin2Seg
- Anode picker
## I/O
### clock sig.
CLK100MHZ        - in
### Buttons
- BTNC - rst     - in
- BTNR - score 1 - in ( 6 downto 0)
- BTNU - enable for clock enable - in
- BTNL - score 2 - in ( 6 downto 0)
### LEDs and 7 seg
- LED_R - match end   - out
- LED_G - match start - out
- LED_B - half time   - out
- 7 seg display
### Componets desc.
- Counter mins - 7bit positive integer (0 - 99) stop after 100 mins.
- Counter sec  - 6 bit integer (0 - 60) reset after 60 sec. + 1 min.
- score 1      - 7 bit positive integer (0 - 99) after BTNR press +1
- score 2      - 7 bit positive integer (0 - 99) after BTNL press +1
- Anode picker - after 10ms bit <<
- bin2seg
# Hardware description of demo application
to do
![top level image test](images/top_level.svg)
# Software desc.
to do

# References
- to do
