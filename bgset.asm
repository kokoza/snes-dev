bgset:
;
; vhopppcc cccccccc
; v/h        = Vertical/Horizontal flip this tile.
; o          = Tile priority.
; ppp        = Tile palette. The number of entries in the palette depends on the Mode and the BG.
; cccccccccc = Tile number.
        ; Not displayed for some reason - Not needed if using channel 0
        ;.repeat 3952 ; 4096-144
        ;        .byte   %00000001 ; cccccccc
        ;        .byte   %00000001 ; vhopppcc
        ;.endrepeat
        ; row 1-2
        .repeat 32*2
                .byte   %00000000 ; cccccccc
                .byte   %00000000 ; vhopppcc
        .endrepeat
        ; row 3
                .byte   %00000001 ; cccccccc
                .byte   %01000000 ; vhopppcc
                .repeat 4
                .byte   %00000000 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .endrepeat 
                .byte   %00000010 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .repeat 7
                .byte   %00000000 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .endrepeat
                .byte   %00000011 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .repeat 10
                .byte   %00000000 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .endrepeat
                .byte   %00000010 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .repeat 7
                .byte   %00000000 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .endrepeat
        ;row 4
        .repeat 8
                .byte   %00000100 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .byte   %00000101 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .byte   %00000100 ; cccccccc
                .byte   %01000000 ; vhopppcc
                .byte   %00000101 ; cccccccc
                .byte   %01000000 ; vhopppcc
        .endrepeat
        
        ; row 5
        .repeat 8
                .byte   %00000110 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .byte   %00000111 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .byte   %00000111 ; cccccccc
                .byte   %01000000 ; vhopppcc
                .byte   %00000110 ; cccccccc
                .byte   %01000000 ; vhopppcc
        .endrepeat
        
        ; row 6
        .repeat 8
                .byte   %00001000 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .byte   %00001000 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .byte   %00001000 ; cccccccc
                .byte   %01000000 ; vhopppcc
                .byte   %00001000 ; cccccccc
                .byte   %01000000 ; vhopppcc
        .endrepeat

        ; row 7
        .repeat 16
                .byte   %00001010 ; cccccccc
                .byte   %00000000 ; vhopppcc
                .byte   %00001010 ; cccccccc
                .byte   %00000000 ; vhopppcc
        .endrepeat

        ; rows 6-32
        .repeat 32*24
                .byte   %00000001 ; cccccccc
                .byte   %00000001 ; vhopppcc
        .endrepeat
bgset_end: