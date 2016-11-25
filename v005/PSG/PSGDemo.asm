PSGDemo:
    ;We load a note
    moveq       #0, d0
    move.b      #77,d0
    jsr         PSG_Convert_Byte_to_Freq
    jsr         PSG_Output
    rts
PSG_Convert_Byte_to_Freq:
    jsr         Detect_PAL
    btst       #0, d7
    bne         @PAL_Detected
    ;d0 contains our byte data
    lea         PSG_Frequency_Table_NTSC, a2
@Continue:
    add.w       d0, d0
    adda.l      d0, a2
    moveq       #0, d1
    move.w      (a2), d1

    ;d1 contains our PSG frequency
    rts

@PAL_Detected:
    lea         PSG_Frequency_Table_PAL, a2
    bra.b       @Continue


PSG_Output:

    ;xxxxzz9876543210
    rol.l       #4, d1
    ;zz9876543210xxxx
    add.b      #0x08, d1
    ;zz98765432101xxx
    rol.b       #4, d1
    ;zz9876541xxx3210

    ;That mixed our latch bit with the frequency data, reorganizing it for the PSG
    move.l      #PSGPort, a0
    move.b      d1, (a0)
    ror.w       #8, d1
    move.b      d1,(a0)
    move.b      #0x90,(a0)

    rts