module cef_base;

import cef;

import core.stdc.stdio;
import core.stdc.stdlib;

extern(C) {
	void add_ref(cef_base_ref_counted_t* self) @nogc nothrow {
		// DEBUG_CALLBACK("cef_base_t.add_ref\n");
		// if (DEBUG_REFERENCE_COUNTING)
		// printf("+");
		// return 1;
	}

	int release(cef_base_ref_counted_t* self) @nogc nothrow {
		// DEBUG_CALLBACK("cef_base_t.release\n");
		// if (DEBUG_REFERENCE_COUNTING)
		// printf("-");
		return 1;
	}

	int has_one_ref(cef_base_ref_counted_t* self) @nogc nothrow {
		// DEBUG_CALLBACK("cef_base_t.has_one_ref\n");
		// if (DEBUG_REFERENCE_COUNTING)
		// printf("=");
		return 1;
	}

	void initialize_cef_base_ref_counted(cef_base_ref_counted_t* base) {
		printf("initialize_cef_base_ref_counted\n");
		// Check if "size" member was set.
		// Let's print the size in case sizeof was used
		// on a pointer instead of a structure. In such
		// case the number will be very high.
		// printf("cef_base_t.size = %lu\n", cast(ulong)size);
		if (base.size <= 0) {
			printf("FATAL: initialize_cef_base failed, size member not set\n");
			// _exit(1);
			exit(2);
		}
		base.add_ref = &add_ref;
		base.release = &release;
		base.has_one_ref = &has_one_ref;
	}
}