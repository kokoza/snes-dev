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

	; Color 1 = orange*
	lda #$0e   ; palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$10   ; palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 2 = yellow* rgb = 25 23 4 = R11001G10111B00100
	;                                   RrrrrrGgggggBbbbbb
	lda #%11111001   ;palette low byte gggrrrrr
	sta CGDATA ; 1f = 
	lda #%0010010   ;palette high byte -bbbbbgg
	sta CGDATA ; 


	; Color 3 = blue rgb = 19 29 31 = R10011G11101B11111
	lda #$B3   ;palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$7f   ;palette high byte -bbbbbgg
	sta CGDATA ; 

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
    stz VMDATAH
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
	;ldx #(VRAM_BG1 + (TILE_Y * 32) + TILE_X)
	;stx VMADDL
	;lda #$01 ; tile number
	;sta VMDATAL
	;stz VMDATAH

	; Write a tile to position (3, 3)
	;ldx #(VRAM_BG1 + ((TILE_Y+2) * 32) + TILE_X + 2)
	;stx VMADDL
	;lda #$02 ; tile number
	;sta VMDATAL
	;stz VMDATAH

	; Write a tile to position (8, 3)
	;ldx #(VRAM_BG1 + ((TILE_Y+5) * 32) + TILE_X + 12)
	;stx VMADDL
	;lda #$03 ; tile number
	;sta VMDATAL
	;stz VMDATAH

	; Show BG1
	lda #%00000001
	sta TM

	; turn the screen on (end forced blank)
	lda #$0f
	sta INIDISP

	lda #%00000001
	sta NMITIMEN

	mainloop:
		lda JOY1H ; BYsS UDLR
		bit #%00000100 ; Down button 
		beq @down_not_pressed
			ldx #(VRAM_BG1 + (1 * 32) + 1)
			stx VMADDL
			lda #$01 ; tile number
			sta VMDATAL
			stz VMDATAH
		@down_not_pressed:

		lda JOY1H ; BYsS UDLR
		bit #%00001000 ; UP button 
		beq @up_not_pressed
			ldx #(VRAM_BG1 + (3 * 32) + 3)
			stx VMADDL
			lda #$02 ; tile number
			sta VMDATAL
			stz VMDATAH
		@up_not_pressed:

		lda JOY1H ; BYsS UDLR
		bit #%00000001 ; RIGHT button 
		beq @right_not_pressed
			ldx #(VRAM_BG1 + (5 * 32) + 12)
			stx VMADDL
			lda #$03 ; tile number
			sta VMDATAL
			stz VMDATAH
		@right_not_pressed:

		lda JOY1H ; BYsS UDLR
		bit #%00000010 ; LEFT button 
		beq @left_not_pressed
			ldx #(VRAM_BG1 + (5 * 32) + 12)
			stx VMADDL
			lda #$00 ; tile number
			sta VMDATAL
			stz VMDATAH
		@left_not_pressed:

		lda JOY1H ; BYsS UDLR
		bit #%00010000 ; START button 
		beq @start_not_pressed
			ldx #(VRAM_BG1 + (3 * 32) + 3)
			stx VMADDL
			lda #$00 ; tile number
			sta VMDATAL
			stz VMDATAH
		@start_not_pressed:

		lda JOY1L ; AXlr 0000
		bit #%10000000 ; A button 
		beq @a_not_pressed
			ldx #(VRAM_BG1 + (1 * 32) + 1)
			stx VMADDL
			lda #$00 ; tile number
			sta VMDATAL
			stz VMDATAH
		@a_not_pressed:

	bra mainloop

nmi:
	bit RDNMI
_rti:
	rti

.include "charset.asm"