// Copyright 2022 Diego Palacios (@diepala)
// SPDX-License-Identifier: GPL-2.0

#include QMK_KEYBOARD_H

enum cantor_layers {
    _BASE,
    _LOWER,
    _RAISE,
    _NUMPAD,
    _ADJUST,
};

const key_override_t grave_key_override = ko_make_basic(MOD_MASK_GUI, KC_TAB, KC_TILDE);
const key_override_t tilde_key_override = ko_make_basic(MOD_MASK_CTRL, KC_TAB, KC_GRV);

const key_override_t **key_overrides = (const key_override_t *[]){
    &grave_key_override,
    &tilde_key_override,
    NULL,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
     /* BASE
      * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
      * │Tab│ Q │ W │ E │ R │ T │       │ Y │ U │ I │ O │ P │ \ │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │Esc│ A │ S │ D │ F │ G │       │ H │ J │ K │ L │ ; │ ' │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │Sft│ Z │ L │ C │ V │ B │       │ N │ M │ , │ . │ / │Sft│
      * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
      *               ┌───┐                   ┌───┐
      *               │Npd├───┐           ┌───┤Npd│
      *               └───┤Lwr├───┐   ┌───┤Spc├───┘
      *                   └───┤Ent│   │Bsp├───┘
      *                       └───┘   └───┘
      */
    [_BASE] = LAYOUT_split_3x6_3(
                    KC_TAB,  KC_Q,         KC_W,         KC_E,         KC_R, KC_T,       KC_Y,         KC_U,         KC_I,         KC_O,    KC_P,             KC_BSLS,
        LT(_RAISE, KC_ESC),  KC_A, LCTL_T(KC_S), LGUI_T(KC_D), LALT_T(KC_F), KC_G,       KC_H, RALT_T(KC_J), RGUI_T(KC_K), RCTL_T(KC_L), KC_SCLN, LT(_LOWER, KC_QUOT),
                   KC_LSFT,  KC_Z,         KC_X,         KC_C,         KC_V, KC_B,       KC_N,         KC_M,      KC_COMM,       KC_DOT, KC_SLSH,             KC_RSFT,
                                                    MO(_NUMPAD), MO(_LOWER), KC_ENT,   KC_BSPC, LT(_RAISE, KC_SPC), MO(_NUMPAD) 
    ),
     /* LOWER
      * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
      * │ ` │ 1 │ 2 │ 3 │ 4 │ 5 │       │ 6 │ 7 │ 8 │ 9 │ 0 │ \ │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │ ~ │ ! │ @ │ # │ $ │ % │       │ ^ │ & │ * │ ( │ ) │ - │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │   │ = │ + │ [ │ ] │   │       │ { │ } │ < │ > │ _ │ | │
      * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
      *               ┌───┐                   ┌───┐
      *               │Npd├───┐           ┌───┤Npd│
      *               └───┤Lwr├───┐   ┌───┤Spc├───┘
      *                   └───┤Ent│   │Bsp├───┘
      *                       └───┘   └───┘
     */
    [_LOWER] = LAYOUT_split_3x6_3(
          KC_GRV,     KC_1,    KC_2,    KC_3,    KC_4,    KC_5,              KC_6,    KC_7,    KC_8,    KC_9,    KC_0, _______,
        KC_TILDE,  KC_EXLM,   KC_AT, KC_HASH,  KC_DLR, KC_PERC,           KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_MINS,
         XXXXXXX,   KC_EQL, KC_PLUS, KC_LBRC, KC_RBRC, XXXXXXX,           KC_LCBR, KC_RCBR,   KC_LT,   KC_GT, KC_UNDS, KC_PIPE,
                                       _______, _______, _______,       _______, _______, _______
    ),
     /* RAISE
      * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
      * │Tab│Ins│Psc│Men│Gui│   │       │Pgu│Pwd│ Up│Nwd│DWd│   │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │Cap│Und│Cut│Cpy│Pst│   │       │Pgd│Lft│Dwn│Rgt│Del│Ent│
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │   │   │   │   │   │   │       │   │Hme│   │End│Lwr│   │
      * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
      *               ┌───┐                   ┌───┐
      *               │Npd├───┐           ┌───┤Npd│
      *               └───┤Lwr├───┐   ┌───┤Spc├───┘
      *                   └───┤Ent│   │Bsp├───┘
      *                       └───┘   └───┘
      */
    [_RAISE] = LAYOUT_split_3x6_3(
        _______,     KC_INS,    KC_PSCR,     KC_APP,    KC_LGUI, XXXXXXX,        KC_PGUP, LCTL(KC_LEFT),   KC_UP, LCTL(KC_RIGHT), LCTL(KC_BSPC), XXXXXXX,
        KC_CAPS, LCTL(KC_Z), LCTL(KC_X), LCTL(KC_C), LCTL(KC_V), XXXXXXX,        KC_PGDN,       KC_LEFT, KC_DOWN,        KC_RGHT,        KC_DEL,  KC_ENT,
        XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX,    XXXXXXX, XXXXXXX,        XXXXXXX,       KC_HOME, XXXXXXX,         KC_END,    MO(_LOWER), XXXXXXX,
                                                 _______, _______, _______,    _______, _______, _______
    ),
     /* NUMPAD
      * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
      * │Tab│F9 │F10│F11│F12│   │       │   │ 7 │ 8 │ 9 │ * │   │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │Esc│F5 │F6 │F7 │F8 │   │       │ . │ 4 │ 5 │ 6 │ + │ - │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │   │F1 │F2 │F3 │F4 │   │       │   │ 1 │ 2 │ 3 │ / │   │
      * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
      *               ┌───┐                   ┌───┐
      *               │Npd├───┐           ┌───┤ 0 │
      *               └───┤Lwr├───┐   ┌───┤Spc├───┘
      *                   └───┤Ent│   │Bsp├───┘
      *                       └───┘   └───┘
      */
    [_NUMPAD] = LAYOUT_split_3x6_3(
        _______,   KC_F9,  KC_F10,  KC_F11,  KC_F12, XXXXXXX,           XXXXXXX,    KC_7,    KC_8,    KC_9, KC_ASTR, XXXXXXX,
        _______,   KC_F5,   KC_F6,   KC_F7,   KC_F8, XXXXXXX,           KC_DOT,     KC_4,    KC_5,    KC_6, KC_PLUS, KC_MINS,
        XXXXXXX,   KC_F1,   KC_F2,   KC_F3,   KC_F4, XXXXXXX,           XXXXXXX,    KC_1,    KC_2,    KC_3, KC_SLSH, XXXXXXX,
                                     _______, _______, _______,       _______, _______,    KC_0
    ),
     /* ADJUST  
      * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
      * │   │   │   │   │   │   │       │   │   │   │   │   │   │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │   │   │   │   │   │   │       │   │VlD│Mte│VlU│   │   │
      * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
      * │   │   │   │   │   │   │       │   │Prv│Pse│Nxt│   │   │
      * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
      *               ┌───┐                   ┌───┐
      *               │Npd├───┐           ┌───┤Npd│
      *               └───┤Lwr├───┐   ┌───┤Spc├───┘
      *                   └───┤Ent│   │Bsp├───┘
      *                       └───┘   └───┘
      */
    [_ADJUST] = LAYOUT_split_3x6_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,           XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,           XXXXXXX, KC_VOLD, KC_MUTE, KC_VOLU, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,           XXXXXXX, KC_MPRV, KC_MPLY, KC_MNXT, XXXXXXX, XXXXXXX,
                                     _______, _______, _______,       _______, _______, _______
    ),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    return true;
};

layer_state_t layer_state_set_user(layer_state_t state) {
    return update_tri_layer_state(state, _LOWER, _RAISE, _ADJUST);
};
