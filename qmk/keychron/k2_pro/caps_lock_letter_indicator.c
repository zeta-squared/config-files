// Add this to the appropriate sections of bluetooth/indicators.c to have letter keys illuminate on k2 pro
// when caps lock is active.

const uint8_t not_letter_pins[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
									25, 26, 27, 28, 29, 30, 31, 42, 43, 44, 45, 46, 56, 57, 58, 59, 60, 68, 69, 70, 71, 72,
									73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83};
const int not_letter_pins_count = 58;

bool led_matrix_indicators_kb(void) {
	if (!bat_level_animiation_actived() && host_keyboard_led_state().caps_lock) {
		for (int i = 0; i < not_letter_pins_count; i++)
			led_matrix_set_value(not_letter_pins[i], 0);
	}
}
