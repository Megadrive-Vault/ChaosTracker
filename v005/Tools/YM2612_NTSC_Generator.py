#This script generates the equal temperament chromatic scale into frequency
#values and converts them to YM2612 ready values, which are then written
#into a look up table to be read by the assembler. 

f = open('YM_NTSC.asm', 'w')

currentkey = 0 - 69
endofloweroctave = -37
maxkey = 59
NTSC_MClock = 7670453
PAL_MClock = 7600489
blockcounter = 0
while currentkey <= endofloweroctave:
    #Generates chromatic scale notes
    root = 1.0000000000/12
    twelthroot = 2.0000000000**root
    note = 440*(twelthroot)**currentkey
    #Converts to YM2612 values
    fnum = (144*note*2**20/NTSC_MClock)/2**blockcounter-1
    print int(round(fnum))
    s = str(int(round(fnum)))
    f.write('    DC.W ')
    f.write(s)
    f.write('\n')
    currentkey += 1

blockcounter -= 1
octblock = 0 - 2048
while blockcounter < 7:
    blockcounter += 1
    scaleposition = 0
    octblock += 2048
    while scaleposition < 12:
        #Generates chromatic scale notes
        root = 1.0000000000/12
        twelthroot = 2.0000000000**root
        note = 440*(twelthroot)**currentkey
        #Converts to YM2612 values
        fnum = (144*note*2**20/NTSC_MClock)/2**blockcounter-1
        fnum = fnum + octblock
        print int(round(fnum))
        s = str(int(round(fnum)))
        f.write('    DC.W ')
        f.write(s)
        f.write('\n')
        currentkey += 1
        scaleposition += 1
    