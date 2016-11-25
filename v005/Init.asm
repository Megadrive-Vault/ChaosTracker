; Sega Genesis ROM header

	DC.L	0x00FFE000	; Initial stack pointer value
	DC.L	ROMSTART	; Start of our program in ROM
	DC.L	Bus_Error	; Bus error
	DC.L	Address_Error	; Address error
	DC.L	Illegal_Opcode	; Illegal instruction
	DC.L	Division_By_Zero	; Division by zero
	DC.L	CHK_Exception	; CHK exception
	DC.L	TRAPV_Exception	; TRAPV exception
	DC.L	Privilege_Violation	; Privilege violation
	DC.L	TRACE_Exception	; TRACE exception
	DC.L	LineA_Emulator	; Line-A emulator
	DC.L	LineF_Emulator	; Line-F emulator
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Spurious exception
	DC.L	Interrupt	; IRQ level 1
	DC.L	Interrupt	; IRQ level 2
	DC.L	Interrupt	; IRQ level 3
	DC.L	HBlank_Interrupt	; IRQ level 4 (horizontal retrace interrupt)
	DC.L	Interrupt	; IRQ level 5
	DC.L	VBlank_Interrupt	; IRQ level 6 (vertical retrace interrupt)
	DC.L	Interrupt	; IRQ level 7
	DC.L	Interrupt	; TRAP #00 exception
	DC.L	Interrupt	; TRAP #01 exception
	DC.L	Interrupt	; TRAP #02 exception
	DC.L	Interrupt	; TRAP #03 exception
	DC.L	Interrupt	; TRAP #04 exception
	DC.L	Interrupt	; TRAP #05 exception
	DC.L	Interrupt	; TRAP #06 exception
	DC.L	Interrupt	; TRAP #07 exception
	DC.L	Interrupt	; TRAP #08 exception
	DC.L	Interrupt	; TRAP #09 exception
	DC.L	Interrupt	; TRAP #10 exception
	DC.L	Interrupt	; TRAP #11 exception
	DC.L	Interrupt	; TRAP #12 exception
	DC.L	Interrupt	; TRAP #13 exception
	DC.L	Interrupt	; TRAP #14 exception
	DC.L	Interrupt	; TRAP #15 exception
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)
	DC.L	Interrupt	; Unused (reserved)

	; Sega string and copyright
	DC.B "SEGA MEGA DRIVE (C)CHAO 2016.APR"
	; Domestic name
	DC.B "Chaos Tracker                                   "
	; Overseas name
	DC.B "Chaos Tracker                                   "
	; GM (game), product code and serial
	DC.B "GM 58395133-00"
	; Checksum will be here
	DC.B 0x81, 0xB4
	; Which devices are supported ?
	DC.B "JD              "
	; ROM start address
	DC.B 0x00, 0x00, 0x00, 0x00
	; ROM end address will be here
	DC.B 0x00, 0x02, 0x00, 0x00
	; Some magic values, I don't know what these mean
	DC.B 0x00, 0xFF, 0x00, 0x00
	DC.B 0x00, 0xFF, 0xFF, 0xFF
	; We don't have a modem, so we fill this with spaces
	DC.B "               "
	; Unused
	DC.B "                        "
	DC.B "                         "
	; Country
	DC.B "JUE             "


;-- Our code starts here (ROM offset: 0x00000200, see line 4)
ROMSTART:
	tst.l	0x00A10008	; Test on an undocumented (?) IO register ?
	bne	@1		; Branch to the next temp. label 1 if not zero
	tst.w	0x00A1000C	; Test port C control register

@1:	bne.b	SkipSetup	; Branch to SkipSetup if not equal

;;;; Initialize some registers values

	lea	Table, a5	; Load address of Table into A5			; A5 = (address of Table)
	movem.w (a5)+, d5-d7	; The content located at the address stored in	; D5 = 0x8000		A5 += 2
	                        ; A5 is moved into D5. Then A5 gets incremented ; D6 = 0x3FFF		A5 += 2
				; by two (because we've read a word which is two; D7 = 0x0100		A5 += 2
				; bytes long) and the content of the new loca-
				; tion is moved into D6, and again for D7
	movem.l (a5)+, a0-a4 ; The next four longwords (four bytes) are read	; A0 = 0x00A00000	A5 += 4
	                        ; into A0 - A4, incrementing A5 after each	; A1 = 0x00A11100	A5 += 4
				; operation by four				; A2 = 0x00A11200	A5 += 4
										; A3 = 0x00C00000	A5 += 4
										; A4 = 0x00C00004	A5 += 4
;;;; Check version number

; Version from the SEGA Technical Manual:

	move.b	0xA10001, d0	; Read MegaDrive hardware version		; D0 =(0x00A10001)
	andi.b	#0x0F, d0	; The version is stored in last four bytes	; D0 = 0x0000xxxx
	beq.b	@INITSTACK	; If they are all zero we've got one the very
				; first MegaDrives which didn't feature the
				; protection
	move.l	#0x53454741, 0xA14000	; Move the string "SEGA" at 0xA14000

@INITSTACK:
	clr.l	d0		; Move 0 into D0				; D0 = 0x00000000
	movea.l	d0, a6	; Move address from D0 into A6 (that is, clear	; A6 = 0x00000000
				; A6)
	move	a6, sp	; Setup Stack Pointer (A7)			; A7 = 0x00000000

@INITSTACK2:
	move.l	d0, -(a6)	; Decrement A6 by four and and write 0x00000000	; D0 -> (A6)		A6 -= 4
				; into (A6)
	dbra	d6, @INITSTACK2	; If D6 is not zero then decrement D6 and jump
				; back to 1 (clear user RAM: 0xFFE00000 onward)
										; D6 = 0x00000000
										; A6 = 0xFFE00000 ?

	jsr	InitZ80		; Initialize the Z80 / sound
	jsr	InitPSG		; Initialize the PSG
	jsr	InitVDP		; Initialize the VDP

	move.b	#0x40, d0	; Set last byte of D0 to 0x40
	move.b	d0, 0x000A10009; We have to write 0x40 into the control ...
	move.b	d0, 0x000A1000B; ... register of the joystick (data) ports ...
	move.b	d0, 0x000A1000D; ... or else we might have problems reading ...
				; ... the joypads on the real hardware


	movem.l	(a6), d0-d7/a0-a6	; Clear all registers except A7		; D0 = 0x00000000
				; The registers get cleared because we read from; D1 = 0x00000000
				; the area which we've set to all-zero in the	; D2 = 0x00000000
				; "Initialize memory" section			; D3 = 0x00000000
										; D4 = 0x00000000
										; D5 = 0x00000000
										; D6 = 0x00000000
										; D7 = 0x00000000
										; A0 = 0x00000000
										; A1 = 0x00000000
										; A2 = 0x00000000
										; A3 = 0x00000000
										; A4 = 0x00000000
										; A5 = 0x00000000
										; A6 = 0x00000000

	move	#0x2000, sr	; Set Status Register
				; Trace disabled, register A7 is the Stack Pointer
				; Interrupt levels 4,6,8 enabled. Condition codes cleared.


SkipSetup:
	jmp	startup		; Console initialization complete, we now begin tracker initialization



;==============================================================================
Table:
	DC.W	0x8000		; D5 (needed for initializing the VDP)
	DC.W	0x3FFF		; D6 (needed for initializing the RAM)
	DC.W	0x0100		; D7 (needed for initializing the VDP)
	DC.L	0x00A00000	; A0 (version port)
	DC.L	0x00A11100	; A1 (Z80 BUSREQ)
	DC.L	0x00A11200	; A2 (Z80 RESET)
	DC.L	0x00C00000	; A3 (VDP data port)
	DC.L	0x00C00004	; A4 (VDP control port)

	DC.W	0xaf01, 0xd91f	; The following stuff is for the Z80
	DC.W	0x1127, 0x0021
	DC.W	0x2600,	0xf977
	DC.W	0xedb0, 0xdde1
	DC.W	0xfde1, 0xed47
	DC.W	0xed4f, 0xd1e1
	DC.W	0xf108, 0xd9c1
	DC.W	0xd1e1, 0xf1f9
	DC.W	0xf3ed, 0x5636
	DC.W	0xe9e9, 0x8104
	DC.W	0x8f01

	DC.W	0x9fbf, 0xdfff	; PSG values: set channels 0, 1, 2 and 3
				; to silence.


;==============================================================================
; Interrupt routines
;==============================================================================
Interrupt:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x1, ExceptionCode
	move.l  #0x1, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1

	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

Bus_Error:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x2, ExceptionCode
	move.l  #0x0, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
    jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

Address_Error:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x3, ExceptionCode
	move.l  #0x0, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
    jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

Illegal_Opcode:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x4, ExceptionCode
    move.l  #0x1, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

Division_By_Zero:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x5, ExceptionCode
    move.l  #0x2, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

CHK_Exception:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x6, ExceptionCode
    move.l  #0x2, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

TRAPV_Exception:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x7, ExceptionCode
    move.l  #0x2, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

Privilege_Violation:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x8, ExceptionCode
    move.l  #0x2, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

TRACE_Exception:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0x9, ExceptionCode
    move.l  #0x3, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

LineA_Emulator:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0xA, ExceptionCode
    move.l  #0x3, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte

LineF_Emulator:
	move.l	d0, D068k
	move.l	d1, D168k
	move.l	d2, D268k
	move.l	d3, D368k
	move.l	d4, D468k
	move.l	d5, D568k
	move.l	d6, D668k
	move.l	d7, D768k
	move.l	A0, A068k
	move.l	A1, A168k
	move.l	A2, A268k
	move.l	A3, A368k
	move.l	A4, A468k
	move.l	A5, A568k
	move.l	A6, A668k
	move.l	A7, A768k
	move.l	#0xB, ExceptionCode
    move.l  #0x3, ExceptionGroup
	move.l  0x00FFFFFC, Stack_Frame_8
	move.l  0x00FFFFF8, Stack_Frame_7
	move.l  0x00FFFFF4, Stack_Frame_6
	move.l  0x00FFFFF0, Stack_Frame_5
	move.l  0x00FFFFEC, Stack_Frame_4
	move.l  0x00FFFFE8, Stack_Frame_3
	move.l  0x00FFFFE4, Stack_Frame_2
	move.l  0x00FFFFE0, Stack_Frame_1
	jsr		Exception_Screen
@Infinite_Loop:
	bra.b	@Infinite_Loop
	rte


HBlank_Interrupt:
	addi.l	#0x1, (Hsync)
	rte

VBlank_Interrupt:
	addi.l	#0x1, (Vsync)
	rte


;==============================================================================
; Initialize the Z80 / load sound program
;==============================================================================
InitZ80:
	jsr		Z80_Bus_REQ

	moveq	#0x25, d2	; Write 0x25 into D2				; D2 = 0x00000025

@Z80LOAD:
	move.b	(a5)+, (a0)+	; Move byte at (A5) into (A0) and increment both; A0 += 1		A5 += 1 * 38 ?
	dbra	d2, @Z80LOAD	; Decrement D2 and loop to 2: until D2 == -1.	; D2 -= 1
										; D2 = 0xFFFFFFFF
										; A0 = 0x00A00026

    jsr     Init_YM2612
	jsr		Z80_Bus_REQ_End
	rts


;==============================================================================
; Initialize the Programmable Sound Generator
; Sets all four channels to silence.
; See http://www.smspower.org/Development/SN76489 for PSG details.
;==============================================================================
InitPSG:
	moveq	#0x03, d1	; Move 0x03 into D1 to loop 4 times		; D5 = 0x00000003

@PSGOFF:
	move.b	(a5)+, 0x0011(a3)
				; Write content at (A5) into 0x00C00011,;			A5 += 1 * 4
				; which is the PSG (Programmable Sound Generator)
				; Writes 9F, BF, DF and FF which sets the the
				; channels 0, 1, 2 and 3 to silence.
	dbra	d1, @PSGOFF	; If D1 is not 0 then decrement D5 and jump	; D5 -= 1
				; back to 1

										; D5 = 0x00000000
	move.w	d0, (a2)	; Write 0x0000 into Z80 RESET ?
	rts			; Jump back to caller

;==============================================================================
; Initialize VDP registers
;==============================================================================
InitVDP:
	moveq	#18, d0	; 24 registers, but we set only 19
	lea	VDPRegs, a0	; start address of register values

@INITVDPREGS:
	move.b	(a0)+, d5	; load lower byte (register value)
	move.w	d5, (a4)	; write register
	add.w	d7, d5	; next register
	dbra	d0, @INITVDPREGS		; loop

	rts			; Jump back to caller

;==============================================================================
; Register values for the VDP
;==============================================================================
VDPRegs:
    DC.B	0x14	; Reg.  0: Enable Hint, HV counter active
	DC.B	0x64	; Reg.  1: Enable display, enable Vint, disable DMA, V28 mode (PAL & NTSC)
	DC.B	0x30	; Reg.  2: Plane A is at 0xC000
	DC.B	0x40	; Reg.  3: Window is at 0x10000 (disable)
	DC.B	0x07	; Reg.  4: Plane B is at 0xE000
	DC.B	0x6A	; Reg.  5: Sprite attribute table is at 0xD400
	DC.B	0x00	; Reg.  6: always zero
	DC.B	0x00	; Reg.  7: Background color: palette 0, color 0
	DC.B	0x00	; Reg.  8: always zero
	DC.B	0x00	; Reg.  9: always zero
	DC.B	0x00	; Reg. 10: Hint timing
	DC.B	0x08	; Reg. 11: Enable Eint, full scroll
	DC.B	0x81	; Reg. 12: Disable Shadow/Highlight, no interlace, 40 cell mode
	DC.B	0x34	; Reg. 13: Hscroll is at 0xD000
	DC.B	0x00	; Reg. 14: always zero
	DC.B	0x02	; Reg. 15: autoincrement of 2
	DC.B	0x01	; Reg. 16: Scroll 32V and 64H
	DC.B	0x00	; Reg. 17: Set window X position/size to 0
	DC.B	0x00	; Reg. 18: Set window Y position/size to 0
	DC.B	0x00	; Reg. 19: DMA counter low
	DC.B	0x00	; Reg. 20: DMA counter high
	DC.B	0x00	; Reg. 21: DMA source address low
	DC.B	0x00	; Reg. 22: DMA source address mid
	DC.B	0x00	; Reg. 23: DMA source address high, DMA mode ?
