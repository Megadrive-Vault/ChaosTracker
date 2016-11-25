User_Interface:
	jsr		Wipe_Screen_Buffer_A			;Clear both buffers before doing anything else
	jsr		Wipe_Screen_Buffer_B

	jsr		Load_Menubar						;Loads the Menubar panel to screen buffer
	jsr		Check_Menubar_Selection 			;Checks the Menubar state/loads panels by selection

	rts

Wipe_Screen_Buffer_A:
	move.l		#ScreenBufferA, a0				;Set up address, number of writes, clear.
	move.l		#0x22F, d0						;The buffer is technically made up of 1,120 word, but
	moveq		#0x0, d1							;we've optimized the function a bit.
@Wipe
	move.l		d1, (a0)+
	dbra		d0, @Wipe
	rts

Wipe_Screen_Buffer_B:
	move.l		#ScreenBufferB, a0				;Set up address, number of writes, clear.
	move.l		#0x22F, d0						;The buffer is technically made up of 1,120 word, but
	moveq		#0x0, d1							;we've optimized the function a bit.
@Wipe
	move.l		d1, (a0)+
	dbra		d0, @Wipe
	rts


Load_Menubar:

	lea		MenuBarSpecs, a0		;Prepares a0 with panel specs
	lea		MenuBar_map, a1					;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2				;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	rts

Check_Menubar_Selection:
	;All we're doing is handling menubar states. If MenuBarSelection == #2h "View" is selected, display the "View"
	;options panel and highlight "View" on the menubar to indicate that it is the menu option selected by the user.
	move.b	MenuBarSelection, d0
	cmp.b	#0x01, d0
	beq.b	Menubar_File_Selected
	cmp.b	#0x02, d0
	beq.w	Menubar_Edit_Selected
	cmp.b	#0x03, d0
	beq.w	Menubar_View_Selected
	cmp.b	#0x04, d0
	beq.w	Menubar_Help_Selected
	cmp.b	#0x05, d0
	beq.w	Submenu_Pattern_Selected
	cmp.b	#0x06, d0
	beq.w	Submenu_Select_Selected
	cmp.b	#0x07, d0
	beq.w	Submenu_Instruments_Selected
	rts

Menubar_File_Selected:

	lea		MenuBarFileSpecs, a0	;Prepares a0 with panel specs
	lea		MenuBar_map, a1					;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2				;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	lea		MenuBarFileLabel, a0		;Prepares the Label Specs for selection highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	jsr		Highlight_Label					;Highlights the selection on the menubar

	moveq	#0x0, d0
	move.b	MenuBarOptionSelection, d0	;We need the offset to point to the correct data in the LabelHighlightLUT
	cmp.b	#0x0, d0						;If it's 0, we skip this entire segment of code, no highlighting.
	beq.b	@Skip
	lea		LabelHighlightLUT, a0		;Prepares the Label Specs for cursor highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	mulu.w	#0xC, d0
	adda.l	d0,	a0
	jsr		Highlight_Label				;Let's highlight the menu option
@Skip
	rts

Menubar_Edit_Selected:

	lea		MenuBarEditSpecs, a0	;Prepares a0 with panel specs
	lea		MenuBar_map, a1					;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2				;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	lea		MenuBarEditLabel, a0		;Prepares the Label Specs for selection highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	jsr		Highlight_Label					;Highlights the selection on the menubar

	moveq	#0x0, d0
	move.b	MenuBarOptionSelection, d0	;We need the offset to point to the correct data in the LabelHighlightLUT
	cmp.b	#0x0, d0						;If it's 0, we skip this entire segment of code, no highlighting.
	beq.b	@Skip
	lea		LabelHighlightLUT, a0		;Prepares the Label Specs for cursor highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	mulu.w	#0xC, d0
	adda.l	d0,	a0
	jsr		Highlight_Label				;Let's highlight the menu option
@Skip
	rts

Menubar_View_Selected:

	lea		MenuBarViewSpecs, a0	;Prepares a0 with panel specs
	lea		MenuBar_map, a1					;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2				;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	lea		MenuBarViewLabel, a0		;Prepares the Label Specs for selection highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	jsr		Highlight_Label					;Highlights the selection on the menubar

	moveq	#0x0, d0
	move.b	MenuBarOptionSelection, d0	;We need the offset to point to the correct data in the LabelHighlightLUT
	cmp.b	#0x0, d0						;If it's 0, we skip this entire segment of code, no highlighting.
	beq.b	@Skip
	lea		LabelHighlightLUT, a0		;Prepares the Label Specs for cursor highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	mulu.w	#0xC, d0
	adda.l	d0,	a0
	jsr		Highlight_Label				;Let's highlight the menu option
@Skip
	rts
Menubar_Help_Selected:

	lea		MenuBarHelpSpecs, a0	;Prepares a0 with panel specs
	lea		MenuBar_map, a1					;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2				;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	lea		MenuBarHelpLabel, a0		;Prepares the Label Specs for selection highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	jsr		Highlight_Label					;Highlights the selection on the menubar

	moveq	#0x0, d0
	move.b	MenuBarOptionSelection, d0	;We need the offset to point to the correct data in the LabelHighlightLUT
	cmp.b	#0x0, d0						;If it's 0, we skip this entire segment of code, no highlighting.
	beq.b	@Skip
	lea		LabelHighlightLUT, a0		;Prepares the Label Specs for cursor highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	mulu.w	#0xC, d0
	adda.l	d0,	a0
	jsr		Highlight_Label				;Let's highlight the menu option
@Skip
	rts

Submenu_Pattern_Selected:
	jsr		MenuBar_Edit_Selected				;Loads Edit menu first
	lea		SubMenuPatternSpecs, a0	;Prepares a0 with panel specs
	lea		MenuBar_map, a1						;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2					;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	lea		MenuBarPatternLabel, a0			;Prepares the Label Specs for selection highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	jsr		Highlight_Label					;Highlights the selection on the menubar

	moveq	#0x0, d0
	move.b	MenuBarOptionSelection, d0	;We need the offset to point to the correct data in the LabelHighlightLUT
	cmp.b	#0x0, d0						;If it's 0, we skip this entire segment of code, no highlighting.
	beq.b	@Skip
	lea		LabelHighlightLUT, a0		;Prepares the Label Specs for cursor highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	mulu.w	#0xC, d0
	adda.l	d0,	a0
	jsr		Highlight_Label				;Let's highlight the menu option
@Skip
	rts

Submenu_Select_Selected:
	jsr		MenuBar_Edit_Selected				;Loads Edit menu first
	lea		SubMenuSelectSpecs, a0		;Prepares a0 with panel specs
	lea		MenuBar_map, a1						;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2					;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	lea		MenuBarSelectLabel, a0			;Prepares the Label Specs for selection highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	jsr		Highlight_Label					;Highlights the selection on the menubar

	moveq	#0x0, d0
	move.b	MenuBarOptionSelection, d0	;We need the offset to point to the correct data in the LabelHighlightLUT
	cmp.b	#0x0, d0						;If it's 0, we skip this entire segment of code, no highlighting.
	beq.b	@Skip
	lea		LabelHighlightLUT, a0		;Prepares the Label Specs for cursor highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	mulu.w	#0xC, d0
	adda.l	d0,	a0
	jsr		Highlight_Label				;Let's highlight the menu option
@Skip
	rts

Submenu_Instruments_Selected:
	jsr		MenuBar_View_Selected						;Loads Edit menu first
	lea		SubMenuInstrumentsSpecs, a0		;Prepares a0 with panel specs
	lea		MenuBar_map, a1								;Prepares a1 with panel's tile map
	move.l	#ScreenBufferA, a2							;Prepares a2 with Screen Buffer A's address
	jsr		Load_Panel

	lea		MenuBarInstrumentsLabel, a0			;Prepares the Label Specs for selection highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	jsr		Highlight_Label					;Highlights the selection on the menubar

	moveq	#0x0, d0
	move.b	MenuBarOptionSelection, d0	;We need the offset to point to the correct data in the LabelHighlightLUT
	cmp.b	#0x0, d0						;If it's 0, we skip this entire segment of code, no highlighting.
	beq.b	@Skip
	lea		LabelHighlightLUT, a0		;Prepares the Label Specs for cursor highlighting
	move.l	#ScreenBufferA, a1
	move.l	#ScreenBufferA, a2
	mulu.w	#0xC, d0
	adda.l	d0,	a0
	jsr		Highlight_Label				;Let's highlight the menu option
@Skip
	rts

Load_Panel:
	move.l	(a0)+, d0						;Loads starting address relative to ROM location into d1
	move.l	(a0)+, d1						;Loads dimensions x and y (Upper word x Lower word)
	move.l	(a0)+, d2						;Loads default X and Y destination coordinates
	adda.l	d0, a1							;Add the panel's starting offset to the ROM address
	sub.l	#0x00010001, d1					;Subtract 1 for both X and Y dimensions for the counter
	move.l	a1, a3							;Store for address reset and offset on height increment

	moveq	#0x0, d3							;Clear d3, then move Y coord lower word to it
	move.w	d1, d3
	swap	d1								;Bring X coord to lower word of d1
	andi.l	#0x0000FFFF, d1					;mask out the upper word
	move.l	d1, d7							;Store a copy for reseting the loop
	moveq	#0x0, d4
	move.w	d2, d4
	swap	d2
	andi.l	#0x0000FFFF, d2

	add.l	d2, d2							;X is now converted to an offset to add to the buffer's address
	mulu.w	#0x80, d4						;Y is now converted to an offset to add to the buffer's address
	add.l	d2, d4
	adda.l	d4, a2							;a2 contains the starting address for the panel
	move.l	a2, d6							;store the destination address for proper Y plotting
;d1 = Width in tiles (word
;d3 = Height in tiles (word)
;a1 = source address (words)
;a2 = destination address (words)
@Load_To_Buffer
	move.w	(a1)+, (a2)+
	dbra	d1, @Load_To_Buffer
	cmp.w	#0x0000, d3						;Is this panel only 1 tile in height?
	beq.b	@Done							;Yes, so we're done
	sub.w	#0x0001, d3						;Subtract 1 from our height counter
	add.l	#0x0080, d6						;Reset X and Y coordinates and store
	move.l	d6, a2
	move.l	d7, d1
	adda.l	#0x0050, a3
	move.l	a3, a1							;Reset to start but offset to next Y

	bra.b	@Load_To_Buffer					;Continue buffering
@Done
	rts


Highlight_Label:
	move.l	(a0)+, d0						;Loads starting address relative to RAM location into d1
	move.l	(a0)+, d1						;Loads dimensions x and y (Upper word x Lower word)
	move.l	(a0)+, d2						;Loads default X and Y destination coordinates
	adda.l	d0, a1							;Add the panel's starting offset to the ROM address
	sub.l	#0x00010001, d1					;Subtract 1 for both X and Y dimensions for the counter
	move.l	a1, a3							;Store for address reset and offset on height increment

	moveq	#0x0, d3							;Clear d3, then move Y coord lower word to it
	move.w	d1, d3
	swap	d1								;Bring X coord to lower word of d1
	andi.l	#0x0000FFFF, d1					;mask out the upper word
	move.l	d1, d7							;Store a copy for reseting the loop
	moveq	#0x0, d4
	move.w	d2, d4
	swap	d2
	andi.l	#0x0000FFFF, d2

	add.l	d2, d2							;X is now converted to an offset to add to the buffer's address
	mulu.w	#0x80, d4						;Y is now converted to an offset to add to the buffer's address
	add.l	d2, d4
	adda.l	d4, a2							;a2 contains the starting address for the panel
	move.l	a2, d6							;store the destination address for proper Y plotting
;d1 = Width in tiles (word
;d3 = Height in tiles (word)
;a1 = source address (words)
;a2 = destination address (words)
@Load_To_Buffer
	moveq	#0x0, d0
	move.w	(a1)+, d0
	add.w	#0x80, d0
	move.w	d0, (a2)+
	dbra	d1, @Load_To_Buffer
	cmp.w	#0x0000, d3						;Is this panel only 1 tile in height?
	beq.b	@Done							;Yes, so we're done
	sub.w	#0x0001, d3						;Subtract 1 from our height counter
	add.l	#0x0080, d6						;Reset X and Y coordinates and store
	move.l	d6, a2
	move.l	d7, d1
	adda.l	#0x0050, a3
	move.l	a3, a1							;Reset to start but offset to next Y

	bra.b	@Load_To_Buffer					;Continue buffering
@Done
	rts