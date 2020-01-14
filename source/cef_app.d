module cef_app;

import cef;
import core.stdc.stdio;
import core.stdc.stdlib;
import cef_base;

extern(C) {
	void on_before_command_line_processing(cef_app_t* self, const(cef_string_t)* process_type, cef_command_line_t* command_line) @nogc nothrow {
		// DEBUG_CALLBACK("on_before_command_line_processing\n");
	}

	void on_register_custom_schemes(cef_app_t* self, cef_scheme_registrar_t* registrar) @nogc nothrow {
		// DEBUG_CALLBACK("on_register_custom_schemes\n");
	}

	cef_resource_bundle_handler_t* get_resource_bundle_handler(cef_app_t* self) @nogc nothrow {
		// DEBUG_CALLBACK("get_resource_bundle_handler\n");
		return null;
	}

	cef_browser_process_handler_t* get_browser_process_handler(cef_app_t* self) @nogc nothrow {
		// DEBUG_CALLBACK("get_browser_process_handler\n");
		return null;
	}

	cef_render_process_handler_t* get_render_process_handler(cef_app_t* self) @nogc nothrow {
		// DEBUG_CALLBACK("get_render_process_handler\n");
		return null;
	}

	void initialize_cef_app(cef_app_t* app) {
		printf("initializecef_app\n");
		app.base.size = cef_app_t.sizeof;
		initialize_cef_base_ref_counted(&app.base);
		app.on_before_command_line_processing = &on_before_command_line_processing;
		app.on_register_custom_schemes = &on_register_custom_schemes;
		app.get_resource_bundle_handler = &get_resource_bundle_handler;
		app.get_browser_process_handler = &get_browser_process_handler;
		app.get_render_process_handler = &get_render_process_handler;
	}
}