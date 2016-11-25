;================================
;			VDP VSYNC
;================================

Start_VBlank:
	move.l	VDPControlPort, d0
	andi.w	#0x0008, d0
	bne		Start_VBlank
	rts

End_VBlank:
	move.l	VDPControlPort, d0
	andi.w	#0x0008, d0
	beq		End_VBlank
	rts


;================================
;	Z80 BUS REQ & LOAD ROM
;================================	
Z80_Bus_REQ:
.Z80BUSRQ:
	move.w	#0x100, (0x00A11100)	; Write 0x0100 into Z80 BUSREQ
	move.w	#0x100, (0x00A11200)	; Write 0x0100 into Z80 RESET to reset the Z80	
	btst	#0x0, (0x00A11100)	; Check value of the bit 0 at Z80 BUSREQ
	bne		.Z80BUSRQ			; Repeat this process until the z80 is ready.
	rts
Z80_Bus_REQ_End:
	move.w	#0x0, (0x00A11200)	; Write 0x0000 into Z80 RESET, clear the reset
	move.w	#0x0, (0x00A11100)	; Write 0x0000 to Z80 BUSREQ, return bus access	
	move.w	#0x100, (0x00A11200)	; Write 0x0100 into Z80 RESET, resetting it.
	rts



;Load_XGM_Driver:
;	jsr		Z80BUSREQ				;Here's where we load the sound driver into z80 program RAM
;	lea		Z80LoadDriver, a0
;	move.l	#0xA00000, a1
;	move.l	#Z80EndLoadDriver, d6
	
;.LoadZ80Driv:
;	move.b	(a0)+, (a1)+
;	cmp.l	a0, d6
;	bne.b		.LoadZ80Driv
;
;	jsr		Z80BUSREQEND
;	move.b	#0x2, Sync68kZ80		;Intializes the busy flag for the driver. 0 = Ready, 1 = Busy, 2 = Driver Stopped
;	rts								;0 and 1 tells the 68k if it's okay or not to buffer music data to z80 RAM. 2 is used
									;to let the 68k know if it's appropriate to begin intializing song data.

;================================
;		  GAMEPAD READING
;================================
Poll_Input_3_Button_Pad_1:					;All of these routines read from both Pad ports to collect input data
	move.b	PadDataPortA, d0		;The result is stored in RAM for input handling.
	rol.w	#0x8, d0	
	move.b	#0x40, PadDataPortA
	move.b	PadDataPortA, d0
	move.b	#0x0, PadDataPortA
	move.w	d0, Pad1Result
	rts

Poll_Input_3_Button_Pad_2:
	move.b	PadDataPortB, d0
	rol.w	#0x8, d0	
	move.b	#0x40, PadDataPortB
	move.b	PadDataPortB, d0
	move.b	#0x0, PadDataPortB
	move.w	d0, Pad2Result	
	rts
