#pragma once

/* The way how "handedness" is decided (which half is which),
see https://docs.qmk.fm/#/feature_split_keyboard?id=setting-handedness
for more options.
*/

#define USB_SUSPEND_WAKEUP_DELAY 3000

// Tap mod configuration
#define TAPPING_FORCE_HOLD
#define IGNORE_MOD_TAP_INTERRUPT
#define PERMISSIVE_HOLD
#ifdef TAPPING_TERM
	#undef TAPPING_TERM
	#define TAPPING_TERM 150
#endif

// Encoder configuration
#ifdef ENCODER_RESOLUTION
	#undef ENCODER_RESOLUTION
	#define ENCODER_RESOLUTION 4
#endif
