;===================
;Init Pattern Banks
;===================



Initialize_Tracker:

	jsr		Load_System_Palette_1 	;Load Colors and Font tiles.
	jsr		Load_System_Font_A


	jsr		Wipe_Plane_A	  					;Completely clears the VRAM of Planes A and B - "VDPFunctions/VDPGenericRoutines.asm"
	jsr		Wipe_Plane_B
	jsr		Initialize_Default_User_Settings 	;This initializes all user modifiable tracker settings in memory, to default.
	jsr		Initialize_User_Interface			;Initialize the UI
	jsr		Calculate_Pattern_Bank_Pointers  	;We need to calculate the starting addresses for all elements of the Pattern data block
												;as well as calculate the end address for the whole block.
	jsr		Wipe_Screen_Buffer_A				;Clears the Screen Buffers(As a just in case. Be warned that these functions
	jsr		Wipe_Screen_Buffer_B				;are used every single frame so they're important.)
												;Found in: UserInterface.asm

	jsr		Initialize_Pattern_Banks			;Initialize all song data arrays.
	jsr     Initialize_FM_Presets               ;Instrument presets need initializing too.
    ;jsr     Initialize_PSG_Presets
    jsr     Initialize_Test_Row             ;Special purpose tracker row for feature implementation
    rts

Initialize_Test_Row:
    move.l  #Playback_Test_Row, a0
    move.b  #$67, (a0)+
    move.b  #$01, (a0)+
    move.b  #$FF, (a0)+
    move.b  #$01, (a0)+
    move.b  #$33, (a0)+
    rts

Initialize_Pattern_Banks:
	jsr		Initialize_FM_Bank_Arrays			;In Chaos Tracker, FM patterns and PSG patterns are treated separately.
	jsr		Initialize_PSG_Bank_Arrays			;We refer to this separation as "Banks". By default the FM bank contains
	rts											;an array of 9Fh patterns and the PSG bank an array of 7Fh patterns, both numbers
												;counting from 0.
												;Each pattern contains 1Fh rows of 5 bytes (5 not accounting for the 0).
												;One byte for note, one byte for instrument patc, one byte for volume
												;and two bytes for command.

Initialize_FM_Bank_Arrays:
	jsr		Initialize_FM_Pattern_Index			;Both banks also make use of a Pattern Index, with each entry specifying which pattern
	jsr		Initialize_FM_Pattern_Array			;to use. This information is visible and editable in the Pattern Editor.
	rts

Initialize_PSG_Bank_Arrays:
	jsr		Initialize_PSG_Pattern_Index
	jsr		Initialize_PSG_Pattern_Array
	rts

Initialize_FM_Presets:
    moveq   #0, d0
    moveq   #0, d1
    move.l  #FM_Preset_Buffer, a0               ;This is the starting point for our preset buffer
    move.w  #128, d0
@Continue:
    move.w  #37, d1
    move.l  #GPiano, a6     ;For now we load the Grand Piano preset and loop it
@Start_Main_Loop:
    move.b  (a6)+, (a0)+
    dbra    d1, @Start_Main_Loop
@Next_Iteration:
    sub.b   #1, d0
    cmp.b   #0, d0
    bgt.b   @Continue

    rts
Initialize_PSG_Presets:

    rts
;========================
; End of Routine Tree Map
;========================

;========================
; Tracker Settings - User
;========================
Initialize_Default_User_Settings:
	move.b		#$9F, MaxPatternCountFMBank		;Initializes defaults for Pattern Counts. The max available number of unique patterns
	move.b		#$7F, MaxPatternCountPSGBank	;for each sound chip.
	move.b		#$1F, PatternRowCount			;Number of rows available in a pattern
	move.b		#$1, TrackerMode				;Sets default Tracker Mode to Professional Mode, or Menubar Mode
	rts
;==========================
; Tracker Settings - System
;==========================
Initialize_User_Interface:
	move.b		#$1, TrackerMode				;Tracker defaults to Chaos UI | Change the byte to #0h for YMDj mode default
	move.b		#$0, ActiveLayout				;Active Layout is Layout A by default
	move.b		#$0, MenuBarSelection			;Intialize the Menubar to "not activated"
	move.b		#$0, MenuBarOptionSelection
	rts
Calculate_Pattern_Bank_Pointers:
;DO NOT MODIFY UNLESS NEEDED - This code is CRITICAL in ensuring that the entire music data block is portable in memory AND to allow
;user modification to the maximum number of FM and PSG Banks and by extension the size of their arrays. The values calculated here
;determine where the size & location of  the pattern arrays. Since the user should be allowed to modify the number of rows they have
;available to them in a given pattern, this is also critical code for allowing such a possibility. This is flexible code that
;gives the user much power over the tracker in favor of convenience and personal preference.

;==Register Usage==
;	d0 - Will contain the start address for the entire data block
;	d1 - Used for work
;==================

	move.l		#PatternBanksStart, d0			;This address is the starting point for all calculations
	add.l		#$E6, d0						;Offset to start of the FM Pattern Array
	move.l		d0, FMBankArrayStart			;Store it
	moveq		#0, d1							;Here we clean up d1, and multiply the max pattern count by rows and 5 byte row data
	move.b		MaxPatternCountFMBank,	d1		;then add to the starting FM bank address to get starting PSG bank address.
	add.b		#$1, d1							;We're adding 1 here because multiplication doesn't account for the 0 like dbra does
	moveq		#$0, d2							;and because visually on screen, we always account for the 0 when using hexadecimal
	move.b		PatternRowCount, d2
	add.b		#$1, d2							;Again we account for the zero by adding 1.
	move.l		#$5, d3
	mulu.w		d2, d1
	mulu.w		d3, d1
	add.l		d1, d0
	move.l		d0, PSGBankArrayStart			;We store it.
	moveq		#$0, d1
	move.b		MaxPatternCountPSGBank, d1		;Finally we do roughly the same thing with the PSG bank, this way we have the end address
	add.b		#$1, d1							;which is actually the starting address of the next free byte. We may never need this
	mulu.w		d2, d1							;address stored but it's nice to have just in case.
	mulu.w		d3, d1
	add.l		d1, d0
	move.l		d0, PatternBanksEnd				;All addresses have been calculated, we store the end of the Pattern Data Block and move
												;on to a new task.
	rts


;=====================
; Index Initialization
;=====================
Initialize_FM_Pattern_Index:
	move.l		#$89, d0						;Initialize number of entries (bytes) for the pattern index
	move.l		#$FF, d1						;FFh is the default value for many entries and means "blank"
	move.l		#PatternBanksStart, a0			;Point a0 to the starting point for the FM index
@Init_Index_Loop:
	move.b		d1, (a0)+
	dbra		d0, @Init_Index_Loop
	rts

Initialize_PSG_Pattern_Index:
	move.l		#$5B, d0						;Initialize number of entries (bytes) for the pattern index
	move.l		#$FF, d1						;FF, is the default value for many entres and means "blank"
	move.l		#PatternBanksStart, a0			;Point a0 to the starting point for the FM index
	adda.l		#$8A, a0                        ;Offset from start of Pattern Bank block
@Init_Index_Loop:
	move.b		d1, (a0)+
	dbra		d0, @Init_Index_Loop
	rts

;==================================
; Pattern Bank Array Initialization
;==================================
Initialize_FM_Pattern_Array:
	moveq		#0, d0							;Clean up
	moveq		#0, d1
	move.b		MaxPatternCountFMBank, d0		;Number of entries/patterns | dbra accounts for the 0
	move.b		PatternRowCount, d1				;Number of rows  | dbra accounts for the 0
	move.l		#$FF, d2						;Blank Note
	move.l		#$00, d3						;Default Instrument Patch
	move.l		#$FF, d4						;Blank Volume
	move.l		#$00, d5						;Blank Command
	move.l		#$00, d6						;Blank Command Value
	move.l		FMBankArrayStart, a0			;Start of Pattern data

@Init_Array:
	move.b		d2, (a0)+
	move.b		d3, (a0)+
	move.b		d4,	(a0)+
	move.b		d5, (a0)+
	move.b		d6, (a0)+
	dbra		d1, @Init_Array
	move.l		#$1F, d1						;Reset Row counter
	dbra		d0, @Init_Array					;Have we entered in 159 entries containing 20h rows of 5 bytes worth of music data?
	rts

Initialize_PSG_Pattern_Array:
	moveq		#0, d0							;Clean up
	moveq		#0, d1
	move.b		MaxPatternCountPSGBank, d0		;Number of entries/patterns | dbra accounts for the 0
	move.b		PatternRowCount, d1				;Number of rows | dbra accounts for the 0
	move.l		#$FF, d2						;Blank Note
	move.l		#$00, d3						;Default Instrument Patch
	move.l		#$FF, d4						;Default Volume
	move.l		#$00, d5						;Blank Command
	move.l		#$00, d6						;Blank Command Value
	move.l		PSGBankArrayStart, a0			;Start of Pattern data

@Init_Array:
	move.b		d2, (a0)+
	move.b		d3, (a0)+
	move.b		d4,	(a0)+
	move.b		d5, (a0)+
	move.b		d6, (a0)+
	dbra		d1, @Init_Array
	move.l		#$1F, d1						;Reset Row counter
	dbra		d0, @Init_Array					;Have we entered in 127 entries containing 32 rows of 5 bytes worth of music data?
	rts
