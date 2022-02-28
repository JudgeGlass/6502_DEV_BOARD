; kernal.S
; This file is apart of 6502_DEV_BOARD, GPLv3
; Copyright (c) 2022 Hunter Wilcox

VIA_PORTB = $6000 ; VIA PORT_B I/O pins
VIA_PORTA = $6001 ; VIA PORT_A I/O pins
VIA_PORTB_DDR = $6002 ; VIA PORT_B Data Direction Register (1 -> Output 0 -> Input)
VIA_PORTA_DDR = $6003 ; VIA PORT_A Data Direction Register (1 -> Output 0 -> Input)


.org $8000 ; Start of EEPROM

reset: ; Reset vector routine
    ldx $ff ; Init SP to 0xFF
    txs 




.org $fffc ; Set the reset vector of 65C02
  .word reset
  .word $0000