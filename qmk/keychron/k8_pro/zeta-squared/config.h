// Bootmagic lite
#ifdef BOOTMAGIC_LITE_ROW
	#undef BOOTMAGIC_LITE_ROW
	#define BOOTMAGIC_LITE_ROW 0
#endif

#ifdef BOOTMAGIC_LITE_COLUMN
	#undef BOOTMAGIC_LITE_COLUMN
	#define BOOTMAGIC_LITE_COLUMN 0
#endif

// Tap mod configuration
#define TAPPING_FORCE_HOLD
#define IGNORE_MOD_TAP_INTERRUPT
#define PERMISSIVE_HOLD
#ifdef TAPPING_TERM
	#undef TAPPING_TERM
	#define TAPPING_TERM 150
#endif
