*
* DOMENU
*
basl    equ $28
cout    equ $FDED
home    equ $FC58
bascalc equ $FBC1
wait    equ $FCA8
timer   equ $01
ptr1    equ $06
prt2    equ $08

        org $4000
        jsr home
        lda #$02
        sta curm
        jsr dispmenu
        rts

dispmenu nop
        ldx #$00
loop    lda mtab,x
        beq fin
        pha             ; save meun#
        inx 
        lda mtab,x
        sta ptr1
        inx
        lda mtab,x
        sta ptr1+1
        pla             ; get menu#
        cmp curm
        bne prn
        lda #$01
        sta invflag
        jmp prn2
prn     lda #$00
        sta invflag
prn2    jsr print
        inx
        jmp loop
fin     rts

print   nop
        ldy #$00
lprint  lda (ptr1),y
        beq printend
        ldx invflag
        beq c
        and #$7F
c       jsr cout
        iny
        jmp lprint
printend nop
        lda #$8D
        jsr cout
        rts

mtab    hex 01
        da m1
        hex 02
        da m2
        hex 03
        da m3
        hex 04
        da m4
        hex 00

curm    hex 00
invflag hex 00

m1      asc "Item 1"
        hex 00
m2      asc "Item 2"
        hex 00
m3      asc "Item 3"
        hex 00
m4      asc "Item 4"
        hex 00    
