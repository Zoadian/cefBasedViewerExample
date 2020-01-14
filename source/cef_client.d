module cef_client;

import cef;
import core.stdc.stdio;
import core.stdc.stdlib;

import cef_base;

extern(C) {
	__gshared extern(C) cef_life_span_handler_t g_life_span_handler = {};

	cef_context_menu_handler_t* get_context_menu_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_dialog_handler_t* get_dialog_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_display_handler_t* get_display_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_download_handler_t* get_download_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_drag_handler_t* get_drag_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_find_handler_t* get_find_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_focus_handler_t* get_focus_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_geolocation_handler_t* get_geolocation_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_jsdialog_handler_t* get_jsdialog_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_keyboard_handler_t* get_keyboard_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_life_span_handler_t* get_life_span_handler(cef_client_t* self) @nogc nothrow {
		return &g_life_span_handler;
	}

	cef_load_handler_t* get_load_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_render_handler_t* get_render_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	cef_request_handler_t* get_request_handler(cef_client_t* self) @nogc nothrow {
		return null;
	}

	void initialize_cef_client(cef_client_t* client) {
		client.base.size = cef_client_t.sizeof;
		initialize_cef_base_ref_counted(&client.base);
		client.get_context_menu_handler = &get_context_menu_handler;
		client.get_dialog_handler = &get_dialog_handler;
		client.get_display_handler = &get_display_handler;
		client.get_download_handler = &get_download_handler;
		client.get_drag_handler = &get_drag_handler;
		client.get_find_handler = &get_find_handler;
		client.get_focus_handler = &get_focus_handler;
		client.get_geolocation_handler = &get_geolocation_handler;
		client.get_jsdialog_handler = &get_jsdialog_handler;
		client.get_keyboard_handler = &get_keyboard_handler;
		client.get_life_span_handler = &get_life_span_handler;  // Implemented!
		client.get_load_handler = &get_load_handler;
		client.get_render_handler = &get_render_handler;
		client.get_request_handler = &get_request_handler;
	}
}