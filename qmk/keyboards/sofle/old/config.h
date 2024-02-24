#pragma once

#define xxx KC_NO

#define layout_anti_miryoku(\
l00, l01, l02, l03, l04, l05,               r00, r01, r02, r03, r04, r05,  \
l10, l11, l12, l13, l14, l15,               r10, r11, r12, r13, r14, r15,  \
l20, l21, l22, l23, l24, l25,               r20, r21, r22, r23, r24, r25,  \
l35, l30, l31, l32, l33, l34,               r30, r31, r32, r33, r34, r35 \
)\
LAYOUT(\
xxx, xxx, xxx, xxx, xxx, xxx,               xxx, xxx, xxx, xxx, xxx, xxx,\
l00, l01, l02, l03, l04, l05,               r00, r01, r02, r03, r04, r05,  \
l10, l11, l12, l13, l14, l15,               r10, r11, r12, r13, r14, r15,  \
l20, l21, l22, l23, l24, l25, l35,     r35, r20, r21, r22, r23, r24, r25,  \
          l30, l31, l32, l33, l34,     r30, r31, r32, r33, r34 \
)



#ifdef RGBLIGHT_ENABLE
#define RGB_DI_PIN D3
#define RGBLIGHT_SPLIT
#define RGBLED_NUM 72  // Number of LEDs
#define RGBLED_SPLIT { 36, 36 } // haven't figured out how to use this yet 
/* #define DRIVER_LED_TOTAL 72 */
/* #define RGBLIGHT_ANIMATIONS */
#define RGBLIGHT_LIMIT_VAL 150
#define RGBLIGHT_HUE_STEP 10
#define RGBLIGHT_SAT_STEP 17
#define RGBLIGHT_VAL_STEP 17

//#define RGBLIGHT_EFFECT_STATIC_LIGHT
//#define RGBLIGHT_EFFECT_BREATHING
//#define RGBLIGHT_EFFECT_RAINBOW_MOOD
//#define RGBLIGHT_EFFECT_RAINBOW_SWIRL
// #define RGBLIGHT_DEFAULT_MODE RGBLIGHT_MODE_RAINBOW_SWIRL
#endif
