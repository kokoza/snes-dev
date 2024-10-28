.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "ZEROPAGE"
nmi_count: .res 2
x_pos: .res 1
y_pos: .res 1

.segment "BSS"
oam_lo_buffer: .res 512
oam_hi_buffer: .res 32
oam_buffer_end:

.segment "CODE"

VRAM_CHARS = $0000
VRAM_BG1   = $1000

start:
	.include "init.asm"

	;;;; Set up the color palette ;;;;

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
	.repeat 112
		lda #$00
		sta CGDATA
		lda #$00
		sta CGDATA
	.endrepeat

	;;;; Set up sprite palette ;;;;

	; Color 0 = black
	stz CGDATA
	stz CGDATA

	; Color 1 = orange*
	lda #$0e   ; palette low byte gggrrrrr
	sta CGDATA
	lda #$10   ; palette high byte -bbbbbgg
	sta CGDATA

	; Color 2 = yellow* rgb = 25 23 4 = R11001G10111B00100
	lda #%11111001   ;palette low byte gggrrrrr
	sta CGDATA
	lda #%0010010   ;palette high byte -bbbbbgg
	sta CGDATA

	; Color 3 = blue rgb = 19 29 31 = R10011G11101B11111
	lda #$B3   ;palette low byte gggrrrrr
	sta CGDATA
	lda #$7f   ;palette high byte -bbbbbgg
	sta CGDATA


	; Fill remaining sprite pallette with black
	.repeat 120
		lda #$00
		sta CGDATA
		lda #$00
		sta CGDATA
	.endrepeat


	; Set Graphics Mode 1, 8x8 tiles
	lda #%00000001
	sta BGMODE    ; $2105

	; Set BG1 and tile map and character data
	lda #>VRAM_BG1
	sta BG1SC     ; $2107
	lda #VRAM_CHARS
	sta BG12NBA   ; $210B

	;;;;;;;;; Set tilemap as 0s ;;;;;;;;;;
	; Define tile map
	lda #$80
	sta VMAIN     ; $2115
	ldx #VRAM_BG1
	stx VMADDL    ; $2116

	; Write from A to B (D=0) for VRAM (PPP=001) with Fixed Address mode (A=1)
	lda #%00000001  ; DIxA APPP
	sta DMAP1       ; $43n0 DMA Control Register

	; Write to B-Bus 2118
	lda #<VMDATAL   ; $2118
	sta BBAD1       ; $43n1 DMA Destination Register

	ldx #.loword(bgset)
	stx A1T1L       ; $43n2 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1TnL
	lda #^bgset
	sta A1B1        ; $4304 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1Bn
	; Define size of transfer
	ldx #(bgset_end - bgset)
	stx DAS1L       ; $43n5 DMA Size Registers (Low) https://snes.nesdev.org/wiki/DMA_registers#DASnL
	; Initiate transfer - will be done below
	lda #%00000010  ; Initiate DMA on Channel 0 and 1
	sta MDMAEN      ; $420B DMA Enable Register https://snes.nesdev.org/wiki/DMA_registers#MDMAEN

	; Load character data into VRAM - DMA Channel 0
	lda #$80
	sta VMAIN
	ldx #VRAM_CHARS
	stx VMADDL

	; Set transfer pattern (PPP) to 001 for VRAM and D[irection] to 0 (A to B)
	lda #%00000001  ; DIxA APPP
	sta DMAP0       ; $4300 DMA Control Register https://snes.nesdev.org/wiki/DMA_registers#DMAPn

	; Select B-Bus hardware register to read or write from, in the $2100-$21ff range
	lda #<VMDATAL   ; $2118
	sta BBAD0       ; $4301 DMA Destination Register https://snes.nesdev.org/wiki/DMA_registers#BBADn

	ldx #.loword(charset)
	stx A1T0L       ; $4302 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1TnL
	lda #^charset
	sta A1B0        ; $4304 DMA Source Address Registers https://snes.nesdev.org/wiki/DMA_registers#A1Bn
	ldx #(charset_end - charset)
	stx DAS0L       ; $4305 DMA Size Registers (Low) https://snes.nesdev.org/wiki/DMA_registers#DASnL

	; Initiate transfer - will be done below
	lda #%00000001  ; Initiate DMA on Channel 0 and 1
	sta MDMAEN      ; $420B DMA Enable Register https://snes.nesdev.org/wiki/DMA_registers#MDMAEN

	; Show OBJ + BG1
	lda #%00010001  ; ...O 4321
	sta TM          ; $212C

	; turn the screen on (end forced blank)
	lda #$0f
	sta INIDISP     ; $2100

	lda #%0000000
	sta OBSEL

	ldx #0
@zero_oam:
	stz oam_lo_buffer, x
	inx
	cpx #(oam_buffer_end - oam_lo_buffer)
	bne @zero_oam

	obj_0 = $000c ; Define object one as tile  12

	ldx #120
	stx oam_lo_buffer
	; Set sprite 0 Y position
	ldx #104
	stx oam_lo_buffer + 1
	; Set sprite 0 to priority 3 and tile 0x01 12,13,14
	ldx #((%00110000 << 8) | obj_0) 
	stx oam_lo_buffer + 2

	lda #%10000001
	sta NMITIMEN    ; $4200

	mainloop:
		lda nmi_count
	@nmi_check:
		wai
		cmp nmi_count
		beq @nmi_check

		; Set sprite 0 X position
		ldx oam_lo_buffer
		stx oam_lo_buffer
		; Set sprite 0 Y position
		ldx oam_lo_buffer + 1
		stx oam_lo_buffer + 1
		; Set sprite 0 to priority 3 and tile 0x01 12,13,14
		ldx #((%00110000 << 8) | obj_0) 
		stx oam_lo_buffer + 2

		lda #%00000000 ; Set sprite 0 to be small (8x8)
		;lda #%00000010 ; Set sprite 0 to be large (16x16)
		sta oam_hi_buffer

		jsr up_button
		jsr down_button
		jsr right_button
		jsr left_button

		; Set sprite 0 to priority 3 and tile 0x01 12,13,14
		ldx #((%00110000 << 8) | obj_0) 
		stx oam_lo_buffer + 2

		; Copy OAM data via DMA
		stz OAMADDL
		lda #%00000000
		sta DMAP1 ; DIxA APPP ; Write from A to B (D=0) for VRAM (PPP=001) with Fixed Address mode (A=1)
		lda #<OAMDATA
		sta BBAD1
		ldx #.loword(oam_lo_buffer)
		stx A1T1L
		lda #^oam_lo_buffer
		sta A1B1
		ldx #(oam_buffer_end - oam_lo_buffer)
		stx DAS1L
		lda #%00000010
		sta MDMAEN

	bra mainloop

.proc up_button
		lda JOY1H ; BYsS UDLR
		bit #%00001000 ; UP button 
		beq @up_not_pressed
			; Update sprite 0 Y position
			ldx oam_lo_buffer + 1
			dex
			stx oam_lo_buffer + 1
		@up_not_pressed:
		rts
.endproc

.proc down_button
		lda JOY1H ; BYsS UDLR
		bit #%00000100 ; DOWN button 
		beq @d_not_pressed
			; Update sprite 0 Y position
			ldx oam_lo_buffer + 1
			inx
			stx oam_lo_buffer + 1
		@d_not_pressed:
		rts
.endproc

.proc left_button
		lda JOY1H ; BYsS UDLR
		bit #%00000010 ; LEFT button 
		beq @left_not_pressed
			ldx oam_lo_buffer
			dex
			stx oam_lo_buffer
		@left_not_pressed:
		rts
.endproc

.proc right_button
		lda JOY1H ; BYsS UDLR
		bit #%00000001 ; RIGHT button 
		beq @right_not_pressed
			ldx oam_lo_buffer
			inx
			stx oam_lo_buffer
		@right_not_pressed:
		rts
.endproc

nmi:
	bit RDNMI
	inc nmi_count
_rti:
	rti

.include "charset.asm"
.include "bgset.asm"