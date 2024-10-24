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

; Awasu #8
;$77BE, $62D9, $5254, $316C, $6F3B, $41F0, $0842, $18E7, $639E, $575D, $2E9C, $4EDA, $7FFF, $7C1F, $7C1F, $7C1F

	; Color 00
	lda #$BE
	sta CGDATA
	lda #$77
	sta CGDATA

	; Color 01
	lda #$D9   ; palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$62   ; palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 02
	lda #$54   ;palette low byte gggrrrrr
	sta CGDATA ; 1f = 
	lda #$52   ;palette high byte -bbbbbgg
	sta CGDATA ; 


	; Color 03
	lda #$6C   ;palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$31   ;palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 04
	lda #$3B
	sta CGDATA
	lda #$6F
	sta CGDATA

	; Color 05
	lda #$F0   ; palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$41   ; palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 06
	lda #$42   ;palette low byte gggrrrrr
	sta CGDATA ; 1f = 
	lda #$08   ;palette high byte -bbbbbgg
	sta CGDATA ; 


	; Color 07
	lda #$E7   ;palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$18   ;palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 08
	lda #$9E
	sta CGDATA
	lda #$63
	sta CGDATA

	; Color 09
	lda #$5D   ; palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$57   ; palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 0A
	lda #$9C   ;palette low byte gggrrrrr
	sta CGDATA ; 1f = 
	lda #$2E   ;palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 0B
	lda #$DA   ;palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$4E   ;palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 0C
	lda #$FF
	sta CGDATA
	lda #$7F
	sta CGDATA

	; Color 0D 
	lda #$1F   ; palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$7C   ; palette high byte -bbbbbgg
	sta CGDATA ; 

	; Color 0E 
	lda #$1F   ; palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$7C   ; palette high byte -bbbbbgg
	sta CGDATA ; 


	; Color 0F
	lda #$1F   ; palette low byte gggrrrrr
	sta CGDATA ; 
	lda #$7C   ; palette high byte -bbbbbgg
	sta CGDATA ; 


	; Fill remaining pallette with black
	.repeat 240
		lda #$00
		sta CGDATA
		lda #$00
		sta CGDATA
	.endrepeat

	; Set Graphics Mode 1, 8x8 tiles
	lda #%00000001
	sta BGMODE

	; Set BG1 and tile map and character data
	lda #>VRAM_BG1
	sta BG1SC     ; 2107
	lda #VRAM_CHARS
	sta BG12NBA   ; 210B

	;;;;;;;;; Set tilemap as 0s ;;;;;;;;;;
	; Define tile map
	lda #$80
	sta VMAIN     ; $2115
	ldx #VRAM_BG1
	stx VMADDL    ; $2116

	; Write from A to B (D=0) for VRAM (PPP=001) with Fixed Address mode (A=1)
	lda #%00000001  ; DIxA APPP
	sta DMAP1       ; 43n0 DMA Control Register

	; Write to B-Bus 2118
	lda #<VMDATAL   ; 2118
	sta BBAD1       ; 43n1 DMA Destination Register

	ldx #.loword(black_bg)
	stx A1T1L       ; 43n2 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1TnL
	lda #^black_bg
	sta A1B1        ; 4304 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1Bn
	;bg_hi = %00000011 ; Background color -bbbbbgg
	;lda #(bg_hi)
	;sta A1T1H        ; 43n4 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1Bn
	; Define size of transfer
	ldx #(black_bg_end - black_bg)
	stx DAS1L       ; 43n5 DMA Size Registers (Low) https://snes.nesdev.org/wiki/DMA_registers#DASnL

	; Load character data into VRAM - DMA Channel 0
	lda #$80
	sta VMAIN
	ldx #VRAM_CHARS
	stx VMADDL

	; Set transfer pattern (PPP) to 001 for VRAM and D[irection] to 0 (A to B)
	lda #%00000001  ; DIxA APPP
	sta DMAP0       ; 4300 DMA Control Register https://snes.nesdev.org/wiki/DMA_registers#DMAPn

	; Select B-Bus hardware register to read or write from, in the $2100-$21ff range
	lda #<VMDATAL   ; 2118
	sta BBAD0       ; 4301 DMA Destination Register https://snes.nesdev.org/wiki/DMA_registers#BBADn

	ldx #.loword(charset)
	stx A1T0L       ; 4302 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1TnL
	lda #^charset
	sta A1B0        ; 4304 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1Bn
	ldx #(charset_end - charset)
	stx DAS0L       ; 4305 DMA Size Registers (Low) https://snes.nesdev.org/wiki/DMA_registers#DASnL
	
	; Initiate transfer - will be done below
	lda #%00000011  ; Initiate DMA on Channel 0 and 1
	sta MDMAEN      ; 420B DMA Enable Register https://snes.nesdev.org/wiki/DMA_registers#MDMAEN

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
			lda #$04 ; tile number
			sta VMDATAL
			stz VMDATAH
		@start_not_pressed:

		; DOWN
		lda JOY1H ; BYsS UDLR
		bit #%00000100 ; DOWN
		beq @down_not_pressed
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
			ldx #(VRAM_BG1 + (x_pos * 32) + y_pos)
			stx VMADDL
			lda #$03 ; tile number
			sta VMDATAL
			stz VMDATAH
		@right_not_pressed:

		; UP
		lda JOY1H ; BYsS UDLR
		bit #%00001000 ; UP
		beq @up_not_pressed
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