#include QMK_KEYBOARD_H

#define _ KC_NO

#define U_RDO C(KC_Y)
#define U_PST C(KC_V)
#define U_CPY C(KC_C)
#define U_CUT C(KC_X)
#define U_UND C(KC_Z)

enum layers {
    BASE,
    _H,
    MEDIA,
    NAV,
    MOUSE,
    SYM,
    SYM2,
    NUM,
    FUN 
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [BASE] = layout42(
    KC_TAB,  KC_Q,            KC_W,         KC_E,            KC_R,           LT(_H, KC_T),                KC_Y,            KC_U,             KC_I,           KC_O,           KC_P,             KC_LBRC,
    KC_LCTL, LGUI_T(KC_A),    LALT_T(KC_S), LCTL_T(KC_D),    LSFT_T(KC_F),   KC_G,                        KC_H,            LSFT_T(KC_J),     LCTL_T(KC_K),   LALT_T(KC_L),   LGUI_T(KC_SCLN),  KC_QUOT,
    KC_LSFT, LT(MOUSE, KC_Z), ALGR_T(KC_X), LT(MEDIA, KC_C), KC_V,           KC_B,                        KC_N,            LT(_H, KC_M),     KC_COMM,        ALGR_T(KC_DOT), LT(SYM2,KC_SLSH), KC_RSFT,
                                            LGUI_T(KC_ESC),  LALT_T(KC_SPC), LT(NAV, KC_TAB),             LT(SYM, KC_ENT), LT(NUM, KC_BSPC), LT(FUN, KC_DEL)
  ),

  [NAV] = layout42(
    QK_BOOT, _,       _,       _,       _,       _,                     RCS(KC_TAB), _,          _,        C(KC_TAB), _,      _, 
    KC_LCTL, KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, KC_APP,                KC_LEFT,     KC_DOWN,    KC_UP,    KC_RGHT,   _,      _,
    KC_LSFT, U_UND,   U_CUT,   U_CPY,   U_PST,   U_RDO,                 KC_HOME,     KC_PGDN,    KC_PGUP,  KC_END,    KC_INS, _,
                               _,       _,       _,                     KC_ENT,      C(KC_BSPC), C(KC_DEL)
  ),

  [MOUSE] = layout42(
    _, _,       _,       _,       _,       _,                     U_RDO,   U_PST,   U_CPY,   U_CUT,   U_UND, _,
    _, KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, KC_APP,                KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, _,     _,
    _, U_UND,   U_CUT,   U_CPY,   U_PST,   U_RDO,                 KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, _,     _,
                         _,       _,       _,                     KC_BTN1, KC_BTN3, KC_BTN2
  ),

  [MEDIA] = layout42(
    _,       RGB_M_P, _,       _,       _,       _,             _,       _,       _,       _,       _, RGB_TOG,
    _,       KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, _,             KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT, _, RGB_MOD,
    _,       _,       KC_ALGR, _,       _,       _,             _,       RGB_HUI, RGB_SAI, RGB_VAI, _, _,
                               _,       _,       _,             KC_MSTP, KC_MPLY, KC_MUTE
  ),

  [NUM] = layout42(
    _, _, KC_7, KC_8, KC_9, _,               _,      _,       _,       _,       _,       _,
    _, _, KC_4, KC_5, KC_6, KC_EQL,          KC_APP, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, _,
    _, _, KC_1, KC_2, KC_3, KC_PLUS,         _,      _,       _,       KC_ALGR, _,       _, 
                _,    KC_0, KC_MINS,         _,      _,       _
  ),

  [SYM] = layout42(
    _, KC_TILD, KC_AMPR, KC_ASTR, KC_LPRN, _,             _, _,       _,       _,       _,       QK_BOOT,
    _, KC_GRV,  KC_DLR,  KC_PERC, KC_CIRC, _,             _, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, _,
    _, _,       KC_EXLM, KC_AT,   KC_HASH, KC_BSLS,       _, _,       _,       KC_ALGR, _,       _,
                         _,       _,       KC_UNDS,       _, _,       _
  ),

  [SYM2] = layout42(
    _, _, _, KC_LBRC, KC_RBRC, _,                     _, _,       _,       _,       _,       _,
    _, _, _, KC_LPRN, KC_RPRN, _,                     _, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, _,
    _, _, _, KC_LCBR, KC_RCBR, _,                     _, _,       KC_ALGR, _,       _,       _,
             _,       _,       KC_UNDS,               _, _,       _
  ),

  [FUN] = layout42(
    _, KC_F12, KC_F7, KC_F8,  KC_F9,  KC_PSCR,               _, _,       _,       _,       _,       _,
    _, KC_F11, KC_F4, KC_F5,  KC_F6,  _,                     _, KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, _,
    _, KC_F10, KC_F1, KC_F2,  KC_F3,  KC_PAUS,               _, _,       _,       KC_ALGR, _,       _,
                      KC_ESC, KC_SPC, KC_TAB,                _, _,       _
  )
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode)
  {

  case LT(_H, KC_T):
    if (record->tap.count && record->event.pressed) {
      tap_code16(KC_T);
    } else if (record->event.pressed) {
      tap_code16(KC_GRV);
    }
    return false;

  case LT(_H, KC_M):
    if (record->tap.count && record->event.pressed) {
      tap_code16(KC_M);
    } else if (record->event.pressed) {
      tap_code16(KC_RBRC);
    }
    return false;

  }
  return true;
}
