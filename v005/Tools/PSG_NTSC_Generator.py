#This script calculates and generates frequency lookup tables for both ntsc and pal PSG
f = open('PSGNTSC.asm', 'w')

currentkey = 0-69
maxkey = 59
NTSCmclock = 3579545
PALmclock = 3546893
while currentkey < maxkey:
    root = 1.0000000000/12
    twelthroot = 2.0000000000**root
    note = 440*(twelthroot)**currentkey
    fnum = NTSCmclock / (note * 32)
    s = str(int(fnum))
    currentkey += 1
    f.write('    DC.W ')
    f.write(s)
    f.write('\n')