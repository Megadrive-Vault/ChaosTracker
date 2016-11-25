;=================================
;		PAD INPUT
;=================================

Handle_Input_3_Button_Pad_1:
	move.w			Pad1Result, d0
	btst			#Pad1Start, d0	;Start button Pressed?
	bne.b			.NoStart
	btst			#Pad1Start, d0	;Start button Pressed?	
	beq.b			.Start;Yes, so we load the song to the XGM driver.
	rts

.NoStart

	rts

.Start
	rts
