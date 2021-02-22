*
* DOMENU
*
basl    equ $28
cout    equ $FDED
home    equ $FC58
bascalc equ $FBC1
ptr1    equ $06
prt2    equ $08
ALTCHARSET0FF equ $C00E 
ALTCHARSET0N equ $C00F

        org $4000
        jsr home
        lda #$01        ; menu# to hilight
        sta curm
        jsr dispmenu    ; display menu
        rts             ; bye

dispmenu nop
        ldx #$00
loop    lda mtab,x      ; read menu id
        beq fin         ; if = 0 then end
        pha             ; save meun #
        inx             ; read string memory location
        lda mtab,x      ; in ptr1
        sta ptr1
        inx
        lda mtab,x
        sta ptr1+1
        pla             ; get menu #
        cmp curm        ; = menu # to hilight ?
        bne prn         ; no : set flog to 0
        lda #$01        ; yes : set flog to 1
        sta invflag
        jmp prn2
prn     lda #$00
        sta invflag
prn2    jsr print
        inx
        jmp loop
        sta ALTCHARSET0FF
fin     rts

print   nop
        sta ALTCHARSET0N        ; to get lowercase inverse
* charsets explained here : 
* https://retrocomputing.stackexchange.com/questions/8652/
        ldy #$00
lprint  lda (ptr1),y    ; read menu string
        beq printend    ; ended by 0
        pha             ; save char. to display
        lda invflag     ; normal or inverse ?
        beq normal      ; normal char.
        pla
        and #$7F        ; inverse char.
        jmp out
normal  pla
out     jsr cout
        iny
        jmp lprint
printend nop 
        lda #$8D        ; next line
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
        hex 00          ; flog for end of array

curm    hex 00
invflag hex 00

m1      asc "item 1"
        hex 00
m2      asc "item 2"
        hex 00
m3      asc "item 3"
        hex 00
m4      asc "item 4"
        hex 00 
*   
