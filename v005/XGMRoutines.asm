CheckXGMBusy:
	move.b		Sync68kZ80, d0	;read busy flag
	rts

LoadXGM:
	move.b		#0h, Sync68kZ80	;Driver Ready for buffering
	jsr			InitializeXGM	

	rts

RefreshXGM:
	cmp.b		#0h, d0
	beq.b		RefreshBufferXGM	

	rts


InitializeXGM:

	move.l		#XGMSong, d0		;Start ROM address
	add.l		#2208h, d0			;Offset for XGM music data bloc
	move.l		d0, XGMBufferCurrent;Store the current read buffer address 
	move.l		d0, a0				;Init Read Buffer
	move.l		#XGMBufferZ80, a1	;Init Write Buffer
	moveq		#0h, d0				;Clear for command work
	moveq		#0h, d1				;Set byte counter to 0, each byte write is taken into consideration
									;and added to the counter. When the counter = 256, we're done, if it's > 256
									;We remove the extra bytes and reset the addresses so that they point to the next command

	jsr			Z80BUSREQ
	jsr			BufferXGM				;We buffer the XGM music data block FIRST
	move.b		#XGMPlay, XGMPlayback	;This informs the sound driver that it's time to play the song					
	jsr			Z80BUSREQEND
	rts

RefreshBufferXGM:

	move.l		XGMBufferCurrent, d0;Restore the current read buffer address 
	move.l		d0, a0				;Init Read Buffer
	move.l		#XGMBufferZ80, a1	;Init Write Buffer
	moveq		#0h, d0				;Clear for command work
	moveq		#0h, d1				;Set byte counter to 0, each byte write is taken into consideration
									;and added to the counter. When the counter = 256, we're done, if it's > 256
									;We remove the extra bytes and reset the addresses so that they point to the next command

	jsr			Z80BUSREQ
	jsr			BufferXGM				;We buffer the XGM music data block FIRST
	move.b		#XGMPlay, XGMPlayback	;This informs the sound driver that it's time to play the song					
	jsr			Z80BUSREQEND
	rts

BufferXGM:
	;------Register usage---------------
	;d0 = XGM Command (for work use)
	;d1 = byte counter (256 max)
	;a0 = Current read buffer
	;a1 = Current write buffer
	
;OVERVIEW
;	Here is where either a buffer until 256 bytes max is 
;	done, or a buffer until the next frame command is reached.
;	Also, if END command is reached, playback state is changed to
;	stopped and Busy flag will be set to 2, if Busy == 2, skip buffer code.
;
;If Command == 00h, done buffering
;If Command == 1Xh, 2Xh, 3Xh, 4Xh, 5Xh, 7Eh then process within the rules of each command
;If Command == 7F then End playback, set busy flag = 2 and leave buffer code
;If Command == 6Xh or >= 80h then skip. These are for "internal use only". If problems arise then try processing instead
;or just contact Stef for more information.
;SEE XGM SPECIFICATIONS FOR MORE INFORMATION ON COMMANDS, IT'S INCLUDED WITH THE SGDK
.BufferLoop
	moveq		#0h, d0	
	move.b		(a0), d0		;Read command
			
	;For the sake of efficiency, we check these three first
	;They are the commands for Frame Wait, Loop, and Song End
	cmp.b		#0h, d0			;Is it 00?
	beq.b		.Command_00h	
	cmp.b		#7Eh, d0			;Is it 7E?
	beq.w		.Command_7Eh
	cmp.b		#7Fh, d0			;Is it 7F?
	beq.w		.Command_7Fh

	;These commands involve actual music data and sound chip writes.
	ror.w		#4h, d0			;Isolate first number of command for compares
	cmp.b		#1h, d0			;Is it 1X?
	beq.b		.Command_1Xh
	cmp.b		#2h, d0			;Is it 2X?
	beq.b		.Command_2Xh
	cmp.b		#3h, d0			;Is it 3X?
	beq.b		.Command_3Xh
	cmp.b		#4h, d0			;Is it 4X?
	beq.b		.Command_4Xh
	cmp.b		#5h, d0			;Is it 5X?
	beq.b		.Command_5Xh

	;These commands are declared by Stef "For internal use only", so unless problems are caused from not using
	;them, we check for them and just write them to the buffer anyways,
	cmp.b		#6h, d0			;Is it 6X?
	beq.w		.Command_6Xh
	cmp.b		#8h, d0			;Is it >= 80?
	bge.w		.Command_Greater_Than_7Fh

;*
.Command_00h
	add.w		#1h, d1
	add.l		#1h, a0
	move.l		a0, XGMBufferCurrent	;We increment the address register, for good measure and we store the buffer read
										;address for the next buffer operation.	
	bra.w			.BufferComplete

;*
.Command_1Xh
	rol.w		#4h, d0			;Restore byte value the way it was
	and.w		#0000000000001111b, d0   ;Mask out the crap, now we have the amount of bytes to write	
	addq.b		#1h, d0
	add.w		d0, d1
.Write1Xh
	move.b		(a0)+,(a1)+
	dbra		d0, .Write1Xh	;We write the commands until all of them are finished writing, then 
	bra.b			.Check256Limit		;we return to the main buffer loop

;*
.Command_2Xh

	rol.w		#4h, d0			;Restore byte value the way it was
	and.w		#0000000000001111b, d0   ;Mask out the crap, now we have the amount of bytes to write
	addq.b		#1h, d0	
	add.b		d0, d0			;Multiply by 2
	add.w		d0, d1	
.Write2Xh
	move.b		(a0)+,(a1)+
	dbra		d0, .Write2Xh	;We write the commands until all of them are finished writing, then 
	bra.b			.Check256Limit		;we return to the main buffer loop

;*
.Command_3Xh
	rol.w		#4h, d0			;Restore byte value the way it was
	and.w		#0000000000001111b, d0   ;Mask out the crap, now we have the amount of bytes to write
	addq.b		#1h, d0	
	add.b		d0, d0			;Multiply by 2			
	add.w		d0, d1
.Write3Xh
	move.b		(a0)+,(a1)+
	dbra		d0, .Write3Xh	;We write the commands until all of them are finished writing, then 
	bra.b			.Check256Limit		;we return to the main buffer loop

;*
.Command_4Xh
	rol.w		#4h, d0			;Restore byte value the way it was
	and.w		#0000000000001111b, d0   ;Mask out the crap, now we have the amount of bytes to write
	addq.b		#1h, d0
	add.w		d0, d1
.Write4Xh
	move.b		(a0)+,(a1)+
	dbra		d0, .Write4Xh	;We write the commands until all of them are finished writing, then 
	bra.b			.Check256Limit		;we return to the main buffer loop

;*
.Command_5Xh
	moveq		#0h, d0
	add.w		#2h, d1
	move.b		(a0)+, (a1)+
	move.b		(a0)+, (a1)+
	bra.b			.Check256Limit		;we return to the main buffer loop

;*
.Command_7Eh
	moveq		#0h, d0
	add.w		#4h, d1
	move.b		(a0)+, (a1)+
	move.b		(a0)+, (a1)+
	move.b		(a0)+, (a1)+
	move.b		(a0)+, (a1)+
	bra.b			.Check256Limit		;we return to the main buffer loop

;*
.Command_7Fh
	moveq		#0h, d0
	add.w		#1h, d1	
	move.b		(a0)+, (a1)+
	bra.b			.SongComplete
;*
.Command_6Xh
	rts

;*
.Command_Greater_Than_7Fh
	rts

.Check256Limit
	cmp.w		#100h, d1 
	ble			.BufferLoop  
	rts
.BufferComplete
	rts

.SongComplete
	move.b		#0x2, Sync68kZ80	;Driver Stopped	
	rts
