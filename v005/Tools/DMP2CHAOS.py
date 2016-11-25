#Converts Deflemask FM patches to
#asm source for assembly
import binascii
import os, sys
path = os.path.dirname(os.path.abspath(sys.argv[0]))

def filewrite(printval):
    asm.write('    DC.B ')
    asm.write(hex(printval))
    asm.write('\n')
    return 0



dmpname=raw_input('Enter name of .dmp preset ')



dmp = open(dmpname, 'rb')
patchname = dmpname[:-4]
asm = open(patchname + '.asm', 'w')

if str.endswith(dmpname, '.dmp'):
    print 'DefleMask Patch'
else:
    print 'Unsupported format'
    exit()
print patchname
dirs = os.listdir(path)

#Skip first two bytes, read rest of preset
dmp.seek(2, 0)
preset = bytearray(dmp.read())
lfo = preset[0]
fb = preset[1]
alg = preset[2]
lfo2 = preset[3]
lfo2 = lfo2 << 3
lfo2 = lfo2 + lfo
filewrite(lfo2)

fb = fb <<3
fb = fb + alg
filewrite(fb)

#DT/MUL
loopc = 4
cb = 4

while loopc > 0:
    mul = preset[cb]
    cb += 8
    dt = preset[cb]
    dt = dt << 4
    mul = dt +mul
    filewrite(mul)
    cb += 3
    loopc -= 1

#TL
loopc = 4
cb = 5

while loopc > 0:
    tl = preset[cb]
    cb += 11
    filewrite(tl)
    loopc -= 1

#AR/RS
loopc = 4
cb = 6

while loopc > 0:
    ar = preset[cb]
    cb += 5
    rs = preset[cb]
    rs = rs << 6
    ar = ar + rs
    filewrite(ar)
    cb += 6
    loopc -= 1

#D1R/AM
loopc = 4
cb = 7

while loopc > 0:
    dr = preset[cb]
    cb += 3
    am = preset[cb]
    am = am << 7
    dr = dr + am
    filewrite(dr)
    cb += 8
    loopc -= 1

#D2R
loopc = 4
cb = 13

while loopc > 0:
    d2r = preset[cb]
    cb += 11
    filewrite(d2r)
    loopc -= 1

#SL
loopc = 4
cb = 8

while loopc > 0:
    sl = preset[cb]
    cb += 1
    rr = preset[cb]
    sl = sl << 4
    sl = sl + rr
    cb += 10
    filewrite(sl)
    loopc -= 1

#SSG-EG
loopc = 4
cb = 14

while loopc > 0:
    ssg = preset[cb]
    cb += 11
    filewrite(ssg)
    loopc -= 1
#need to take the name of the preset and add it to the outputted .asm file
namelength = len(patchname)

#we take the name of the patch and make sure it is exactly 8 bytes, stripping extra chars or adding padding spaces
if namelength > 8:
    excess = namelength - 8
    patchname = patchname[:-excess]
elif namelength < 8:
    shortage = 8
    shortage = shortage - namelength
    while shortage > 0:
        patchname = patchname + ' '
        shortage = shortage - 1
print patchname

#write to file
asm.write('    DC.B "' + patchname + '"')
