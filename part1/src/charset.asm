black_bg:
        .repeat 32*16
            .repeat 2
                .byte   %00000000 ; row 0, color 0
                .byte   %00000000 ; row 0, color 1
                .byte   %00000000 ; row 1, color 0
                .byte   %00000000 ; row 1, color 1
                .byte   %00000000 ; row 2, color 0
                .byte   %00000000 ; row 2, color 1
                .byte   %00000000 ; row 3, color 0
                .byte   %00000000 ; row 3, color 1
                .byte   %00000000 ; row 4, color 0
                .byte   %00000000 ; row 4, color 1
                .byte   %00000000 ; row 5, color 0
                .byte   %00000000 ; row 5, color 1
                .byte   %00000000 ; row 6, color 0
                .byte   %00000000 ; row 6, color 1
                .byte   %00000000 ; row 7, color 0
                .byte   %00000000 ; row 7, color 1

                .byte   %00000000 ; row 0, color 2
                .byte   %00000000 ; row 0, color 3
                .byte   %00000000 ; row 1, color 2
                .byte   %00000000 ; row 1, color 3
                .byte   %00000000 ; row 2, color 2
                .byte   %00000000 ; row 2, color 3
                .byte   %00000000 ; row 3, color 2
                .byte   %00000000 ; row 3, color 3
                .byte   %00000000 ; row 4, color 2
                .byte   %00000000 ; row 4, color 3
                .byte   %00000000 ; row 5, color 2
                .byte   %00000000 ; row 5, color 3
                .byte   %00000000 ; row 6, color 2
                .byte   %00000000 ; row 6, color 3
                .byte   %00000000 ; row 7, color 2
                .byte   %00000000 ; row 7, color 3
            .endrepeat
        .endrepeat
black_bg_end:

charset:

	; tile 0x00
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111

        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000
        .byte   %11111111
        .byte   %00000000

	; tile 0x01
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

    ; tile 0x02
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

    ; tile 0x02
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

charset_end:
