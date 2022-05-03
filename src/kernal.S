; kernal.S
; This file is apart of 6502_DEV_BOARD, GPLv3
; Copyright (c) 2022 Hunter Wilcox

  .include "via.inc"

VIA_PORTB = $6000 ; VIA PORT_B I/O pins
VIA_PORTA = $6001 ; VIA PORT_A I/O pins
VIA_PORTB_DDR = $6002 ; VIA PORT_B Data Direction Register (1 -> Output 0 -> Input)
VIA_PORTA_DDR = $6003 ; VIA PORT_A Data Direction Register (1 -> Output 0 -> Input)


; TI 83 PLUS LCD PIN MAPPING
; D[0..7] -> PB[0..7]
; RW -> PA7
; CE -> PA6
; DI -> PA5
; STB ->PA4
; RST ->PA3
; NC -> PA2, PA1, PA0

;0000 0000
;NC NC NC RST   STB DI CE RW
;
;


  .org $8000 ; Start of EEPROM

reset: ; Reset vector routine
  ldx $ff ; Init SP to 0xFF
  txs 

  lda #$ff
  sta VIA_PORTB_DDR

  lda #$ff
  sta VIA_PORTA_DDR

  lda #$00
  sta VIA_PORTB

  lda #$00
  sta VIA_PORTA

  jmp initLCD

initLCD:
  lda #%00000000
  sta VIA_PORTA
  
  lda #%00011000
  sta VIA_PORTA

  lda #%00000001
  jsr write_lcd

  lda #%00000101
  jsr write_lcd

  lda #%00000011
  jsr write_lcd

  lda #(%11000000 | (48 & %00111111))
  jsr write_lcd

  jmp loop



write_lcd:
  ldx #%00011000
  stx VIA_PORTA

  sta VIA_PORTB

  ldx #%00011010
  stx VIA_PORTA

  rts



loop:
  nop
  jmp loop


  .org $fffc ; Set the reset vector of 65C02
    .word reset
    .word $0000