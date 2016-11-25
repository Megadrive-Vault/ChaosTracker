;============
;VDP Globals
;============
VSync:			= 0xFF0000
HSync:			= 0xFF0004
VDPDataPort:	= 0xC00000
VDPControlPort: = 0xC00004


;============
;PSG Globals
;============
PSGPort:        = 0xC00011

;===================
;68K Registers RAM
;===================
;These are used for storing register contents
;so that when an Exception comes up, the contents
;of the 68k at the time of the error are able to be shown
;without the use of an emulator debugger (MAME, Regen, GensKmod)
;or an external debugger for that matter. It's useful for those crashes
;that only occur on real hardware.
D068k:			= 0xFF0008      ;Long
D168k:			= 0xFF000C
D268k:			= 0xFF0010
D368k:			= 0xFF0014
D468k:			= 0xFF0018
D568k:			= 0xFF001C
D668k:			= 0xFF0020
D768k: 			= 0xFF0024
A068k: 			= 0xFF0028
A168k: 			= 0xFF002C
A268k: 			= 0xFF0030
A368k: 			= 0xFF0034
A468k: 			= 0xFF0038
A568k: 			= 0xFF003C
A668k: 			= 0xFF0040
A768k: 			= 0xFF0044
ExceptionCode: 	= 0xFF0048
ExceptionGroup: = 0xFF004c
Stack_Frame_1:  = 0xFF5000
Stack_Frame_2:  = 0xFF5004
Stack_Frame_3:  = 0xFF5008
Stack_Frame_4:  = 0xFF500c
Stack_Frame_5:  = 0xFF5010
Stack_Frame_6:  = 0xFF5014
Stack_Frame_7:  = 0xFF5018
Stack_Frame_8:  = 0xFF501c

;====
;I/O
;====
PadDataPortA:	= 0xA10003
PadDataPortB:	= 0xA10005

Pad1Up:			= 0x0		;These represent button presses
Pad1Down:		= 0x1
Pad1Left:		= 0x2
Pad1Right:		= 0x3
Pad1A:			= 0xC
Pad1B:			= 0x4
Pad1C:			= 0x5
Pad1Start:		= 0xD
Pad1Result:		= 0xFF0050 ;Word, stores all input data read this frame
Pad2Result:		= 0xFF0052 ;Word, stores all input data read this frame

;====
;z80
;====
XGMPlay:		= 0x20
XGMResume:		= 0x10
XGMStop:		= 0x8
XGMPlayback:	= 0xA00100
XGMBufferZ80:	= 0xA01700 ;100h or 256d bytes in size


;Sync68kZ80:		        = 0xFIXME
;XGMBufferCurrent:			= 0xFIXME		; Long, Pointer to current ROM offset for the buffer, so we can continue where we left off
												; last frame.
;==========================
; Playback Buffers
;==========================
;
;Each time a row is to be played, we buffer from that row the following:
;Note/Oct, Instrument #, Vol, Commands
;Since all instruments are already buffered in RAM, it would be wasteful to buffer the current preset
;to RAM. So we index to it instead with the Instrument #.
;
;A feature I had planned with YMDJ/Prodigy, was Command Previewing. This would be good to investigate further into
;at a later time.

;Note and FREQ data
;These have dual purpose, used for storing current row's note and when converted, will store FREQ data for sound chips.
FM_Ch1_Note_Buffer: = 0x00FF0056   ;Word, each note is buffered as freq data for sound hardware, for playback.
FM_Ch2_Note_Buffer: = 0x00FF0058
FM_Ch3_Note_Buffer: = 0x00FF005a
FM_Ch4_Note_Buffer: = 0x00FF005c
FM_Ch5_Note_Buffer: = 0x00FF005e
FM_Ch6_Note_Buffer: = 0x00FF0060


PSG_Ch1_Note_Buffer: = 0x00FF0062 ;Word
PSG_Ch2_Note_Buffer: = 0x00FF0064
PSG_Ch3_Note_Buffer: = 0x00FF0066
PSG_Ch4_Note_Buffer: = 0x00FF0068

;Volume buffers
FM_Ch1_Volume_Buffer:   = 0x00FF006a ;Byte
FM_Ch2_Volume_Buffer:   = 0x00FF006b
FM_Ch3_Volume_Buffer:   = 0x00FF006c
FM_Ch4_Volume_Buffer:   = 0x00FF006d
FM_Ch5_Volume_Buffer:   = 0x00FF006e
FM_Ch6_Volume_Buffer:   = 0x00FF006f

PSG_Ch1_Volume_Buffer:  = 0x00FF0070 ;Byte
PSG_Ch2_Volume_Buffer:  = 0x00FF0071
PSG_Ch3_Volume_Buffer:  = 0x00FF0072
PSG_Ch4_Volume_Buffer:  = 0x00FF0073

;Instrument # buffers
;we only store the instrument number, for use to index the actual presets in memory.
FM_Ch1_Instrument_Buffer:   = 0x00FF0074 ;Byte
FM_Ch2_Instrument_Buffer:   = 0x00FF0075
FM_Ch3_Instrument_Buffer:   = 0x00FF0076
FM_Ch4_Instrument_Buffer:   = 0x00FF0077
FM_Ch5_Instrument_Buffer:   = 0x00FF0078
FM_Ch6_Instrument_Buffer:   = 0x00FF0079

PSG_Ch1_Instrument_Buffer:  = 0x00FF007a ;Byte
PSG_Ch2_Instrument_Buffer:  = 0x00FF007b
PSG_Ch3_Instrument_Buffer:  = 0x00FF007c
PSG_Ch4_Instrument_Buffer:  = 0x00FF007d

;Command buffers
;We store the command ID and command data.
FM_Ch1_Command_Buffer:  = 0x00FF007e ;Word
FM_Ch2_Command_Buffer:  = 0x00FF0080
FM_Ch3_Command_Buffer:  = 0x00FF0082
FM_Ch4_Command_Buffer:  = 0x00FF0084
FM_Ch5_Command_Buffer:  = 0x00FF0086
FM_Ch6_Command_Buffer:  = 0x00FF0088

PSG_Ch1_Command_Buffer: = 0x00FF008a ;Word
PSG_Ch2_Command_Buffer: = 0x00FF008c
PSG_Ch3_Command_Buffer: = 0x00FF008e
PSG_Ch4_Command_Buffer: = 0x00FF0090

;This is a general playback work buffer, for doing general tasks.
Playback_Work_Buffer:   = 0x00FF0092 ;Word

Playback_Test_Row:      = 0x00FF0094 ;5 Bytes | Note = Byte, Ins # = Byte, Vol = Byte, Command = Word

;Having support for more than one command per row is unlikely given the limited amount of RAM available to us.
;If there is a way to circumvent this limitation, support for more commands will be added...


;ALL ADDRESSES up to 0x00FF00FF are reserved for buffers, since this early in implementation, we're bound
;to find something we didn't known we'd need a buffer for. If we run out of space, we readjust addresses
;beyond this boundary to make room.

;====================
; Instrument presets
;====================
;
;Here we load all presets into RAM
;These presets are loaded into RAM from ROM unless we are loading a song from SRAM
;It should be noted that the ROM instruments are also able to be referenced by the tracker
;directly for read only use, in addition to the instruments copied into RAM.
;
;YM2612 Instruments----------------------------------------------------------------------
;The first 128 GM instruments, are user instruments. These are copied from ROM to RAM and the first 128 will be
;referencing those found in RAM, and are read and write allowed. The second 128 instruments
;are system instruments, referenced directly from ROM for read only use. You have 256 FM instruments
;to use total.
;
;PSG Instruments--------------------------------------------------------------------------
;Like the YM2612, the PSG will also get 256 GM presets split into user and system banks.
;It may seem unintuitive for the PSG, but for GM compatibility and freedom of instrument choice,
;we allow this many.

;Presently an FM preset takes up 38 bytes.
;There are 128 of them to be in RAM so that is 4864
FM_Preset_Buffer:  = 0x00FF00100
PSG_Preset_Buffer: = 0x00FF01400



;=================
; Pattern Banks
;=================
;In Chaos Tracker, FM patterns and PSG patterns are treated separately.
;We refer to this separation as "Banks". The FM bank contains an array 159 or 9Fh patterns.
;The PSG bank contains an array of 127 or 7Fh patterns.
;Each pattern contains 32 or 20h rows of 5 bytes. One byte for note, one byte
;for instrument patch, one byte for volume and two bytes for command.
;Both banks also make use of a Pattern Index, which specifies which pattern
;to use for playback/editing etc. This information is visible and user editable in the Pattern Editor.
;This whole block of information begins with the FM Pattern Index, followed by the PSG Pattern Index.
;Following the PSG Pattern Index, is the FM then PSG Pattern Arrays.

;The user will be given the power to change the maximum number of their FM and PSG patterns, which in turn
;also gives them control over how much memory the Data arrays for all patterns occupy.
;The starting address for the entire Pattern block, including the indexes, is hard coded and cannot alone be changed by the user.
;However you can change the PatternBanksStart define below and all of the Pattern blocks will be shifted to the new address.
;This makes memory management much simpler and allows the Pattern data block to be more portable in the memory map.


;WARNING! CARE MUST BE TAKEN WHEN CHANGING
;THIS ADDRESS. THE SCREEN BUFFERS' DATA
;ENDS RIGHT BEFORE THIS ADDRESS.
PatternBanksStart:		=	0x00FF4000		;Refers to the starting point for the entire mass of pattern information. The rest
											;of the addresses will be calculated from this address, that way if the Pattern data
											;bloc needs to be moved in RAM, it can be done easily by changing this single address.

MaxPatternCountFMBank:	=	0x00FFF4F0		;Byte,| Using these two values, we determine how many patterns are allocated
MaxPatternCountPSGBank: =	0x00FFF4F1		;Byte,| to both the FM and PSG Pattern Banks. So the user can choose based on preference
FMBankArrayStart:		=	0x00FFF4F2		;Pointer, Starting address for FM Bank Array
PSGBankArrayStart:		=	0x00FFF4F6		;Pointer, Starting address for PSG Bank Array
PatternBanksEnd:		=	0x00FFF4FA		;Pointer, Ending address for all Pattern data.
PatternRowCount:		=	0x00FFF4FE		;Byte, the number of Rows available in a pattern
;The reason that the above addresses above are just pointers, is because the Tracker will actually calculate
;The starting addresses for most of these Pattern Bank defines, this is for portability.


;====================
; User Interface
;====================
;In YMDj/Prodigy Tracker, we had a very inefficient method of drawing to the screen. Not only were updates not synchronized well,
;but there were many data operations that should have been done outside of the VBlank. Update lag was visible if
;one looked close enough and it was a very clunky way of doing things anyway... the code was all over the place and poorly coordinated.
;But now with Chaos Tracker, we have a professionally done screen compositing method that uses a RAM buffer until it's time for VBlank.
;An attempt will be made to provide two major flavors of UI, which will by extension also affect how screen navigation/gamepad controls
;are handled. There will be YMDj mode and PC mode. YMDj mode uses the LSDj style of tracker UI/input/etc while Professional mode goes for
;more of a menubar approach to doing things like on desktop/laptop PC's e.g. "File Edit Menu Help etc..." By default, we'll be using
;and promoting Professional Mode, but the option is available for users to change this in Tracker Settings. "But... BUT... I LIKE LSDJ
;INTERFACE!!! WHY PROMOTE THIS PROFESSIONAL MODE???" LSDj's interface was DESIGNED to take full advantage of the Gameboy and although
;impressive, it's a less capable console than what we're working with. Chaos Tracker, like LSDj is designed from the ground up to take
;fullest advantage of the Sega series' 16 and 32 bit hardware. Since it can handle it and we actually have a much larger screen area
;to work with... the menubar approach will be promoted as the standard for Chaos Tracker and it's GBA derivative.

TrackerMode:			=	0x00FF0075		;Byte, 0 = YMDj Mode, 1 = Professional Mode
ActiveLayout:			=	0x00FF0076		;Byte, 0 = Layout A, 1 = Layout B
MenuBarSelection:		=	0x00FF0077		;Byte, refer to UserInterface documentation for details
MenuBarOptionSelection:	=	0x00FF0078		;Byte, refer to UserInterface documentation for details
;==Screen Compositing===

ScreenBufferA:	=	0x00FF2E80		;These are 2,240 byte/1,120 word buffer. They are wiped clean each frame and is where the screen
ScreenBufferB:	=	0x00FF3740		;is composited to before being uploaded to the VDP during VBlank. Following this screen buffer
									;is the Pattern Arrays/Indices. Be careful when modifying these addresses.
;ScreenBufferA is for Plane A
;ScreenBufferB is for Plane B


