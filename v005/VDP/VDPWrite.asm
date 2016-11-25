;=======================
; Functions that prepare
; VDP and addresses for 
; certain graphics to be
; loaded into VRAM/CRAM
;=======================

Load_System_Palette_1:
	move.l	#0xC0000000, VDPControlPort  ;We're informing the VDP that we're writing to CRAM at 0x0000
	lea		SystemFont_pal, a0
	moveq	#0x0, d0
	move.b	#0x8, d0
	jsr		Load_Palette_1
	rts

Load_System_Font_A:
	move.l	#0x40000000, VDPControlPort  ;We're going to write to VRAM
	lea 	SystemFont_tiles, a0
	move.w	#0x7FF, d0
	jsr		Load_Tiles_A
	rts



;=========================
; These functions load the
; VDP with data previously 
; specified elsewhere
;=========================

; a0 = Contains Effective Address of graphical data (tiles/palette/etc.)
; d0 = Iterations for loop
; VDP Control Port should already be set beforehand.

Load_Palette_1:                         	     ;This routine can be reused for other palettes, just adjust addresses.
	move.l	(a0)+, VDPDataPort
	dbra	d0, Load_Palette_1	
	rts

Load_Tiles_A:                                   ;This routine can also be reused for other fonts, just adjust addresses.
	move.l	(a0)+, VDPDataPort
	dbra	d0, Load_Tiles_A
	rts





;CharTest is a test routine for printing a couple of ASCII characters to screen. This routine is no longer in use
; and can be safely removed from the source code.

CharTest:			      	     ;Drawing a quick char to Plane A to make sure display is good.
	move.l	#0x40000003, VDPControlPort  ;Should be 0xC000 for Plane A.
	move.w	#0x0002, VDPDataPort
	move.l  #0x40800003, VDPControlPort  ;We're going to draw another char directly underneath the first one.
	move.w  #0x0003, VDPDataPort
	rts
