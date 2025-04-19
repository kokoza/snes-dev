.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "ZEROPAGE"
nmi_count: .res 2
controller: .res 1 ; Reserve 1 byte

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
	; Load colors for BG (Awasu #8)
	load_color $BE, $77 ; Color 00
	load_color $D9, $62 ; Color 01
	load_color $54, $52 ; Color 02 
	load_color $6C, $31 ; Color 03
	load_color $3B, $6F ; Color 04
	load_color $F0, $41 ; Color 05
	load_color $42, $08 ; Color 06
	load_color $E7, $18 ; Color 07
	load_color $9E, $63 ; Color 08
	load_color $5D, $57 ; Color 09
	load_color $9C, $2E ; Color 0A
	load_color $DA, $4E ; Color 0B
	load_color $FF, $7F ; Color 0C
	load_color $1F, $7C ; Color 0D
	load_color $1F, $7C ; Color 0E
	load_color $1F, $7C ; Color 0F

	; Fill remaining pallette with black
	.repeat 112
		load_color $00, $00 
	.endrepeat

	;;;; Set up sprite palette (starting at index 128) ;;;;

	
	load_color $00, $00 ; Sprite Row 0 - Color 0 = black
	load_color $0E, $10 ; Sprite Row 0 - Color 1 = orange
	load_color %11111001, %0010010 ; Sprite Row 0 - Color 2 = yellow* rgb = 25 23 4 => R11001 g.G10.111 B00100 -> GR = 11111001 and Bg = 10
	load_color $B3, $7F ; Sprite Row 0 - Color 3 = blue rgb = 19 29 31 = R10011G11101B11111

	; Fill remaining sprite pallette row with black
	.repeat 12
		load_color $00, $00 
	.endrepeat

	load_color $00, $00 ; Sprite Row 1 - Color 0 = black -- KOLOBOK
	load_color %00100000, %0000100 ; Sprite Row 1 - Color 1 = RGB = ?? ?? ?? 
	load_color %11010110, %0000101 ; Sprite Row 1 - Color 2 = RGB = 22 14 01 => R10110 g.G01.110 B00001 -> GR = 11010110 and Bg = B0000101
	load_color %01111011, %0001010 ; Sprite Row 1 - Color 3 = RGB = 27 19 02 => 11011 10 011 00010
	load_color %00111110, %0010111 ; Sprite Row 1 - Color 4 = RGB = 30 25 05 => 11110 11 001 00101
	load_color %01111110, %0100111 ; Sprite Row 1 - Color 5 = RGB = 30 27 09 => 11110 11 011 01001

	; Fill remaining sprite pallette row with black
	.repeat 10
		load_color $00, $00 
	.endrepeat

	; Fill remaining sprite pallette with black
	.repeat 96
		load_color $00, $00 
	.endrepeat


	; Set Graphics Mode 1, 8x8 tiles
	lda #%00000001 ; 4321 PMMM MMM - BG mode see https://snes.nesdev.org/wiki/PPU_registers#BGMODE
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

	; Write from A to B (D=0) for VRAM (PPP=001), Incrementing A Bus after copy (AA=0) https://snes.nesdev.org/wiki/DMA_registers#DMAPn
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

	lda #%00000000
	sta OBSEL

	ldx #0
@zero_oam:
	stz oam_lo_buffer, x
	inx
	cpx #(oam_buffer_end - oam_lo_buffer)
	bne @zero_oam

	obj_0 = $0010 ; Define object one as tile  16

	; Set sprite 0 X position?
	ldx #120
	stx oam_lo_buffer
	; Set sprite 0 Y position
	ldx #104
	stx oam_lo_buffer + 1
	; Set sprite 0 to priority 3 and palette to 001
	ldx #((%00110010 << 8) | obj_0) ; vhoopppN ppp = Palette of the sprite. The first palette index is 128+ppp*16. oo = Sprite priority.
	stx oam_lo_buffer + 2

	lda #%10000001
	sta NMITIMEN    ; $4200

	mainloop:
		lda nmi_count
	@nmi_check:
		wai
		cmp nmi_count
		beq @nmi_check

	    jsr handle_input   ; Now uses pre-latched controller byte
	    ;jsr update_game    ; Game logic here if needed
	    ;jsr draw_sprites   ; Optional, or do DMA to OAM directly here
		; Set sprite 0 X position
		ldx oam_lo_buffer
		stx oam_lo_buffer
		; Set sprite 0 Y position
		ldx oam_lo_buffer + 1
		stx oam_lo_buffer + 1
		; Set sprite 0 to priority 3 and palette to 001
		ldx #((%00110010 << 8) | obj_0) ; vhoopppN ppp = Palette of the sprite. The first palette index is 128+ppp*16. oo = Sprite priority.
		stx oam_lo_buffer + 2

		;lda #%00000000 ; Set sprite 0 to be small (8x8 or 16x16 depending on OBSEL)
		lda #%00000010 ; Set sprite 0 to be large (16x16 or 32x32 depending on OBSEL)
		sta oam_hi_buffer

		jsr handle_input

		; Set sprite 0 to priority 3 and palette to 001
		ldx #((%00110010 << 8) | obj_0) ; vhoopppN ppp = Palette of the sprite. The first palette index is 128+ppp*16. oo = Sprite priority.
		stx oam_lo_buffer + 2

		; Copy OAM data via DMA
		stz OAMADDL
		lda #%00000000 ; DIxA APPP https://snes.nesdev.org/wiki/DMA_registers#DMAPn
		sta DMAP1      ; Write from A to B (D=0), for WRAM (PPP=000), Incrementing A Bus after copy (AA=0)
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

.proc handle_input
    ; Load controller to accumulator
    lda controller

    ; UP (bit 3)
    bit #%00001000 ; Up - BYsS UDLR
    beq @not_up
        dec oam_lo_buffer + 1
    @not_up:

    ; DOWN (bit 2)
    bit #%00000100 ; Down - BYsS UDLR
    beq @not_down
        inc oam_lo_buffer + 1
    @not_down:

    ; LEFT (bit 1)
    bit #%00000010 ; Left - BYsS UDLR
    beq @not_left
        dec oam_lo_buffer
    @not_left:

    ; RIGHT (bit 0)
    bit #%00000001 ; Right - BYsS UDLR
    beq @not_right
        inc oam_lo_buffer
    @not_right:

    rts
.endproc



nmi:
	bit RDNMI         ; $4210 - Clear NMI flag

	; Latch controller input
    lda #%00000001
    sta $4016
    stz $4016

    ; Read controller input
    lda $4218         ; JOY1L - ignored in your case
    lda $4219         ; JOY1H - BYsSUDLR
    sta controller    ; Store for use in main loop

    ; Optional: Copy OAM here (can stay in main loop too if working fine)

    ; Signal main loop that a new frame has started
	inc nmi_count
_rti:
	rti

.include "charset.asm"
.include "bgset.asm"