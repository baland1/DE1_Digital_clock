# Design
## components
4x - counter (min, sec, score 1, score 2)
Clock enable
Bin2Seg
Anode picker
## I/O
### clock sig.
CLK100MHZ      - in
### Buttons
BTNC - rst     - in
BTNL - score 1 - in ( 6 downto 0)
BTNU - enable for clock enable - in
BTNR - score 2 - in ( 6 downto 0)
### LEDs
LED_R - match end   - out
LED_G - match start - out
LED_B - half time   - out
