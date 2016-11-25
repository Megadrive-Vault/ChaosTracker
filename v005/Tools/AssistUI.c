#include <stdio.h>
#include <string.h>

//This quick application is meant to assist in implementing UI's in assembly for Chaos Tracker and the GBA derivative
//It's a complete hassle to manually calculate all the values needed by the Screen Management code most especially
//for label highlighting. Hence, "AssistUI". The output goes into an .asm file ready to be assembled by the assembler.
//We don't need anything fancy or advanced. For now we can simply define the panels and let the code do the rest.
//For now, all the required information can be hardcoded, but in the future I may consider creating a definition file
//that gives the program all the required information to create output, but since it's very low priority, it's doubtful.


//We need each panel's X, Y dimensions in tiles, it's intended X, Y positioning on screen, the RAM Buffer address to be used,
//the size of each tile in bytes, and names for all of the information.


	unsigned int ScreenBufferA;		//Location of the Screen Buffers in RAM
	unsigned int ScreenBufferB;		
	unsigned int TileSize;			//Sega Genesis/Megadrive uses a 2 byte word to inform the Video Display Processor what tile to use 

	char ASMLabel[] = "LabelHighlightLUT:";
	char LongDecl68k[] = "	.long	";		//This is for allocating longword space when spitting this data out to the .asm file
	
struct	Panels
{
	unsigned int PanelDim[2]; 		//Dimensions of the panel in tiles
	unsigned int PanelPos[2];		//Position of the Panel on screen

	
};
void	CreateTable( struct Panels *PanelMem );



//MAIN//

int		main()
{


//Width is used to determine label width, Height is used to determine number of labels. 
//Positions are used to calculate the offset using TileWidth to determine how much to multiply to get offset.
	struct	Panels File;
	File.PanelDim[1] = 0xA; 	//Width in tiles
	File.PanelDim[2] = 0x6; 	//Height in tiles
	File.PanelPos[1] = 0x1;		//X Coordinate in tiles
	File.PanelPos[2] = 0x2; 	//Y Coordinate in tiles

	struct	Panels Edit;
	Edit.PanelDim[1] = 0x9; 	//Width in tiles
	Edit.PanelDim[2] = 0x7; 	//Height in tiles
	Edit.PanelPos[1] = 0x6;		//X Coordinate in tiles
	Edit.PanelPos[2] = 0x2; 	//Y Coordinate in tiles

	struct 	Panels View;
	View.PanelDim[1] = 0x11;	//Width in tiles
	View.PanelDim[2] = 0x5; 	//Height in tiles
	View.PanelPos[1] = 0xB;		//X Coordinate in tiles
	View.PanelPos[2] = 0x2; 	//Y Coordinate in tiles

	struct	Panels Help;
	Help.PanelDim[1] = 0x9; 	//Width in tiles
	Help.PanelDim[2] = 0x4; 	//Height in tiles
	Help.PanelPos[1] = 0x1;		//X Coordinate in tiles
	Help.PanelPos[2] = 0x2; 	//Y Coordinate in tiles

	struct	Panels SubMenuPattern;
	SubMenuPattern.PanelDim[1] = 0xD; //Width in tiles
	SubMenuPattern.PanelDim[2] = 0x5; //Height in tiles
	SubMenuPattern.PanelPos[1] = 0xF;	//X Coordinate in tiles
	SubMenuPattern.PanelPos[2] = 0x2; //Y Coordinate in tiles

	struct	Panels SubMenuSelect;
	SubMenuSelect.PanelDim[1] = 0x5; //Width in tiles
	SubMenuSelect.PanelDim[2] = 0x2; //Height in tiles
	SubMenuSelect.PanelPos[1] = 0xF;	//X Coordinate in tiles
	SubMenuSelect.PanelPos[2] = 0x3; //Y Coordinate in tiles

	struct	Panels SubMenuInstruments;
	SubMenuInstruments.PanelDim[1] = 0x7; //Width in tiles
	SubMenuInstruments.PanelDim[2] = 0x5; //Height in tiles
	SubMenuInstruments.PanelPos[1] = 0x1C;	//X Coordinate in tiles
	SubMenuInstruments.PanelPos[2] = 0x4; //Y Coordinate in tiles


//Now we create the LUT and write it to an .asm file for each struct.
	CreateTable( &File );
	CreateTable( &Edit );
	CreateTable( &View );
	CreateTable( &Help );
	CreateTable( &SubMenuPattern );
	CreateTable( &SubMenuSelect );
	CreateTable( &SubMenuInstruments );

	return 0;
}

void	CreateTable( struct Panels *PanelMem )
{
	unsigned int	Width;
	unsigned int 	Height;
	unsigned int 	LabelOffset;
	unsigned int	LabelCount;
	unsigned int	X_Pos;
	unsigned int	Y_Pos;

	unsigned int	LabelDimensions;
	unsigned int	LabelPosition;

//Retrieve struct information and store into their own variables.

	Width = PanelMem->PanelDim[1];
	Height = PanelMem->PanelDim[2];
	X_Pos = PanelMem->PanelPos[1];
	Y_Pos = PanelMem->PanelPos[2];

//1) Multiply X Coord by 2h, Y Coord by 80h, then add those results together.
	LabelOffset = X_Pos * 0x2 + Y_Pos * 0x80;

//2) Take the Height in tiles and use that to control the iterations of our loop
	LabelCount = Height;
	
	Width = Width << 0x10;					//Shift width data into Upper Word
	LabelDimensions =	Width + 0x1;		//Now we have the width and height,height is always 1 no matter what.
	X_Pos = X_Pos << 0x10;					//The UI code expects longword data, with X in the upper word and Y in the lower word.

//3) Pass the X and Y Coords through to their own variable
	LabelPosition = X_Pos + Y_Pos;			//The X and Y coordinate data is now in the correct format

//Create or Open .asm file for writing the LUT's
	FILE *fp;
	fp = fopen("LabelHighlightLut.asm", "a");	
	
//Annnd this loop makes it all happen. We simply write all the data we've calculated into a format that our assembler
//will welcome with open arms.	
	while( LabelCount > 0 )
	{
			fprintf(fp, "%s%xh\n%s%xh\n%s%xh\n", LongDecl68k, LabelOffset, LongDecl68k, LabelDimensions, LongDecl68k, LabelPosition);
			LabelOffset = LabelOffset + 0x80;
			LabelPosition = LabelPosition + 0x1;
			LabelCount--;	
	}
	fclose(fp);




}
