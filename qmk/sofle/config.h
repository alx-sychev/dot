#pragma once

#undef TAPPING_TERM
#define TAPPING_TERM 260

// Enable rapid switch from tap to hold, disables double tap hold auto-repeat.
#define TAPPING_FORCE_HOLD

// Auto Shift
#define NO_AUTO_SHIFT_ALPHA
#define AUTO_SHIFT_TIMEOUT TAPPING_TERM
#define AUTO_SHIFT_NO_SETUP

// Recommended for heavy chording.
#define QMK_KEYS_PER_SCAN 4

// prepare layout
#define xxx KC_NO
#define layout42(\
l00, l01, l02, l03, l04, l05,               r00, r01, r02, r03, r04, r05,  \
l10, l11, l12, l13, l14, l15,               r10, r11, r12, r13, r14, r15,  \
l20, l21, l22, l23, l24, l25,               r20, r21, r22, r23, r24, r25,  \
               l30, l31, l32,               r30, r31, r32  \
)\
LAYOUT(\
xxx, xxx, xxx, xxx, xxx, xxx,               xxx, xxx, xxx, xxx, xxx, xxx,\
l00, l01, l02, l03, l04, l05,               r00, r01, r02, r03, r04, r05,  \
l10, l11, l12, l13, l14, l15,               r10, r11, r12, r13, r14, r15,  \
l20, l21, l22, l23, l24, l25, xxx,     xxx, r20, r21, r22, r23, r24, r25,  \
          xxx, xxx, l30, l31, l32,     r30, r31, r32, xxx, xxx \
)

#ifdef MOUSEKEY_ENABLE 
#include "mouse.h"
#endif

#ifdef RGBLIGHT_ENABLE
#include "rgb.h"
#endif
