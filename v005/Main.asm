	include 'Init.asm'          			        ;Rom header and console init code
	include 'Globals.asm'                 			;Global Variables

	include 'Graphics/Tiles/SysFont.asm'      	    ;Palette and Tile data for the System Font
    include 'Graphics/MenuBar.asm'					;Contains Menubar panels

    include 'VDP/VDPWrite.asm'   			;Routines for loading the system font into VRAM
    include 'VDP/Generic.asm'	            ;Generic Routines for VDP, like the WipePlane routines.

    include 'YM2612/YGlobals.asm'           ;Memory map for the YM2612
    include 'YM2612/YDemo.asm'              ;Demo and template for YM2612 Prelisten and Playback routines
    include 'YM2612/YM_NTSC.asm'            ;Frequency Lookup table for YM2612 on NTSC machines
    include 'YM2612/YM_PAL.asm'             ;Frequency Lookup table for YM2612 on PAL machines
    include 'Tools/Gpiano.asm'

    include 'PSG/PSG_NTSC.asm'              ;Frequency Lookup table for PSG on NTSC machines
    include 'PSG/PSG_PAL.asm'               ;Frequency Lookup table for PSG on PAL machines
    include 'PSG/PSGDemo.asm'               ;Demo and template for PSG Prelisten and Playback routines

	include 'ExceInfo.asm'					;Exception Handling screen
	include 'SysRout.asm'					;Important system routines like VSync
	include 'InputPol.asm'					;Input device Polling (Gamepad/Mouse/etc)
	include 'TrackIni.asm'				    ;Init tracker settings, arrays, etc.
	include 'UI.asm'						;Handles the UI
	include 'Menubar.asm'					;Specifications for all Menubar panels
	include 'LabelLut.asm'					;Further Specs for Menubar labels, used for cusor highlighting of menu options.


;===========================================
; Chaos Tracker v005
; Genesis/Megadrive/32x/CD
;
; By Count SymphoniC 'Cory C. Culley'
; Official Project start date is 9/20/2014
; Well... so that date is for YMDj/Prodigy Tracker.
; As of 8/17/2015, YMDj/Prodigy Tracker is discontinued.
;
; But as of 8/6/2015, Chaos Tracker development is underway.
;
;===========================================
;Languages used or to be used - Motorola 68000 Assembly, z80, SH2 RISC.

;CHANGELOG and ChaosToDo contains changes and TODO list from now on, it ought to be a sensible place to put such things.
;This will be a more plugin type of tracker. This will allow for different UI's/sound drivers/ etc so
;making code modular and compact is very important.

;At this stage of development, it's difficult to determine if one rom could work on all target Sega hardware. Separate editions
;of the tracker might be necessary for multi-system support to work.

;=============
;	STARTUP
;=============
startup:
    jsr	    Initialize_Tracker			;Initialize all tracker data and settings
    jsr     YM2612_Fetch_Note           ;Fetch a note of that generated scale, convert it to YM data, buffer it for playback
    jsr     YM2612_Output_Ch1           ;For now, we only play one note
    ;jsr     PSGDemo


;=============
; MAIN START
;=============
MAIN:

	;jsr		Poll_Input_3_Button_Pad_1		;Gamepad polling, checks the state of the pads and returns a word that goes into 68k RAM.
	;jsr		Poll_Input_3_Button_Pad_2
	;jsr		Handle_Input_3_Button_Pad_1		;This handles collected button input
	;;jsr	Handle_Input_3_Button_Pad_2
	;jsr		User_Interface					;This literally handles all Screen drawing to buffer.
											;This buffer is loaded into VRAM only during VBlank however.
	;jsr		Interrupt


;=============
; StartVBLANK
;=============
	;jsr		Start_VBlank
	;jsr		Buffer_To_Plane_A				;Writes Screen Buffer A to VDP Plane A
	;;jsr		Buffer_To_Plane_B				;Writes Screen Buffer B to VDP Plane B
;=============
; EndVBLANK
;=============
	;jsr		End_VBlank

;=============
; MAIN END
;=============
	bra.l 	MAIN

