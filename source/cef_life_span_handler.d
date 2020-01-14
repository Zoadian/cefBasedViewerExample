module cef_life_span_handler;

import cef;
import core.stdc.stdio;
import core.stdc.stdlib;

import cef_base;

__gshared bool g_closed;

extern(C) {
	void on_before_close(cef_life_span_handler_t* self, cef_browser_t* browser) @nogc nothrow {
		// DEBUG_CALLBACK("on_before_close\n");
		// TODO: Check how many browsers do exist and quit message
		//       loop only when last browser is closed. Otherwise
		//       closing a popup window will exit app while main
		//       window shouldn't be closed.
		//cef_quit_message_loop();
		g_closed = true;
	}

	void initialize_cef_life_span_handler(cef_life_span_handler_t* handler) {
		// DEBUG_CALLBACK("initialize_cef_life_span_handler\n");
		handler.base.size = cef_life_span_handler_t.sizeof;
		initialize_cef_base_ref_counted(&handler.base);
		// callbacks - there are many, but implementing only one
		handler.on_before_close = &on_before_close;
	}
}