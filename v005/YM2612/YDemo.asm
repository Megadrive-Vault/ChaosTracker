;This is a template and the basic foundation for YM2612 Prelisten and Playback. The channel used here is FM Channel 1.
;The basis for this whole thing is the piano sample parameters described in the Sega YM2612 documentation.

;So we do a bus req, read note data and use that to playback
YM2612_Wait MACRO
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            ENDM


YM2612_Workaround MACRO
    ;DT MUL
    move.b  #YM2612_Ch1_Ch4_Op1_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    ;TL
    move.b  #YM2612_Ch1_Ch4_Op1_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    ;RS AR
    move.b  #YM2612_Ch1_Ch4_Op1_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    ;D1R AM
    move.b  #YM2612_Ch1_Ch4_Op1_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    ;D2R
    move.b  #YM2612_Ch1_Ch4_Op1_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait


    ;D1L RR
    move.b  #YM2612_Ch1_Ch4_Op1_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait
    ENDM


Z80_Bus_REQ_M MACRO
@Z80BUSRQ:
            move.w	#$100, (0x00A11100)	; Write 0x0100 into Z80 BUSREQ
            move.w	#$100, (0x00A11200)	; Write 0x0100 into Z80 RESET to reset the Z80
            btst	#$0, (0x00A11100)	; Check value of the bit 0 at Z80 BUSREQ
            bne		@Z80BUSRQ			; Repeat this process until the z80 is ready.
            ENDM

Z80_Bus_REQ_End_M MACRO
            move.w	#$100, (0x00A11200)	; Write 0x0100 into Z80 RESET, clear the reset
            move.w	#$0, (0x00A11100)	; Write 0x0000 to Z80 BUSREQ, return bus access
            ;move.w	#0x100, (0x00A11200)	; Write 0x0100 into Z80 RESET, resetting it.
            ENDM



YM2612_Fetch_Note:
    ;Ok so this function will be gone in the real deal. But it's intent is to experiment with a note buffer.
    ;So we need to keep a counter for the demo sequence. We read the note and convert it into octave block/freqency data, then
    ;store that into the buffer. It's simple.

    moveq       #$0, d0
    move.l      #Playback_Test_Row, a0
    move.b      (a0), d0
    jsr         YM2612_Convert_Byte_To_Freq
    move.l      #FM_Ch1_Note_Buffer, a1
    move.w      d2, (a1)
    rts

YM2612_Convert_Byte_To_Freq:
    ;Converts byte to YM2612 note data and leaves the result in d2 as a word.
    ;We have a byte that represents our note and octave.
    ;We need to convert this byte into frequency and octave block data for the YM2612.
    ;All we do is use our lookup tables here
    ;d0 should contain the byte note value (#0x00 - #0x7f,or 0-127)
    jsr         Detect_PAL
    btst       #0, d7
    bne         @PAL_Detected

    lea         YM2612_Frequency_Table_NTSC, a2
@Continue:

    ;adding this value to itself and then adding the sum to the starting address of our LUT
    ;gives the correct value for the YM2612.
    add.w       d0, d0
    adda.l      d0, a2
    move.w      (a2), d2
    ;we now load this data into the playback buffer
    ;after leaving the routine
    rts

@PAL_Detected:
    lea         YM2612_Frequency_Table_PAL, a2
    bra.b       @Continue
    rts

YM2612_Output_Ch1:

    ;We load the instrument number so we can load the preset
    ;we need to implement testing if the instrument number is a user or system preset and pointing
    ;to the correct address
    move.l       #Playback_Test_Row, a0
    adda.l       #1, a0 ;offset to the instrument # byte
    moveq        #0, d0
    move.b       (a0), d0  ; Ins # is stored here
    lea          FM_Preset_Buffer, a6
    ;we use the ins # in d0 to multiply by 38 to get us to our preset's starting address
    mulu.w       #38, d0
    adda.l       d0, a6

    Z80_Bus_REQ_M



    ;LFO/LFO2 Sens, FMS, AMS, Stereo
    move.b  #YM2612_Ch1_Ch4_Stereo_LFO_Sens, YM2612_Control_Port1
    YM2612_Wait

    move.b  (a6)+, d0
    or.b    #%11000000, d0     ;We add in our panning data here
    move.b  d0, YM2612_Data_Port1
    YM2612_Wait

    ;Feedback Algorithm
    move.b  #YM2612_Ch1_Ch4_Feedback_Algo, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    YM2612_Workaround ;Macro, the YM2612 seems to have a bug involving envelope settings not changing over
    ;Correctly when switching to a new instrument, this attempts to rectify that.

    ;Key OFF
    move.b  #YM2612_Key_On_Off, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$0, YM2612_Data_Port1
    YM2612_Wait

    ;DT MUL
    move.b  #YM2612_Ch1_Ch4_Op1_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    ;TL
    move.b  #YM2612_Ch1_Ch4_Op1_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    ;RS AR
    move.b  #YM2612_Ch1_Ch4_Op1_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    ;D1R AM
    move.b  #YM2612_Ch1_Ch4_Op1_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    ;D2R
    move.b  #YM2612_Ch1_Ch4_Op1_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait


    ;D1L RR
    move.b  #YM2612_Ch1_Ch4_Op1_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait


    ;SSG-EG
    move.b  #YM2612_Ch1_Ch4_Op1_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  (a6)+, YM2612_Data_Port1
    YM2612_Wait

    ;Key OFF
    move.b  #YM2612_Key_On_Off, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$0, YM2612_Data_Port1
    YM2612_Wait



    ;Frequency
    move.l  #FM_Ch1_Note_Buffer, a6
    move.w  (a6), d0

    ror.w   #8, d0
    move.b  #YM2612_Ch1_Ch4_Octave_FreqMSB, YM2612_Control_Port1
    YM2612_Wait
    move.b  d0, YM2612_Data_Port1
    YM2612_Wait

    ror.w   #8, d0
    move.b  #YM2612_Ch1_Ch4_FreqLSB, YM2612_Control_Port1
    YM2612_Wait
    move.b  d0, YM2612_Data_Port1
    YM2612_Wait


    ;Key On
    move.b  #YM2612_Key_On_Off, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F0, YM2612_Data_Port1
    YM2612_Wait

    Z80_Bus_REQ_End_M
    rts



Init_YM2612:

    ;LFO/LFO2 Sens, FMS, AMS, Stereo
    move.b  #YM2612_Ch1_Ch4_Stereo_LFO_Sens, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    ;Feedback Algorithm
    move.b  #YM2612_Ch1_Ch4_Feedback_Algo, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    ;Key OFF
    move.b  #YM2612_Key_On_Off, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$0, YM2612_Data_Port1
    YM2612_Wait

    ;DT MUL
    move.b  #YM2612_Ch1_Ch4_Op1_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Det_Mult, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    ;TL
    move.b  #YM2612_Ch1_Ch4_Op1_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_TotalLevel, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$7F, YM2612_Data_Port1
    YM2612_Wait

    ;RS AR
    move.b  #YM2612_Ch1_Ch4_Op1_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_RateScaling_AttackRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    ;D1R AM
    move.b  #YM2612_Ch1_Ch4_Op1_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Decay1_AmpMod, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    ;D2R
    move.b  #YM2612_Ch1_Ch4_Op1_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_Decay2, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$1F, YM2612_Data_Port1
    YM2612_Wait


    ;D1L RR
    move.b  #YM2612_Ch1_Ch4_Op1_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_DecayLevel_RelRate, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$F, YM2612_Data_Port1
    YM2612_Wait


    ;SSG-EG
    move.b  #YM2612_Ch1_Ch4_Op1_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op2_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op3_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    move.b  #YM2612_Ch1_Ch4_Op4_SSGEG, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait

    ;Key OFF
    move.b  #YM2612_Key_On_Off, YM2612_Control_Port1
    YM2612_Wait
    move.b  #$0, YM2612_Data_Port1
    YM2612_Wait



    ;Frequency
    move.b  #YM2612_Ch1_Ch4_Octave_FreqMSB, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait
    move.b  #YM2612_Ch1_Ch4_FreqLSB, YM2612_Control_Port1
    YM2612_Wait
    move.b  #0, YM2612_Data_Port1
    YM2612_Wait
    rts






