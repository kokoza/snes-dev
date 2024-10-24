charset:

	; tile %00 - row 1-2 - c0123 = %0110 black (0110)
        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00000000 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000000 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %00000000 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %11111111 ; row 0, color 2
        .byte   %00000000 ; row 0, color 3
        .byte   %11111111 ; row 1, color 2
        .byte   %00000000 ; row 1, color 3
        .byte   %11111111 ; row 2, color 2
        .byte   %00000000 ; row 2, color 3
        .byte   %11111111 ; row 3, color 2
        .byte   %00000000 ; row 3, color 3
        .byte   %11111111 ; row 4, color 2
        .byte   %00000000 ; row 4, color 3
        .byte   %11111111 ; row 5, color 2
        .byte   %00000000 ; row 5, color 3
        .byte   %11111111 ; row 6, color 2
        .byte   %00000000 ; row 6, color 3
        .byte   %11111111 ; row 7, color 2
        .byte   %00000000 ; row 7, color 3

    ; tile %01 - row 3 - black (0110) with some rando gray (0011)
        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00000000 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000000 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %01100000 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %11111111 ; row 0, color 2
        .byte   %00000000 ; row 0, color 3
        .byte   %11111111 ; row 1, color 2
        .byte   %00000000 ; row 1, color 3
        .byte   %11111111 ; row 2, color 2
        .byte   %00000000 ; row 2, color 3
        .byte   %11111111 ; row 3, color 2
        .byte   %00000000 ; row 3, color 3
        .byte   %11111111 ; row 4, color 2
        .byte   %00000000 ; row 4, color 3
        .byte   %11111111 ; row 5, color 2
        .byte   %00000000 ; row 5, color 3
        .byte   %11111111 ; row 6, color 2
        .byte   %00000000 ; row 6, color 3
        .byte   %10011111 ; row 7, color 2
        .byte   %00000000 ; row 7, color 3

    ; tile %10 - row 3 - black (0110) with some rando gray (0011)
        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00000000 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000000 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %00010000 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %11111111 ; row 0, color 2
        .byte   %00000000 ; row 0, color 3
        .byte   %11111111 ; row 1, color 2
        .byte   %00000000 ; row 1, color 3
        .byte   %11111111 ; row 2, color 2
        .byte   %00000000 ; row 2, color 3
        .byte   %11111111 ; row 3, color 2
        .byte   %00000000 ; row 3, color 3
        .byte   %11111111 ; row 4, color 2
        .byte   %00000000 ; row 4, color 3
        .byte   %11111111 ; row 5, color 2
        .byte   %00000000 ; row 5, color 3
        .byte   %11111111 ; row 6, color 2
        .byte   %00000000 ; row 6, color 3
        .byte   %11101111 ; row 7, color 2
        .byte   %00000000 ; row 7, color 3

    ; tile %11 - row 3 - black (0110) with some rando gray (0011)
        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00000000 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000000 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %01010100 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %11111111 ; row 0, color 2
        .byte   %00000000 ; row 0, color 3
        .byte   %11111111 ; row 1, color 2
        .byte   %00000000 ; row 1, color 3
        .byte   %11111111 ; row 2, color 2
        .byte   %00000000 ; row 2, color 3
        .byte   %11111111 ; row 3, color 2
        .byte   %00000000 ; row 3, color 3
        .byte   %11111111 ; row 4, color 2
        .byte   %00000000 ; row 4, color 3
        .byte   %11111111 ; row 5, color 2
        .byte   %00000000 ; row 5, color 3
        .byte   %11111111 ; row 6, color 2
        .byte   %00000000 ; row 6, color 3
        .byte   %10101011 ; row 7, color 2
        .byte   %00000000 ; row 7, color 3

    ; tile %100 - row 4 - mix of black (0110) gray (0011)
        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %10100000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00000000 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %10100000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000000 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %01100001 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %10010100 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %10101000 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %11111111 ; row 0, color 2
        .byte   %00000000 ; row 0, color 3
        .byte   %01011111 ; row 1, color 2
        .byte   %00000000 ; row 1, color 3
        .byte   %11111111 ; row 2, color 2
        .byte   %00000000 ; row 2, color 3
        .byte   %01011111 ; row 3, color 2
        .byte   %00000000 ; row 3, color 3
        .byte   %11111111 ; row 4, color 2
        .byte   %00000000 ; row 4, color 3
        .byte   %10011110 ; row 5, color 2
        .byte   %00000000 ; row 5, color 3
        .byte   %01101011 ; row 6, color 2
        .byte   %00000000 ; row 6, color 3
        .byte   %01010111 ; row 7, color 2
        .byte   %00000000 ; row 7, color 3

    ; tile %101 - row 4 - mix of black (0110) gray (0011) #2
        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %00110000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00001010 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %10100000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000101 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %00000100 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %00101011 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %11010101 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %11111111 ; row 0, color 2
        .byte   %00000000 ; row 0, color 3
        .byte   %11001111 ; row 1, color 2
        .byte   %00000000 ; row 1, color 3
        .byte   %11110101 ; row 2, color 2
        .byte   %00000000 ; row 2, color 3
        .byte   %01011111 ; row 3, color 2
        .byte   %00000000 ; row 3, color 3
        .byte   %11111010 ; row 4, color 2
        .byte   %00000000 ; row 4, color 3
        .byte   %11111011 ; row 5, color 2
        .byte   %00000000 ; row 5, color 3
        .byte   %11010100 ; row 6, color 2
        .byte   %00000000 ; row 6, color 3
        .byte   %00101010 ; row 7, color 2
        .byte   %00000000 ; row 7, color 3


	; tile 0x0a
        .byte   %00000000 ; row 0, color 0
        .byte   %00000000 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %00111100 ; row 1, color 1
        .byte   %00101000 ; row 2, color 0
        .byte   %01111110 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00010000 ; row 4, color 0
        .byte   %01101110 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %00111100 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %00100100 ; row 6, color 1
        .byte   %00000000 ; row 7, color 0
        .byte   %01101100 ; row 7, color 1

        .byte   %00000000 ; row 0, color 0
        .byte   %00000000 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %00111100 ; row 1, color 1
        .byte   %00101000 ; row 2, color 0
        .byte   %01111110 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00010000 ; row 4, color 0
        .byte   %01101110 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %00111100 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %00100100 ; row 6, color 1
        .byte   %00000000 ; row 7, color 0
        .byte   %01101100 ; row 7, color 1

    ; tile 0x0b
        .byte   %00000000 ; row 0, color 0
        .byte   %00000000 ; row 0, color 1
        .byte   %00111100 ; row 1, color 0
        .byte   %00000000 ; row 1, color 1
        .byte   %01111110 ; row 2, color 0
        .byte   %00101000 ; row 2, color 1
        .byte   %11111111 ; row 3, color 0
        .byte   %00000000 ; row 3, color 1
        .byte   %01101110 ; row 4, color 0
        .byte   %00010000 ; row 4, color 1
        .byte   %00111100 ; row 5, color 0
        .byte   %00000000 ; row 5, color 1
        .byte   %00100100 ; row 6, color 0
        .byte   %00000000 ; row 6, color 1
        .byte   %01101100 ; row 7, color 0
        .byte   %00000000 ; row 7, color 1

        .byte   %00000000 ; row 0, color 0
        .byte   %00000000 ; row 0, color 1
        .byte   %00111100 ; row 1, color 0
        .byte   %00000000 ; row 1, color 1
        .byte   %01111110 ; row 2, color 0
        .byte   %00101000 ; row 2, color 1
        .byte   %11111111 ; row 3, color 0
        .byte   %00000000 ; row 3, color 1
        .byte   %01101110 ; row 4, color 0
        .byte   %00010000 ; row 4, color 1
        .byte   %00111100 ; row 5, color 0
        .byte   %00000000 ; row 5, color 1
        .byte   %00100100 ; row 6, color 0
        .byte   %00000000 ; row 6, color 1
        .byte   %01101100 ; row 7, color 0
        .byte   %00000000 ; row 7, color 1

    ; tile 0x0c
        .byte   %00000000 ; row 0, color 0
        .byte   %00000000 ; row 0, color 1
        .byte   %00111100 ; row 1, color 0
        .byte   %00111100 ; row 1, color 1
        .byte   %01111110 ; row 2, color 0
        .byte   %01010110 ; row 2, color 1
        .byte   %11111111 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %01111110 ; row 4, color 0
        .byte   %01101110 ; row 4, color 1
        .byte   %00111100 ; row 5, color 0
        .byte   %00111100 ; row 5, color 1
        .byte   %00100100 ; row 6, color 0
        .byte   %00100100 ; row 6, color 1
        .byte   %01101100 ; row 7, color 0
        .byte   %01101100 ; row 7, color 1

        .byte   %00000000 ; row 0, color 0
        .byte   %00000000 ; row 0, color 1
        .byte   %00111100 ; row 1, color 0
        .byte   %00111100 ; row 1, color 1
        .byte   %01111110 ; row 2, color 0
        .byte   %01010110 ; row 2, color 1
        .byte   %11111111 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %01111110 ; row 4, color 0
        .byte   %01101110 ; row 4, color 1
        .byte   %00111100 ; row 5, color 0
        .byte   %00111100 ; row 5, color 1
        .byte   %00100100 ; row 6, color 0
        .byte   %00100100 ; row 6, color 1
        .byte   %01101100 ; row 7, color 0
        .byte   %01101100 ; row 7, color 1

        ; Fill remaining tiles with orange and black
        .repeat 4 ; 32*64-9
        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00000000 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000000 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %00000000 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %00000000 ; row 0, color 2
        .byte   %11111111 ; row 0, color 3
        .byte   %00000000 ; row 1, color 2
        .byte   %11111111 ; row 1, color 3
        .byte   %00000000 ; row 2, color 2
        .byte   %11111111 ; row 2, color 3
        .byte   %00000000 ; row 3, color 2
        .byte   %11111111 ; row 3, color 3
        .byte   %00000000 ; row 4, color 2
        .byte   %11111111 ; row 4, color 3
        .byte   %00000000 ; row 5, color 2
        .byte   %11111111 ; row 5, color 3
        .byte   %00000000 ; row 6, color 2
        .byte   %11111111 ; row 6, color 3
        .byte   %00000000 ; row 7, color 2
        .byte   %11111111 ; row 7, color 3

        .byte   %00000000 ; row 0, color 0
        .byte   %11111111 ; row 0, color 1
        .byte   %00000000 ; row 1, color 0
        .byte   %11111111 ; row 1, color 1
        .byte   %00000000 ; row 2, color 0
        .byte   %11111111 ; row 2, color 1
        .byte   %00000000 ; row 3, color 0
        .byte   %11111111 ; row 3, color 1
        .byte   %00000000 ; row 4, color 0
        .byte   %11111111 ; row 4, color 1
        .byte   %00000000 ; row 5, color 0
        .byte   %11111111 ; row 5, color 1
        .byte   %00000000 ; row 6, color 0
        .byte   %11111111 ; row 6, color 1
        .byte   %00000000 ; row 7, color 0
        .byte   %11111111 ; row 7, color 1

        .byte   %11111111 ; row 0, color 2
        .byte   %00000000 ; row 0, color 3
        .byte   %11111111 ; row 1, color 2
        .byte   %00000000 ; row 1, color 3
        .byte   %11111111 ; row 2, color 2
        .byte   %00000000 ; row 2, color 3
        .byte   %11111111 ; row 3, color 2
        .byte   %00000000 ; row 3, color 3
        .byte   %11111111 ; row 4, color 2
        .byte   %00000000 ; row 4, color 3
        .byte   %11111111 ; row 5, color 2
        .byte   %00000000 ; row 5, color 3
        .byte   %11111111 ; row 6, color 2
        .byte   %00000000 ; row 6, color 3
        .byte   %11111111 ; row 7, color 2
        .byte   %00000000 ; row 7, color 3
        .endrepeat



charset_end:


bgset:
;
; vhopppcc cccccccc
; v/h        = Vertical/Horizontal flip this tile.
; o          = Tile priority.
; ppp        = Tile palette. The number of entries in the palette depends on the Mode and the BG.
; cccccccccc = Tile number.
        ; Not displayed for some reason
        .repeat 3952 ; 4096-144
                .byte   %00000001 ; row 0, color 0 ; cccccccc
                .byte   %00000001 ; row 0, color 1 ; vhopppcc
        .endrepeat
        ; row 1-2
        .repeat 32*2
                .byte   %00000000 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
        .endrepeat
        ; row 3
                .byte   %00000001 ; row 0, color 0 ; cccccccc
                .byte   %01000000 ; row 0, color 0 ; vhopppcc
                .repeat 4
                .byte   %00000000 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .endrepeat 
                .byte   %00000010 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .repeat 7
                .byte   %00000000 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .endrepeat
                .byte   %00000011 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .repeat 10
                .byte   %00000000 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .endrepeat
                .byte   %00000010 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .repeat 7
                .byte   %00000000 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .endrepeat
        ;row 4
        .repeat 4
                .byte   %00000100 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .byte   %00000101 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
        .endrepeat
        .repeat 8
                .byte   %00000100 ; row 0, color 0 ; cccccccc
                .byte   %01000000 ; row 0, color 1 ; vhopppcc
                .byte   %00000101 ; row 0, color 0 ; cccccccc
                .byte   %01000000 ; row 0, color 1 ; vhopppcc
        .endrepeat
        .repeat 4
                .byte   %00000100 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
                .byte   %00000101 ; row 0, color 0 ; cccccccc
                .byte   %00000000 ; row 0, color 1 ; vhopppcc
        .endrepeat
        ;5-32
        .repeat 32*24
                .byte   %00000001 ; row 0, color 0 ; cccccccc
                .byte   %00000001 ; row 0, color 0 ; vhopppcc
        .endrepeat
bgset_end: