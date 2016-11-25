;Menubar Parent Panel
MenuBarSpecs:
		DC.L	0x00000000	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x00260001	;X and Y dimensions  0026 x 0001
		DC.L	0x00010001	;Default X and Y placement on screen in tiles

;Menubar Parent Labels for "File Edit View Help"
;These are used to highlight the label when the user selects it

MenuBarFileLabel:
		DC.L	0x00000082	;Starting relative address of label in buffer RAM
		DC.L	0x00040001	;Label Dimensions
		DC.L	0x00010001	;Default X and Y placement on screen in tiles
MenuBarEditLabel:
		DC.L	0x0000008C	;Starting relative address of label in buffer RAM
		DC.L	0x00040001	;Label Dimensions
		DC.L	0x00060001	;Default X and Y placement on screen in tiles
MenuBarViewLabel:
		DC.L	0x00000096	;Starting relative address of label in buffer RAM
		DC.L	0x00040001	;Label Dimensions
		DC.L	0x000B0001	;Default X and Y placement on screen in tiles
MenuBarHelpLabel:
		DC.L	0x000000A0	;Starting relative address of label in buffer RAM
		DC.L	0x00040001	;Label Dimensions
		DC.L	0x00100001	;Default X and Y placement on screen in tiles

;Menubar Child Panels
MenuBarFileSpecs:
		DC.L	0x00000050	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x000A0006	;X and Y dimensions
		DC.L	0x00010002	;Default X and Y placement on screen in tiles
MenuBarEditSpecs:
		DC.L	0x00000064	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x00090007	;X and Y dimensions
		DC.L	0x00060002	;Default X and Y placement on screen in tiles
MenuBarViewSpecs:
		DC.L	0x00000076	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x00110005	;X and Y dimensions
		DC.L	0x000B0002	;Default X and Y placement on screen in tiles
MenuBarHelpSpecs:
		DC.L	0x00000280	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x00090004	;X and Y dimensions
		DC.L	0x00100002	;Default X and Y placement on screen in tiles
SubMenuPatternSpecs:
		DC.L	0x00000292	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x000D0005	;X and Y dimensions
		DC.L	0x000F0002	;Default X and Y placement on screen in tiles
SubMenuSelectSpecs:
		DC.L	0x000002BA	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x00050002	;X and Y dimensions
		DC.L	0x000F0003	;Default X and Y placement on screen in tiles
SubMenuInstrumentsSpecs:
		DC.L	0x000002AC	;Starting address relative to the starting ROM location of actual tilemap
		DC.L	0x00070005	;X and Y dimensions
		DC.L	0x001C0004	;Default X and Y placement on screen in tiles

;Menubar Child Labels for selections made that lead to a sub menu opening up.
MenuBarPatternLabel:
		DC.L	0x0000010C	;Starting relative address of label in buffer RAM
		DC.L	0x00090001	;Label Dimensions
		DC.L	0x00060002	;Default X and Y placement on screen in tiles
MenuBarSelectLabel:
		DC.L	0x0000018C	;Starting relative address of label in buffer RAM
		DC.L	0x00090001	;Label Dimensions
		DC.L	0x00060003	;Default X and Y placement on screen in tiles
MenuBarInstrumentsLabel:
		DC.L	0x00000216	;Starting relative address of label in buffer RAM
		DC.L	0x00110001	;Label Dimensions
		DC.L	0x000B0004	;Default X and Y placement on screen in tiles
