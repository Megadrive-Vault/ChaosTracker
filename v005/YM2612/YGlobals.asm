;Here we go, a long list of YM2612 global defines.
;First we have our ports to write addresses to and r/w data

YM2612_Control_Port1:   = 0xa04000
YM2612_Control_Port2:   = 0xa04002
YM2612_Data_Port1:      = 0xa04001
YM2612_Data_Port2:      = 0xa04003

;Here's the registers that are more global in nature

YM2612_LFO:                 = 0x22
YM2612_Timer_A_MSB:         = 0x24
YM2612_Timer_A_LSB:         = 0x25
YM2612_Timer_B:             = 0x26
YM2612_Timers_Ch36_Mode:    = 0x27
YM2612_Key_On_Off:          = 0x28
YM2612_DAC:                 = 0x2a
YM2612_DAC_Enable:          = 0x2b

;FM synth registers. To make things easier, both Part 1 and Part 2 registers are all going to be condensed into 
;one section. A register that works with channels 1, 2 and 3 will also work with channels 4, 5, and 6 depending 
;on wether Control and Data ports 1 or 2 are being written too. See YM2612 documentation for further clarification.
;Note- So I messed up the order of the registers while typing them out, I'll want to fix that soon.

;Register name      | Actual | bits  | Actual | bits
;Detune and Multiple| DT1    | b6-b4 | MUL    | b3-b0

YM2612_Ch1_Ch4_Op1_Det_Mult: = 0x30
YM2612_Ch2_Ch5_Op1_Det_Mult: = 0x31
YM2612_Ch3_Ch6_Op1_Det_Mult: = 0x32

YM2612_Ch1_Ch4_Op2_Det_Mult: = 0x34
YM2612_Ch2_Ch5_Op2_Det_Mult: = 0x35
YM2612_Ch3_Ch6_Op2_Det_Mult: = 0x36

YM2612_Ch1_Ch4_Op3_Det_Mult: = 0x38
YM2612_Ch2_Ch5_Op3_Det_Mult: = 0x39
YM2612_Ch3_Ch6_Op3_Det_Mult: = 0x3a

YM2612_Ch1_Ch4_Op4_Det_Mult: = 0x3c
YM2612_Ch2_Ch5_Op4_Det_Mult: = 0x3d
YM2612_Ch3_Ch6_Op4_Det_Mult: = 0x3e

;Register name      | Actual | bits
;Total Level        | TL     | b6-b0

YM2612_Ch1_Ch4_Op1_TotalLevel: = 0x40
YM2612_Ch2_Ch5_Op1_TotalLevel: = 0x41
YM2612_Ch3_Ch6_Op1_TotalLevel: = 0x42

YM2612_Ch1_Ch4_Op2_TotalLevel: = 0x44
YM2612_Ch2_Ch5_Op2_TotalLevel: = 0x45
YM2612_Ch3_Ch6_Op2_TotalLevel: = 0x46

YM2612_Ch1_Ch4_Op3_TotalLevel: = 0x48
YM2612_Ch2_Ch5_Op3_TotalLevel: = 0x49
YM2612_Ch3_Ch6_Op3_TotalLevel: = 0x4a

YM2612_Ch1_Ch4_Op4_TotalLevel: = 0x4c
YM2612_Ch2_Ch5_Op4_TotalLevel: = 0x4d
YM2612_Ch3_Ch6_Op4_TotalLevel: = 0x4e

;Register name            | Actual | bits  | Actual | bits
;Rate Scaling Attack Rate | RS     | b7-b6 | AR     | b4-b0

YM2612_Ch1_Ch4_Op1_RateScaling_AttackRate: = 0x50
YM2612_Ch2_Ch5_Op1_RateScaling_AttackRate: = 0x51
YM2612_Ch3_Ch6_Op1_RateScaling_AttackRate: = 0x52

YM2612_Ch1_Ch4_Op2_RateScaling_AttackRate: = 0x54
YM2612_Ch2_Ch5_Op2_RateScaling_AttackRate: = 0x55
YM2612_Ch3_Ch6_Op2_RateScaling_AttackRate: = 0x56

YM2612_Ch1_Ch4_Op3_RateScaling_AttackRate: = 0x58
YM2612_Ch2_Ch5_Op3_RateScaling_AttackRate: = 0x59
YM2612_Ch3_Ch6_Op3_RateScaling_AttackRate: = 0x5a

YM2612_Ch1_Ch4_Op4_RateScaling_AttackRate: = 0x5c
YM2612_Ch2_Ch5_Op4_RateScaling_AttackRate: = 0x5d
YM2612_Ch3_Ch6_Op4_RateScaling_AttackRate: = 0x5e

;Register name            | Actual | bits  | Actual | bits
;First Decay Rate Amp Mod | AM     | b7    | D1R    | b4-b0 

YM2612_Ch1_Ch4_Op1_Decay1_AmpMod: = 0x60
YM2612_Ch2_Ch5_Op1_Decay1_AmpMod: = 0x61
YM2612_Ch3_Ch6_Op1_Decay1_AmpMod: = 0x62

YM2612_Ch1_Ch4_Op2_Decay1_AmpMod: = 0x64
YM2612_Ch2_Ch5_Op2_Decay1_AmpMod: = 0x65
YM2612_Ch3_Ch6_Op2_Decay1_AmpMod: = 0x66

YM2612_Ch1_Ch4_Op3_Decay1_AmpMod: = 0x68
YM2612_Ch2_Ch5_Op3_Decay1_AmpMod: = 0x69
YM2612_Ch3_Ch6_Op3_Decay1_AmpMod: = 0x6a

YM2612_Ch1_Ch4_Op4_Decay1_AmpMod: = 0x6c
YM2612_Ch2_Ch5_Op4_Decay1_AmpMod: = 0x6d
YM2612_Ch3_Ch6_Op4_Decay1_AmpMod: = 0x6e

;Register name            | Actual | bits  
;Secondary Decay Rate     | D2R    | b4-b0

YM2612_Ch1_Ch4_Op1_Decay2: = 0x70
YM2612_Ch2_Ch5_Op1_Decay2: = 0x71
YM2612_Ch3_Ch6_Op1_Decay2: = 0x72

YM2612_Ch1_Ch4_Op2_Decay2: = 0x74
YM2612_Ch2_Ch5_Op2_Decay2: = 0x75
YM2612_Ch3_Ch6_Op2_Decay2: = 0x76

YM2612_Ch1_Ch4_Op3_Decay2: = 0x78
YM2612_Ch2_Ch5_Op3_Decay2: = 0x79
YM2612_Ch3_Ch6_Op3_Decay2: = 0x7a

YM2612_Ch1_Ch4_Op4_Decay2: = 0x7c
YM2612_Ch2_Ch5_Op4_Decay2: = 0x7d
YM2612_Ch3_Ch6_Op4_Decay2: = 0x7e

;Register name            | Actual | bits  | Actual | bits
;Decay Level Release Rate | D1L    | b7-b4 | RR     | b3-b0

YM2612_Ch1_Ch4_Op1_DecayLevel_RelRate: = 0x80
YM2612_Ch2_Ch5_Op1_DecayLevel_RelRate: = 0x81
YM2612_Ch3_Ch6_Op1_DecayLevel_RelRate: = 0x82

YM2612_Ch1_Ch4_Op2_DecayLevel_RelRate: = 0x84
YM2612_Ch2_Ch5_Op2_DecayLevel_RelRate: = 0x85
YM2612_Ch3_Ch6_Op2_DecayLevel_RelRate: = 0x86

YM2612_Ch1_Ch4_Op3_DecayLevel_RelRate: = 0x88
YM2612_Ch2_Ch5_Op3_DecayLevel_RelRate: = 0x89
YM2612_Ch3_Ch6_Op3_DecayLevel_RelRate: = 0x8a

YM2612_Ch1_Ch4_Op4_DecayLevel_RelRate: = 0x8c
YM2612_Ch2_Ch5_Op4_DecayLevel_RelRate: = 0x8d
YM2612_Ch3_Ch6_Op4_DecayLevel_RelRate: = 0x8e

;Register name            | Actual | bits
;SSG-EG                   | SSG-EG | b3-b0

YM2612_Ch1_Ch4_Op1_SSGEG: = 0x90
YM2612_Ch2_Ch5_Op1_SSGEG: = 0x91
YM2612_Ch3_Ch6_Op1_SSGEG: = 0x92

YM2612_Ch1_Ch4_Op2_SSGEG: = 0x94
YM2612_Ch2_Ch5_Op2_SSGEG: = 0x95
YM2612_Ch3_Ch6_Op2_SSGEG: = 0x96

YM2612_Ch1_Ch4_Op3_SSGEG: = 0x98
YM2612_Ch2_Ch5_Op3_SSGEG: = 0x99
YM2612_Ch3_Ch6_Op3_SSGEG: = 0x9a

YM2612_Ch1_Ch4_Op4_SSGEG: = 0x9c
YM2612_Ch2_Ch5_Op4_SSGEG: = 0x9d
YM2612_Ch3_Ch6_Op4_SSGEG: = 0x9e

;Almost there... These registers mostly relate to the whole channel as opposed to the channels and operators.

;Register name            | Actual  | bits
;Frequency LSB            | FreqLSB | b7-b0

YM2612_Ch1_Ch4_FreqLSB: = 0xa0
YM2612_Ch2_Ch5_FreqLSB: = 0xa1
YM2612_Ch3_Ch6_FreqLSB: = 0xa2

;Register name              | Actual | bits  | Actual  | bits
;Frequency MSB Octave Block | Block  | b5-b3 | FreqMSB | b2-b0

YM2612_Ch1_Ch4_Octave_FreqMSB: = 0xa4
YM2612_Ch2_Ch5_Octave_FreqMSB: = 0xa5
YM2612_Ch3_Ch6_Octave_FreqMSB: = 0xa6

;Register name                             | Actual  | bits
;Channel 3 Supplement Frequency Number LSB | FreqLSB | b7-b0

YM2612_Ch3_Mode_Op2_FrequencyLSB: = 0xa8
YM2612_Ch3_Mode_Op3_FrequencyLSB: = 0xa9
YM2612_Ch3_Mode_Op4_FrequencyLSB: = 0xaa

;Register name                               | Actual  | bits  | Actual  | bits
;Ch3 Suppl. Octave Block Ch3 Suppl. Freq MSB | Block   | b5-b3 | FreqMSB | b2-b0

YM2612_Ch3_Mode_Op2_Octave_FrequencyMSB: = 0xac
YM2612_Ch3_Mode_Op3_Octave_FrequencyMSB: = 0xad
YM2612_Ch3_Mode_Op4_Octave_FrequencyMSB: = 0xae

;Register name      | Actual   | bits  | Actual    | bits
;Feedback Algorithm | Feedback | b5-b3 | Algorithm | b2-b0

YM2612_Ch1_Ch4_Feedback_Algo: = 0xb0
YM2612_Ch2_Ch5_Feedback_Algo: = 0xb1
YM2612_Ch3_Ch6_Feedback_Algo: = 0xb2

;Register name          | Actual | bits | Actual | bits | Actual | bits  | Actual | bits
;Stereo LFO Sensitivity | L      | b7   | R      | b6   | AMS    | b5-b3 | FMS    | b1-b0

YM2612_Ch1_Ch4_Stereo_LFO_Sens: = 0xb4
YM2612_Ch2_Ch5_Stereo_LFO_Sens: = 0xb5
YM2612_Ch3_Ch6_Stereo_LFO_Sens: = 0xb6
