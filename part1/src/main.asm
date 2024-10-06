.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "CODE"

VRAM_CHARS = $0000
VRAM_BG1   = $1000

start:
	.include "init.asm"

	; Set up the color palette

	; set color address to 0
	stz CGADD
	
	; Color 0 = black
	lda #$00
	sta CGDATA
	lda #$00
	sta CGDATA

	; Color 1 = red
	lda #$0e   ;palette low byte gggrrrrr
	sta CGDATA ; 1f = all the red bits
	lda #$10   ;palette high byte -bbbbbgg
	sta CGDATA ; store zero for high byte

	; Color 2 = green
	lda #$0b   ;palette low byte gggrrrrr
	sta CGDATA ; 1f = all the red bits
	lda #$02   ;palette high byte -bbbbbgg
	sta CGDATA ; store zero for high byte


	; Color 3 = blue
	lda #$00   ;palette low byte gggrrrrr
	sta CGDATA ; 1f = all the red bits
	lda #$d1   ;palette high byte -bbbbbgg
	sta CGDATA ; store zero for high byte

	; Set Graphics Mode 0, 8x8 tiles
	stz BGMODE

	; Set BG1 and tile map and character data
	lda #>VRAM_BG1
	sta BG1SC
	lda #VRAM_CHARS
	sta BG12NBA

	; Set tilemap as 0s
	lda #$80
	sta VMAIN
	ldx #VRAM_BG1
	stx VMADDL
	ldx #0
	ldy #%01000010
@bgset_loop:
    stz VMDATAL
    sty VMDATAH
    inx
    cpx #1024
    bne @bgset_loop


	; Load character data into VRAM
	lda #$80
	sta VMAIN
	ldx #VRAM_CHARS
	stx VMADDL
	ldx #0
@charset_loop:
	lda charset,x
	sta VMDATAL
	inx
	lda charset,x
	sta VMDATAH
	inx
	cpx #(charset_end - charset)
	bne @charset_loop

	; Write a tile to position (1, 1)
	TILE_X = 1
	TILE_Y = 1
	ldx #(VRAM_BG1 + (TILE_Y * 32) + TILE_X)
	stx VMADDL
	lda #$01 ; tile number
	sta VMDATAL
	stz VMDATAH

	; Show BG1
	lda #%00000001
	sta TM

	; turn the screen on (end forced blank)
	lda #$0f
	sta INIDISP

busywait:
	bra busywait

nmi:
	bit RDNMI
_rti:
	rti

.include "charset.asm"