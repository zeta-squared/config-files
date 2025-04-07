#include QMK_KEYBOARD_H

enum sofle_layers {
    /* _M_XYZ = Mac Os, _W_XYZ = Win/Linux */
    _QWERTY,
    _GAME,
    _LOWER,
    _RAISE,
    _NUMPAD,
    _WoW,
    _ADJUST,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/*
 * QWERTY
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |  `   |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  |  -   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   Q  |   W  |   E  |   R  |   T  |                    |   Y  |   U  |   I  |   O  |   P  |  \   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Esc  |   A  |   S  |   D  |   F  |   G  |-------.    ,-------|   H  |   J  |   K  |   L  |   ;  |  '   |
 * |------+------+------+------+------+------| Play  |    | Mute  |------+------+------+------+------+------|
 * |LShift|   Z  |   X  |   C  |   V  |   B  |-------|    |-------|   N  |   M  |   ,  |   .  |   /  |RShift|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            | LCtl | LAlt | NPad |Lower | /Enter  /       \ Bspc \  |Space | Npad | RAlt | RCtl |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
[_QWERTY] = LAYOUT(
               KC_GRV,    KC_1,         KC_2,         KC_3,         KC_4,    KC_5,                              KC_6,         KC_7,         KC_8,         KC_9,    KC_0,               KC_MINS,
               KC_TAB,    KC_Q,         KC_W,         KC_E,         KC_R,    KC_T,                              KC_Y,         KC_U,         KC_I,         KC_O,    KC_P,               KC_BSLS,
   LT(_RAISE, KC_ESC),    KC_A, LCTL_T(KC_S), LGUI_T(KC_D), LALT_T(KC_F),    KC_G,                              KC_H, RALT_T(KC_J), RGUI_T(KC_K), RCTL_T(KC_L), KC_SCLN,   LT(_LOWER, KC_QUOT),
              KC_LSFT,    KC_Z,         KC_X,         KC_C,         KC_V,    KC_B, KC_MPLY,         KC_MUTE,    KC_N,         KC_M,      KC_COMM,       KC_DOT, KC_SLSH,               KC_RSFT,
                               KC_LCTL, KC_LALT, MO(_NUMPAD), MO(_LOWER), KC_ENT,     KC_BSPC, LT(_RAISE, KC_SPC), MO(_NUMPAD), KC_RALT, KC_RCTL
),
/*
 * GAME
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * | Esc  |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  | Snip |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   Q  |   W  |   E  |   R  |   T  |                    |   Y  |   U  |   I  |   O  |   P  |  \   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | LCtl |   A  |   S  |   D  |   F  |   G  |-------.    ,-------|   H  |   J  |   K  |   L  |   ;  |  '   |
 * |------+------+------+------+------+------|       |    | Mute  |------+------+------+------+------+------|
 * |LShift|   Z  |   X  |   C  |   V  |   B  |-------|    |-------|   N  |   M  |   ,  |   .  |   /  |RShift|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            |Lower |  WoW | LAlt |Space | /Enter  /       \ Bspc \  |Space | Npad | RAlt | RCtl |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
[_GAME] = LAYOUT(
  QK_GESC, _______, _______, _______, _______, _______,                              _______, _______, _______, _______, _______, RSG(KC_S),
  _______, _______, _______, _______, _______, _______,                              _______, _______, _______, _______, _______,   _______,
  KC_LCTL, _______,    KC_S,    KC_D,    KC_F, _______,                              _______, _______, _______, _______, _______,   _______,
  _______, _______, _______, _______, _______, _______, _______,            _______, _______, _______, _______, _______, _______,   _______,
                    MO(_LOWER), MO(_WoW), KC_LALT, KC_SPC, KC_ENT,        _______, _______, _______, _______, _______
),
/* LOWER
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |  `   |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  |   -  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |  ~   |   !  |   @  |   #  |   $  |   %  |                    |   ^  |   &  |   *  |   (  |   )  |   \  |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Esc  |      |      |      |      |      |-------.    ,-------|   [  |   ]  |   =  |   +  |   ;  |   '  |
 * |------+------+------+------+------+------|       |    | Mute  |------+------+------+------+------+------|
 * |LShift|      |      |      |      |      |-------|    |-------|   {  |   }  |   ,  |   .  |   /  |RShift|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            | LCtl | LAlt | NPad |Lower | /Enter  /       \ Bspc \  |Space | NPad | RAlt | RCtl |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
[_LOWER] = LAYOUT(
  _______, _______, _______, _______, _______, _______,                             _______, _______, _______, _______, _______, _______,
  _______, KC_EXLM,   KC_AT, KC_HASH,  KC_DLR, KC_PERC,                             KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, _______, 
  _______, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                             KC_LBRC, KC_RBRC,  KC_EQL, KC_PLUS, _______, _______,
  _______, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,           _______, KC_LCBR, KC_RCBR, _______, _______, _______, _______,
                      _______, _______, _______, _______, _______,       _______, _______, _______, _______, _______
),
/* RAISE
 * ,----------------------------------------.                    ,-----------------------------------------.
 * |      |  1   |  2   |  3   |  4   |  5   |                    |   6  |   7  |   8  |   9  |   0  | Snip |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  | Ins  | Pscr | Menu | LGui |      |                    | Pgup | PWrd |  Up  | NWrd | DWord|      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Caps | Undo | Cut  | Copy | Paste|      |-------.    ,-------| Pgdn | Left | Down | Right|  Del |Enter |
 * |------+------+------+------+------+------|       |    | Mute  |------+------+------+------+------+------|
 * |      |      |      |      |      |      |-------|    |-------|      | Home |      |  End |Lower |      |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            | LCtl | LAlt | NPad |Lower | /Enter  /       \Space \  |Raise | NPad | RAlt | RCtl |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
[_RAISE] = LAYOUT(
  XXXXXXX,    _______,    _______,    _______,    _______, _______,                               _______,       _______, _______,        _______,       _______, XXXXXXX,
  _______,     KC_INS,    KC_PSCR,     KC_APP,    KC_LGUI, XXXXXXX,                               KC_PGUP, LCTL(KC_LEFT),   KC_UP, LCTL(KC_RIGHT), LCTL(KC_BSPC), XXXXXXX,
  KC_CAPS, LCTL(KC_Z), LCTL(KC_X), LCTL(KC_C), LCTL(KC_V), XXXXXXX,                               KC_PGDN,       KC_LEFT, KC_DOWN,        KC_RGHT,        KC_DEL,  KC_ENT,
  XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX, XXXXXXX,  _______,           _______,  XXXXXXX,       KC_HOME, XXXXXXX,         KC_END,    MO(_LOWER), XXXXXXX,
                                   _______, _______, _______, _______, _______,       _______, _______, _______, _______, _______
),
/* NUMPAD
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |      |      |      |      |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |  F9  |  F10 |  F11 |  F12 |      |                    |      |   7  |   8  |   9  |   *  |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Esc  |  F5  |  F6  |  F7  |  F8  |      |-------.    ,-------|      |   4  |   5  |   6  |   +  |   -  |
 * |------+------+------+------+------+------|       |    | Mute  |------+------+------+------+------+------|
 * |      |  F1  |  F2  |  F3  |  F4  |      |-------|    |-------|      |   1  |   2  |   3  |   /  |      |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            | LCtl | LAlt | NPad |Lower | /Enter  /       \ Bspc \  |Space |   0  |   .  | RCtl |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
[_NUMPAD] = LAYOUT(
  XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                              XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  _______,   KC_F9,  KC_F10,  KC_F11,  KC_F12, XXXXXXX,                              XXXXXXX,    KC_7,    KC_8,    KC_9, KC_ASTR, XXXXXXX,
  _______,   KC_F5,   KC_F6,   KC_F7,   KC_F8, XXXXXXX,                              XXXXXXX,    KC_4,    KC_5,    KC_6, KC_PLUS, KC_MINS,
  XXXXXXX,   KC_F1,   KC_F2,   KC_F3,   KC_F4, XXXXXXX, XXXXXXX,            _______, XXXXXXX,    KC_1,    KC_2,    KC_3, KC_SLSH, XXXXXXX,
                      _______, _______, _______, _______, _______,        _______, _______,    KC_0,  KC_DOT, _______
),
/*
 * WoW
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |  `   |  F1  |  F2  |  F3  |  F4  |  F5  |                    |   6  |   7  |   8  |   9  |   0  | Snip |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | Tab  |   L  |   W  |   M  |   I  |   H  |                    |   Y  |   U  |   I  |   O  |   P  |  \   |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | LCtl |   A  |   Y  |   D  |   O  |   G  |-------.    ,-------|   H  |   J  |   K  |   L  |   ;  |  '   |
 * |------+------+------+------+------+------|       |    | Mute  |------+------+------+------+------+------|
 * |LShift|   P  |   K  |   N  |   U  |   B  |-------|    |-------|   N  |   M  |   ,  |   .  |   /  |RShift|
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            |Lower |  WoW | LAlt |Space | /Enter  /       \ Bspc \  |Space | Npad | RAlt | RCtl |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
[_WoW] = LAYOUT(
   KC_GRV,   KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                              _______, _______, _______, _______, _______, _______,
  _______,    KC_L, _______,    KC_M,    KC_I,    KC_H,                              _______, _______, _______, _______, _______, _______,
  _______, _______,    KC_Y, _______,    KC_O, _______,                              _______, _______, _______, _______, _______, _______,
  _______,    KC_P,    KC_K,    KC_N,    KC_U, _______, _______,            _______, _______, _______, _______, _______, _______, _______,
                      _______, _______, _______, _______, _______,        _______, _______, _______, _______, _______
),
/* ADJUST
 * ,-----------------------------------------.                    ,-----------------------------------------.
 * |      |      |      |      |      |      |                    |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * | QK_BOOT|      |QWERTY|GAME|      |      |                    |      |      |      |      |      |      |
 * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
 * |      |      |MACWIN|      |      |      |-------.    ,-------|      | VolD | Mute | VolU |      |      |
 * |------+------+------+------+------+------|       |    | Mute  |------+------+------+------+------+------|
 * |      |      |      |      |      |      |-------|    |-------|      | Prev | Play | Next |      |      |
 * `-----------------------------------------/       /     \      \-----------------------------------------'
 *            | LCtl | LAlt | NPad |Lower | /Enter  /       \ Bspc \  |Space | NPad | RAlt | RCtl |
 *            |      |      |      |      |/       /         \      \ |      |      |      |      |
 *            `----------------------------------'           '------''---------------------------'
 */
  [_ADJUST] = LAYOUT(
  XXXXXXX, XXXXXXX,     XXXXXXX,   XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  QK_BOOT, XXXXXXX, DF(_QWERTY), DF(_GAME), XXXXXXX, XXXXXXX,                            XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX,     CG_TOGG,   XXXXXXX, XXXXXXX, XXXXXXX,                            XXXXXXX, KC_VOLD, KC_MUTE, KC_VOLU, XXXXXXX, XXXXXXX,
  XXXXXXX, XXXXXXX,     XXXXXXX,   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,          XXXXXXX, XXXXXXX, KC_MPRV, KC_MPLY, KC_MNXT, XXXXXXX, XXXXXXX,
                            _______, _______, _______, _______, _______,      _______, _______, _______, _______, _______
  )
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    return true;
};

layer_state_t layer_state_set_user(layer_state_t state) {
    return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
};

#ifdef OLED_ENABLE

static void render_logo(void) {
    static const char PROGMEM qmk_logo[] = {
        0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8a,0x8b,0x8c,0x8d,0x8e,0x8f,0x90,0x91,0x92,0x93,0x94,
        0xa0,0xa1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7,0xa8,0xa9,0xaa,0xab,0xac,0xad,0xae,0xaf,0xb0,0xb1,0xb2,0xb3,0xb4,
        0xc0,0xc1,0xc2,0xc3,0xc4,0xc5,0xc6,0xc7,0xc8,0xc9,0xca,0xcb,0xcc,0xcd,0xce,0xcf,0xd0,0xd1,0xd2,0xd3,0xd4,0
    };

    oled_write_P(qmk_logo, false);
};

static void print_status_narrow(void) {
    // Print current mode
    oled_write_P(PSTR("\n\n"), false);
    oled_write_ln_P(PSTR("MODE"), false);
    oled_write_ln_P(PSTR(""), false);
    if (keymap_config.swap_lctl_lgui) {
        oled_write_ln_P(PSTR("MAC"), false);
    } else {
        oled_write_ln_P(PSTR("Linux"), false);
    }

    switch (get_highest_layer(default_layer_state)) {
        case _QWERTY:
            oled_write_ln_P(PSTR("Qwrt"), false);
            break;
        case _GAME:
            oled_write_P(PSTR("GAME\n"), false);
            break;
        default:
            oled_write_P(PSTR("Undef"), false);
    }
    oled_write_P(PSTR("\n\n"), false);
    // Print current layer
    oled_write_ln_P(PSTR("LAYER"), false);
    switch (get_highest_layer(layer_state)) {
        case _QWERTY:
            oled_write_P(PSTR("Base\n"), false);
            break;
        case _RAISE:
            oled_write_P(PSTR("Raise"), false);
            break;
        case _LOWER:
            oled_write_P(PSTR("Lower"), false);
            break;
        case _NUMPAD:
            oled_write_P(PSTR("Npad\n"), false);
            break;
        case _WoW:
            oled_write_P(PSTR("WoW\n"), false);
            break;
        case _ADJUST:
            oled_write_P(PSTR("Adj\n"), false);
            break;
        default:
            oled_write_ln_P(PSTR("Undef"), false);
    }
    oled_write_P(PSTR("\n\n"), false);
    led_t led_usb_state = host_keyboard_led_state();
    oled_write_ln_P(PSTR("CPSLK"), led_usb_state.caps_lock);
};

oled_rotation_t oled_init_user(oled_rotation_t rotation) {
    if (is_keyboard_master()) {
        return OLED_ROTATION_270;
    }
    return rotation;
};

bool oled_task_user(void) {
    if (is_keyboard_master()) {
        print_status_narrow();
    } else {
        render_logo();
    }
    return false;
};

#endif

#ifdef ENCODER_ENABLE

bool encoder_update_user(uint8_t index, bool clockwise) {
    if (index == 0) {
        if (clockwise) {
            tap_code(KC_MNXT);
        } else {
            tap_code(KC_MPRV);
        }
    } else if (index == 1) {
        if (clockwise) {
            tap_code(KC_VOLU);
        } else {
            tap_code(KC_VOLD);
        }
    }
    return true;
};

#endif
