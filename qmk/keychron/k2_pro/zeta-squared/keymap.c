/* Copyright 2022 @ Keychron (https://www.keychron.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

const int alpha_pins[]={32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 47, 48, 49, 50, 51, 52, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67};
const int alpha_pins_count=26;

// clang-format off
enum layers {
  MAC_BASE,
  MAC_FN,
  UNIX_BASE,
  UNIX_FN,
  WIN_BASE,
  WIN_FN,
  _RAISE,
  _LOWER,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[MAC_BASE] = LAYOUT_ansi_84(
     KC_ESC,			  KC_F1,   KC_F2,        KC_F3,        KC_F4,		 KC_F5, KC_F6, KC_F7,        KC_F8,        KC_F9,		 KC_F10,  KC_F11,     KC_F12,  KC_PSCR, KC_DEL,  _______,
     KC_GRV,              KC_1,	   KC_2,         KC_3,         KC_4,		 KC_5,  KC_6,  KC_7,         KC_8,         KC_9,	     KC_0,	  KC_MINS,	  KC_EQL,		    KC_BSPC, KC_HOME,
     KC_TAB,              KC_Q,	   KC_W,         KC_E,         KC_R,		 KC_T,  KC_Y,  KC_U,         KC_I,         KC_O,	     KC_P,	  KC_LBRC,    KC_RBRC,		    KC_BSLS,  KC_END,
     LT(_LOWER, KC_CAPS), KC_A,    LCTL_T(KC_S), LGUI_T(KC_D), LALT_T(KC_F), KC_G,  KC_H,  RALT_T(KC_J), RGUI_T(KC_K), RCTL_T(KC_L), KC_SCLN, KC_QUOT,						KC_ENT,  KC_PGUP,
     KC_LSFT,             KC_Z,	   KC_X,         KC_C,         KC_V,		 KC_B,  KC_N,  KC_M,		 KC_COMM,      KC_DOT,		 KC_SLSH, KC_RSFT,						KC_UP,	 KC_PGDN,
     KC_LCTL,             KC_LGUI, KC_LALT,									    KC_SPC,									             KC_RALT, MO(MAC_FN), KC_RCTL, KC_LEFT, KC_DOWN, KC_RGHT
	 ),
[MAC_FN] = LAYOUT_ansi_84(
     _______, KC_BRID, KC_BRIU, KC_MCTL, KC_SLEP, BL_DOWN, BL_UP,   KC_MPRV, KC_MPLY, KC_MNXT, KC_MUTE, KC_VOLD, KC_VOLU, _______, _______, BL_TOGG,
     _______, BT_HST1, BT_HST2, BT_HST3, _______, _______, _______, _______, _______, _______, _______, _______, _______,		   _______, BL_STEP,
     _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,		   _______, _______,
     _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,				   _______, _______,
     _______, _______, _______, _______, _______, BAT_LVL, NK_TOGG, _______, _______, _______, _______, _______,				   _______, _______,
     _______, _______, _______,                        _______,                                _______, _______, _______, _______, _______, _______
	 ),
[UNIX_BASE] = LAYOUT_ansi_84(
     KC_ESC,			  KC_F1,   KC_F2,        KC_F3,        KC_F4,		 KC_F5, KC_F6, KC_F7,        KC_F8,        KC_F9,		 KC_F10,  KC_F11,      KC_F12,  KC_PSCR, KC_DEL,  _______,
     KC_GRV,              KC_1,	   KC_2,         KC_3,         KC_4,		 KC_5,  KC_6,  KC_7,         KC_8,         KC_9,	     KC_0,	  KC_MINS,	   KC_EQL,		     KC_BSPC, KC_HOME,
     KC_TAB,              KC_Q,	   KC_W,         KC_E,         KC_R,		 KC_T,  KC_Y,  KC_U,         KC_I,         KC_O,	     KC_P,	  KC_LBRC,     KC_RBRC,		     KC_BSLS,  KC_END,
     LT(_RAISE, KC_CAPS), KC_A,    LCTL_T(KC_S), LGUI_T(KC_D), LALT_T(KC_F), KC_G,  KC_H,  RALT_T(KC_J), RGUI_T(KC_K), RCTL_T(KC_L), KC_SCLN, KC_QUOT,						 KC_ENT,  KC_PGUP,
     KC_LSFT,             KC_Z,	   KC_X,         KC_C,         KC_V,		 KC_B,  KC_N,  KC_M,		 KC_COMM,      KC_DOT,		 KC_SLSH, KC_RSFT,						 KC_UP,	  KC_PGDN,
     KC_LCTL,             KC_LGUI, KC_LALT,									    KC_SPC,									             KC_RALT, MO(UNIX_FN), KC_RCTL, KC_LEFT, KC_DOWN, KC_RGHT
	 ),
[UNIX_FN] = LAYOUT_ansi_84(
     _______,      KC_BRID, KC_BRIU, KC_MCTL, KC_SLEP, BL_DOWN, BL_UP,   KC_MPRV, KC_MPLY, KC_MNXT, KC_MUTE, KC_VOLD, KC_VOLU, _______, _______, BL_TOGG,
     _______,      BT_HST1, BT_HST2, BT_HST3, _______, _______, _______, _______, _______, _______, _______, _______, _______,		    _______, BL_STEP,
     _______,      _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,		    _______, _______,
     _______,      _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,				    _______, _______,
     _______,      _______, _______, _______, _______, BAT_LVL, NK_TOGG, _______, _______, _______, _______, _______,				    _______, _______,
     TG(WIN_BASE), _______, _______,                        _______,                                _______, _______, _______, _______, _______, _______
	 ),
[WIN_BASE] = LAYOUT_ansi_84(
     KC_ESC,			  KC_F1,   KC_F2,        KC_F3,        KC_F4,		 KC_F5, KC_F6, KC_F7,        KC_F8,        KC_F9,		 KC_F10,  KC_F11,     KC_F12,  KC_PSCR, KC_DEL,  _______,
     KC_GRV,              KC_1,	   KC_2,         KC_3,         KC_4,		 KC_5,  KC_6,  KC_7,         KC_8,         KC_9,	     KC_0,	  KC_MINS,	  KC_EQL,		    KC_BSPC, KC_HOME,
     KC_TAB,              KC_Q,	   KC_W,         KC_E,         KC_R,		 KC_T,  KC_Y,  KC_U,         KC_I,         KC_O,	     KC_P,	  KC_LBRC,    KC_RBRC,		    KC_BSLS,  KC_END,
     KC_CAPS,			  KC_A,    KC_S,		 KC_D,		   KC_F,		 KC_G,  KC_H,  KC_J,		 KC_K,		   KC_L,		 KC_SCLN, KC_QUOT,						KC_ENT,	 KC_PGUP,
     KC_LSFT,             KC_Z,	   KC_X,         KC_C,         KC_V,		 KC_B,  KC_N,  KC_M,		 KC_COMM,      KC_DOT,		 KC_SLSH, KC_RSFT,						KC_UP,	 KC_PGDN,
     KC_LCTL,             KC_LGUI, KC_LALT,									    KC_SPC,									             KC_RALT, MO(WIN_FN), KC_RCTL, KC_LEFT, KC_DOWN, KC_RGHT
	 ),
[WIN_FN] = LAYOUT_ansi_84(
     _______,       KC_BRID, KC_BRIU, KC_MCTL, KC_SLEP, BL_DOWN, BL_UP,   KC_MPRV, KC_MPLY, KC_MNXT, KC_MUTE, KC_VOLD, KC_VOLU, _______, _______, BL_TOGG,
     _______,       BT_HST1, BT_HST2, BT_HST3, _______, _______, _______, _______, _______, _______, _______, _______, _______,		     _______, BL_STEP,
     _______,       _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,		     _______, _______,
     _______,       _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,				     _______, _______,
     _______,       _______, _______, _______, _______, BAT_LVL, NK_TOGG, _______, _______, _______, _______, _______,				     _______, _______,
     TG(WIN_BASE),  _______, _______,                        _______,                                _______, _______, _______, _______, _______, _______
	 ),
[_RAISE] = LAYOUT_ansi_84(
     _______, KC_BRID, KC_BRIU,    KC_MCTL,    KC_SLEP,    BL_DOWN,    BL_UP,      KC_MPRV, KC_MPLY, KC_MNXT,    KC_MUTE,		KC_VOLD, KC_VOLU, _______, _______,    BL_TOGG,
     _______, KC_F1,   KC_F2,      KC_F3,      KC_F4,      KC_F5,	   KC_F6,	   KC_F7,	KC_F8,   KC_F9,      KC_F10,		KC_F11,  KC_F12,           _______,    BL_STEP,
     _______, _______, C(S(KC_9)), S(KC_LEFT), S(KC_RGHT), C(S(KC_T)), C(KC_LEFT), KC_PGDN, KC_PGUP, C(KC_RGHT), G(S(KC_PSCR)), _______, _______,          C(KC_RBRC), _______,
     _______, _______, _______,    C(KC_PGUP), C(KC_PGDN), _______,	   KC_LEFT,	   KC_DOWN, KC_UP,   KC_RGHT,    _______,		_______,				   _______,    _______,
     _______, _______, _______,    _______,    A(KC_LCTL), BAT_LVL,    _______,    KC_END,	KC_HOME, KC_DEL,     _______,		_______,				   _______,    _______,
     _______, _______, _______,                                  _______,                                        _______,		_______, _______, _______, _______,    _______
     ),
[_LOWER] = LAYOUT_ansi_84(
     _______, KC_BRID, KC_BRIU,    KC_MCTL,    KC_SLEP,    BL_DOWN,    BL_UP,      KC_MPRV, KC_MPLY, KC_MNXT,    KC_MUTE,	 KC_VOLD, KC_VOLU, _______, _______,    BL_TOGG,
     _______, KC_F1,   KC_F2,      KC_F3,      KC_F4,      KC_F5,	   KC_F6,	   KC_F7,	KC_F8,   KC_F9,      KC_F10,	 KC_F11,  KC_F12,           _______,    BL_STEP,
     _______, _______, C(S(KC_9)), S(KC_LEFT), S(KC_RGHT), C(S(KC_T)), A(KC_LEFT), KC_PGDN, KC_PGUP, A(KC_RGHT), G(S(KC_4)), _______, _______,          C(KC_RBRC), _______,
     _______, _______, _______,    C(KC_PGUP), C(KC_PGDN), _______,	   KC_LEFT,	   KC_DOWN, KC_UP,   KC_RGHT,    _______,	 _______,				    _______,    _______,
     _______, _______, _______,    _______,    A(KC_LCTL), BAT_LVL,    _______,    KC_END,	KC_HOME, KC_DEL,     _______,	 _______,				    _______,    _______,
     _______, _______, _______,                                  _______,                                        _______,	 _______, _______, _______, _______,    _______
     ),
};

bool led_update_user(led_t led_state) {
	static uint8_t caps_state = 0;

	if (caps_state != led_state.caps_lock) {
		led_matrix_is_enabled() ? led_matrix_disable() : led_matrix_enable();
	}

	caps_state = led_state.caps_lock;

	return true;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
	switch (keycode) {
		case BL_TOGG:
			if (record->event.pressed) {
				return host_keyboard_led_state().caps_lock ? false : true;
			}
			break;
	}
	return true;
}
