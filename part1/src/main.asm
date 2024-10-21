.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "ZEROPAGE"
nmi_count: .res 2
x_pos: .res 1
y_pos: .res 1

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
	lda #%00000001
	sta DMAP0       ; 4300 DMA Control Register https://snes.nesdev.org/wiki/DMA_registers#DMAPn
	lda #<VMDATAL
	sta BBAD0       ; 4301 DMA Destination Register https://snes.nesdev.org/wiki/DMA_registers#BBADn
	ldx #.loword(charset)
	stx A1T0L       ; 4302 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1TnL
	lda #^charset
	sta A1B0        ; 4304 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1Bn
	ldx #(charset_end - charset)
	stx DAS0L       ; 4305 DMA Size Registers (Low) https://snes.nesdev.org/wiki/DMA_registers#DASnL
	lda #1
	sta MDMAEN      ; 420B DMA Enable Register

	; Show BG1
	lda #%00000001
	sta TM

	; turn the screen on (end forced blank)
	lda #$0f
	sta INIDISP

	lda #%10000001
	sta NMITIMEN

	mainloop:
		lda nmi_count
	@nmi_check:
		wai
		cmp nmi_count
		beq @nmi_check
		
		; START
		lda JOY1H ; BYsS UDLR
		bit #%00010000 ; START button 
		beq @start_not_pressed
			stz x_pos
			stz y_pos
			ldx #(VRAM_BG1 + (x_pos * 32) + y_pos)
			stx VMADDL
			lda #$01 ; tile number
			sta VMDATAL
			stz VMDATAH
		@start_not_pressed:

		; DOWN
		lda JOY1H ; BYsS UDLR
		bit #%00000100 ; DOWN
		beq @down_not_pressed
			ldy x_pos
			@xpos_check:
				cpy x_pos
				iny
				sty x_pos	

			ldx #(VRAM_BG1 + (x_pos * 32) + y_pos)
			stx VMADDL
			lda #$02 ; tile number
			sta VMDATAL
			stz VMDATAH
		@down_not_pressed:
		
		; RIGHT
		lda JOY1H ; BYsS UDLR
		bit #%00000001 ; RIGHT
		beq @right_not_pressed
			ldy y_pos
			iny
			sty y_pos
			ldx #(VRAM_BG1 + (x_pos * 32) + y_pos)
			inx
			stx VMADDL
			lda #$03 ; tile number
			sta VMDATAL
			stz VMDATAH
		@right_not_pressed:

		; UP
		lda JOY1H ; BYsS UDLR
		bit #%00001000 ; UP
		beq @up_not_pressed
			ldy x_pos
			dey
			sty x_pos
			ldx #(VRAM_BG1 + (x_pos * 32) + y_pos)
			stx VMADDL
			lda #$01 ; tile number
			sta VMDATAL
			stz VMDATAH
		@up_not_pressed:

	bra mainloop

nmi:
	bit RDNMI
	inc nmi_count
_rti:
	rti

.include "charset.asm"