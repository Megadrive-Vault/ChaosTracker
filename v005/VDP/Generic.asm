Wipe_Plane_A:
	move.l	#0x40000003, VDPControlPort
	move.l	#0x800, d0 ;Counter
@WipeA
	move.w #0x0000, VDPDataPort
	dbra	d0, @WipeA

	rts

Wipe_Plane_B:
	move.l	#0x60000003, VDPControlPort
	move.l	#0x800, d0 ;Counter
@WipeB
	move.w 	#0x0000, VDPDataPort
	dbra	d0, @WipeB

	rts

Buffer_To_Plane_A:
	move.l	#0x40000003, VDPControlPort
	move.l	#0x800, d0
	move.l	#ScreenBufferA, a0
@Load_Buffer:
	move.w	(a0)+, VDPDataPort
	dbra	d0, @Load_Buffer

	rts

Buffer_To_Plane_B:
	move.l	#0x60000003, VDPControlPort
	move.l	#800, d0
	move.l	#ScreenBufferB, a0
@Load_Buffer:
	move.w	(a0)+, VDPDataPort
	dbra	d0, @Load_Buffer

	rts

Detect_PAL:
;Simple function checks to see if in PAL mode
    move.l  #VDPControlPort, a0
    move.w  (a0), d7
    ;first bit of d7 returns PAL or NTSC(1 or 0)
    rts