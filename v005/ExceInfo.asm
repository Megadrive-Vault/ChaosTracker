

Hello_World:
	DC.B	"|HELLO WORLD!!|NEXT LINE^A "

;****************Displaying text****************************************************
;The HelloWorld above demonstrates a simple text string. "|" Is used to start a new line, like in C with \n, "^" is used to terminate a
;string, so that the routine doesn't read garbage and bork the VDP.







Exception_Display:
	DC.B	"||68K DATA REGISTERS|D0 0X|D1 0X|D2 0X|D3 0X|D4 0X|D5 0X|D6 0X|D7 0X"
	DC.B	"||68K ADDRESS REGISTERS|A0 0X|A1 0X|A2 0X|A3 0X|A4 0X|A5 0X|A6 0X|A7 0X"
    DC.B    "||STACK FRAME ^"
Error_0:
	DC.B	"SYSTEM ERROR^"
Interrupt_1:
	DC.B	"INTERRUPT^"
Bus_Error_2:
	DC.B	"BUS ERROR^"
Address_Error_3:
	DC.B	"ADDRESS ERROR^"
Illegal_Opcode_4:
	DC.B	"ILLEGAL OPCODE^"
Division_By_Zero_5:
	DC.B	"DIVISION BY ZERO^"
CHK_Exception_6:
	DC.B	"CHK EXCEPTION^"
TRAPV_Exception_7:
	DC.B	"TRAPV EXCEPTION^"
Privilege_Violation_8:
	DC.B	"PRIVILEGE VIOLATION^"
TRACE_Exception_9:
	DC.B	"TRACE EXCEPTION^"
LineA_Emulator_A:
	DC.B	"LINE A EMULATOR^"
LineF_Emulator_B:
	DC.B	"LINE F EMULATOR^"

Exception_Screen:
	jsr		Wipe_Plane_A
	jsr		Wipe_Plane_B
	jsr		Assign_Exception  ;We need to tell the system what exception was triggered so we know what to print

	;Here is where we print to the screen static information, see the ExceptionDisplay string for details.
	move.l  Stack_Frame_1, d6
	move.l  #0x0000CB84, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String
	move.l  Stack_Frame_2, d6
	move.l  #0x0000CB96, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String
    move.l  Stack_Frame_3, d6
	move.l  #0x0000CC04, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String
    move.l  Stack_Frame_4, d6
	move.l  #0x0000CC16, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String
	move.l  Stack_Frame_5, d6
	move.l  #0x0000CC84, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String
	move.l  Stack_Frame_6, d6
	move.l  #0x0000CC96, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String
    move.l  Stack_Frame_7, d6
	move.l  #0x0000CD04, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String
    move.l  Stack_Frame_8, d6
	move.l  #0x0000CD16, d0
    move.l  d0, d1
    move.l  d0, d4
    move.l  #0x03, d5
    jsr     Print_RAM_String

	move.l	#0x0000C082, d0 	;The VRAM address we start with, it is the base address offset by two to prevent					;printing characters on the far left edge of the screen, which is obscured on TV's
	move.l	d0, d1			;d1 is used to indicate current address
	move.l	d0, d4			;d4 is used to indicate the address of the starting line for the current line
					;that way we can keep track of where we need to go to print a new line
	jsr		@PrintString

	lea		Exception_Display, a0
	move.l	#0x0000C002, d0 	;The VRAM address we start with, it is the base address offset by two to prevent					;printing characters on the far left edge of the screen, which is obscured on TV's
	move.l	d0, d1			;d1 is used to indicate current address
	move.l	d0, d4			;d4 is used to indicate the address of the starting line for the current line
					;that way we can keep track of where we need to go to print a new line
	jsr		@PrintString

	move.l	D068k, d6		;This prints all the 68k Register's contents to the screen
	move.l	#0x0000C18C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	D168k, d6
	move.l	#0x0000C20C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	D268k, d6
	move.l	#0x0000C28C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	D368k, d6
	move.l	#0x0000C30C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	D468k, d6
	move.l	#0x0000C38C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	D568k, d6
	move.l	#0x0000C40C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	D668k, d6
	move.l	#0x0000C48C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	D768k, d6
	move.l	#0x0000C50C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String


	move.l	A068k, d6
	move.l	#0x0000C68C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	A168k, d6
	move.l	#0x0000C70C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	A268k, d6
	move.l	#0x0000C78C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	A368k, d6
	move.l	#0x0000C80C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	A468k, d6
	move.l	#0x0000C88C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	A568k, d6
	move.l	#0x0000C90C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	A668k, d6
	move.l	#0x0000C98C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String
	move.l	A768k, d6
	move.l	#0x0000CA0C, d0
	move.l	d0, d1
	move.l	d0, d4
	move.l	#0x03, d5
	jsr		Print_RAM_String


	rts

@PrintString:
	move.l	d1, d2			;Copy address over
	rol.l	#0x02, d2       	;bits 15 & 14 into first byte of upper word
	ror.w	#0x02, d2       	;Shift the rest back to where they were
	add.w	#0x4000, d2		;It's a VRAM write
	swap	d2			;Swap halves
	move.l	d2, VDPControlPort	;Tell VDP where the character is going
	bra.b	@PrintLoop
	rts
@PrintLoop:
	moveq	#0x0, d3		;Clear d3 for a character
	move.b	(a0)+, d3		;Load the character
	sub.w	#0x0020, d3		;Offset ASCII code to pattern ID

	cmp.w	#0x003E, d3		;Is it the ^ character? If so we terminate the string
	beq.b	@TerminateString
	cmp.w	#0x005C, d3		;Is it the | character? If so we go to new line
	beq.b	@NewLineString

	move.w	d3, VDPDataPort		;Load character into VRAM
	bra.b	@PrintLoop
	rts

@TerminateString:
	rts

@NewLineString:
	add.l	#0x00000080, d4		;Sets the address to new line.
	move.l	d4, d1			;Sets the current address
	bra.b	@PrintString		;Go back to printing loop

Print_RAM_String:
	move.l	d1, d2			;Copy address over
	rol.l	#0x02, d2       	;bits 15 & 14 into first byte of upper word
	ror.w	#0x02, d2       	;Shift the rest back to where they were
	add.w	#0x4000, d2		;It's a VRAM write
	swap	d2			;Swap halves
	move.l	d2, VDPControlPort	;Tell VDP where the character is going

	;0x12345678
	rol.l	#0x08, d6
	;0x34567812

@PrintRAMLoop:
	moveq	#0x0, d3		;Clear d3 for a character

	move.b	d6, d3		;Load the character
	;0x34567812
	rol.l	#0x08, d6	;Prepare for the next byte
	;d6 = 0x56781234
	rol.w	#0x08, d3
	;d3 = 0x00001200
	rol.l	#0x04, d3
	;0x00012000
	rol.w	#0x04, d3
	;0x00010002
	cmp.b	#0x0A, d3
	bge.b	@CompensateHex
@FinishCompensate:
	add.b	#0x10, d3
	swap	d3
	cmp.b	#0x0A, d3
	bge.b	@CompensateHex2
@FinishCompensate2:
	add.b	#0x10, d3

	move.w	d3, VDPDataPort		;Load character into VRAM
	swap	d3
	move.w	d3, VDPDataPort
	dbra	d5, @PrintRAMLoop
	rts

@CompensateHex
	add.b	#0x07, d3
	bra	@FinishCompensate

@CompensateHex2
	add.b	#0x07, d3
	bra	@FinishCompensate2

Assign_Exception:
	move.l	ExceptionCode, d0
	cmp.b	#0x00, d0
	beq.b	@EC0
	cmp.b	#0x01, d0
	beq.b	@EC1
	cmp.b	#0x02, d0
	beq.b	@EC2
	cmp.b	#0x03, d0
	beq.b	@EC3
	cmp.b	#0x04, d0
	beq.b	@EC4
	cmp.b	#0x05, d0
	beq.b	@EC5
	cmp.b	#0x06, d0
	beq.b	@EC6
	cmp.b	#0x07, d0
	beq.b	@EC7
	cmp.b	#0x08, d0
	beq.b	@EC8
	cmp.b	#0x09, d0
	beq.b	@EC9
	cmp.b	#0x0a, d0
	beq.b	@ECa
	cmp.b	#0x0b, d0
	beq.b	@ECb
	rts

@EC0:
	lea	Error_0, a0
	rts
@EC1:
	lea	Interrupt_1, a0
	rts
@EC2:
	lea	Bus_Error_2, a0
	rts
@EC3:
	lea	Address_Error_3, a0
	rts
@EC4
	lea	Illegal_Opcode_4, a0
	rts
@EC5
	lea	Division_By_Zero_5, a0
	rts
@EC6
	lea	CHK_Exception_6, a0
	rts
@EC7
	lea	TRAPV_Exception_7, a0
	rts
@EC8
	lea	Privilege_Violation_8, a0
	rts
@EC9
	lea	Trace_Exception_9, a0
	rts
@ECa
	lea	LineA_Emulator_A, a0
	rts
@ECb
	lea	LineF_Emulator_B, a0
	rts
