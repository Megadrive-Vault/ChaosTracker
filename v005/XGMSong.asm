	.align	2
XGMSong:
	.incbin	Hydro2.xgm		;We load the song for the XGM driver to play to test the results of the XGM mods and
XGMSongEnd:					;the 68k XGM buffering. Mostly though this is a test to see how well the driver handles buffering from
							;an external source. Hopefully this is the part where things go smoothly.
	.align	2
