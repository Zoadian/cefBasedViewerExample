module cef;

import core.runtime;
import core.sys.windows.windows;
import std.string;

//pragma(lib, "libcef.lib");

struct cef_command_line_t {}
struct cef_scheme_registrar_t {}
struct cef_resource_bundle_handler_t {}
struct cef_browser_process_handler_t {}
struct cef_render_process_handler_t {}
struct cef_context_menu_handler_t {}
struct cef_dialog_handler_t {}
struct cef_display_handler_t {}
struct cef_download_handler_t {}
struct cef_drag_handler_t {}
struct cef_find_handler_t {}
struct cef_focus_handler_t {}
struct cef_geolocation_handler_t {}
struct cef_jsdialog_handler_t {}
struct cef_keyboard_handler_t {}
struct cef_load_handler_t {}
struct cef_render_handler_t {}
struct cef_request_handler_t {}
struct cef_request_context_t {}
struct cef_browser_host_t {}
struct cef_string_list_t {}
struct cef_process_id_t {}
struct cef_process_message_t {}
struct cef_popup_features_t {}
struct cef_window_open_disposition_t {}
struct cef_string_visitor_t {}
struct cef_string_userfree_t {}
struct cef_request_t {}
struct cef_v8context_t {}
struct cef_domvisitor_t {}

/* string */

alias cef_char_t = wchar;
// alias cef_string_userfree_t = cef_string_userfree_utf16_t;
alias cef_string_t = cef_string_utf16_t;

extern(C) int cef_string_utf8_to_utf16(const char* src, size_t src_len, cef_string_utf16_t* output) @nogc nothrow;

/* string types*/

struct cef_string_utf16_t {
	wchar* str;
	size_t length;
	extern(C) void function(wchar* str) @nogc nothrow dtor;
}

/* types */
enum cef_log_severity_t : int {
	LOGSEVERITY_DEFAULT,
	LOGSEVERITY_VERBOSE,
	LOGSEVERITY_INFO,
	LOGSEVERITY_WARNING,
	LOGSEVERITY_ERROR,
	LOGSEVERITY_DISABLE = 99
}

alias cef_color_t = uint;

enum cef_color_type_t{
	CEF_COLOR_TYPE_RGBA_8888,
	CEF_COLOR_TYPE_BGRA_8888,
}

struct cef_settings_t {
	size_t size;
	int single_process;
	int no_sandbox;
	cef_string_t browser_subprocess_path;
	cef_string_t framework_dir_path;
	int multi_threaded_message_loop;
	int external_message_pump;
	int windowless_rendering_enabled;
	int command_line_args_disabled;
	cef_string_t cache_path;
	cef_string_t user_data_path;
	int persist_session_cookies;
	int persist_user_preferences;
	cef_string_t user_agent;
	cef_string_t product_version;
	cef_string_t locale;
	cef_string_t log_file;
	cef_log_severity_t log_severity;
	cef_string_t javascript_flags;
	cef_string_t resources_dir_path;
	cef_string_t locales_dir_path;
	int pack_loading_disabled;
	int remote_debugging_port;
	int uncaught_exception_stack_size;
	int ignore_certificate_errors;
	int enable_net_security_expiration;
	cef_color_t background_color;
	cef_string_t accept_language_list;
}

enum cef_state_t : int{
	STATE_DEFAULT = 0,
	STATE_ENABLED,
	STATE_DISABLED,
}

struct cef_browser_settings_t {
	size_t size;
	int windowless_frame_rate;
	cef_string_t standard_font_family;
	cef_string_t fixed_font_family;
	cef_string_t serif_font_family;
	cef_string_t sans_serif_font_family;
	cef_string_t cursive_font_family;
	cef_string_t fantasy_font_family;
	int default_font_size;
	int default_fixed_font_size;
	int minimum_font_size;
	int minimum_logical_font_size;
	cef_string_t default_encoding;
	cef_state_t remote_fonts;
	cef_state_t javascript;
	cef_state_t javascript_close_windows;
	cef_state_t javascript_access_clipboard;
	cef_state_t javascript_dom_paste;
	cef_state_t plugins;
	cef_state_t universal_access_from_file_urls;
	cef_state_t file_access_from_file_urls;
	cef_state_t web_security;
	cef_state_t image_loading;
	cef_state_t image_shrink_standalone_to_fit;
	cef_state_t text_area_resize;
	cef_state_t tab_to_links;
	cef_state_t local_storage;
	cef_state_t databases;
	cef_state_t application_cache;
	cef_state_t webgl;
	cef_color_t background_color;
	cef_string_t accept_language_list;
}

/* types win */

alias cef_cursor_handle_t = HCURSOR;
alias cef_event_handle_t = MSG*;
alias cef_window_handle_t = HWND;

enum kNullCursorHandle = null;
enum kNullEventHandle = null;
enum kNullWindowHandle = null;

struct cef_main_args_t {
	HINSTANCE instance;
}

struct cef_window_info_t {
	DWORD ex_style;
	cef_string_t window_name;
	DWORD style;
	int x;
	int y;
	int width;
	int height;
	cef_window_handle_t parent_window;
	HMENU menu;
	int windowless_rendering_enabled;
	cef_window_handle_t window;
}


/* base */

struct cef_base_ref_counted_t {
	size_t size;
	extern(C) void function(cef_base_ref_counted_t* self) @nogc nothrow add_ref;
	extern(C) int function(cef_base_ref_counted_t* self) @nogc nothrow release;
	extern(C) int function(cef_base_ref_counted_t* self) @nogc nothrow has_one_ref;
}

struct cef_base_scoped_t {
	size_t size;
	extern(C) void function(cef_base_scoped_t* self) @nogc nothrow del;
}

/* app */

struct cef_app_t {
	cef_base_ref_counted_t base;
	extern(C) void function(cef_app_t* self, const(cef_string_t)* process_type, cef_command_line_t* command_line) @nogc nothrow on_before_command_line_processing;
	extern(C) void function(cef_app_t* self, cef_scheme_registrar_t* registrar) @nogc nothrow on_register_custom_schemes;
	extern(C) cef_resource_bundle_handler_t* function(cef_app_t* self) @nogc nothrow get_resource_bundle_handler;
	extern(C) cef_browser_process_handler_t* function(cef_app_t* self) @nogc nothrow get_browser_process_handler;
	extern(C) cef_render_process_handler_t* function(cef_app_t* self) @nogc nothrow get_render_process_handler;
}

extern(C) int cef_execute_process(const (cef_main_args_t)* args, cef_app_t* application, void* windows_sandbox_info) @nogc nothrow;
extern(C) int cef_initialize(const (cef_main_args_t)* args, const ( cef_settings_t)* settings, cef_app_t* application, void* windows_sandbox_info) @nogc nothrow;
extern(C) void cef_shutdown() @nogc nothrow;
extern(C) void cef_do_message_loop_work() @nogc nothrow;
extern(C) void cef_run_message_loop() @nogc nothrow;
extern(C) void cef_quit_message_loop() @nogc nothrow;
extern(C) void cef_set_osmodal_loop(int osModalLoop) @nogc nothrow;
extern(C) void cef_enable_highdpi_support() @nogc nothrow;

/* client*/
struct cef_client_t {
	cef_base_ref_counted_t base;
	extern(C) cef_context_menu_handler_t* function(cef_client_t* self) @nogc nothrow get_context_menu_handler;
	extern(C) cef_dialog_handler_t* function(cef_client_t* self) @nogc nothrow get_dialog_handler;
	extern(C) cef_display_handler_t* function(cef_client_t* self) @nogc nothrow get_display_handler;
	extern(C) cef_download_handler_t* function(cef_client_t* self) @nogc nothrow get_download_handler;
	extern(C) cef_drag_handler_t* function(cef_client_t* self) @nogc nothrow get_drag_handler;
	extern(C) cef_find_handler_t* function(cef_client_t* self) @nogc nothrow get_find_handler;
	extern(C) cef_focus_handler_t* function(cef_client_t* self) @nogc nothrow get_focus_handler;
	extern(C) cef_geolocation_handler_t* function(cef_client_t* self) @nogc nothrow get_geolocation_handler;
	extern(C) cef_jsdialog_handler_t* function(cef_client_t* self) @nogc nothrow get_jsdialog_handler;
	extern(C) cef_keyboard_handler_t* function(cef_client_t* self) @nogc nothrow get_keyboard_handler;
	extern(C) cef_life_span_handler_t* function(cef_client_t* self) @nogc nothrow get_life_span_handler;
	extern(C) cef_load_handler_t* function(cef_client_t* self) @nogc nothrow get_load_handler;
	extern(C) cef_render_handler_t* function(cef_client_t* self) @nogc nothrow get_render_handler;
	extern(C) cef_request_handler_t* function(cef_client_t* self) @nogc nothrow get_request_handler;
}

/* browser */

struct cef_browser_t {
	cef_base_ref_counted_t base;
	extern(C) cef_browser_host_t* function(cef_browser_t* self) @nogc nothrow get_host;
	extern(C) int function(cef_browser_t* self) @nogc nothrow can_go_back;
	extern(C) void function(cef_browser_t* self) @nogc nothrow go_back;
	extern(C) int function(cef_browser_t* self) @nogc nothrow can_go_forward;
	extern(C) void function(cef_browser_t* self) @nogc nothrow go_forward;
	extern(C) int function(cef_browser_t* self) @nogc nothrow is_loading;
	extern(C) void function(cef_browser_t* self) @nogc nothrow reload;
	extern(C) void function(cef_browser_t* self) @nogc nothrow reload_ignore_cache;
	extern(C) void function(cef_browser_t* self) @nogc nothrow stop_load;
	extern(C) int function(cef_browser_t* self) @nogc nothrow get_identifier;
	extern(C) int function(cef_browser_t* self, cef_browser_t* that) @nogc nothrow is_same;
	extern(C) int function(cef_browser_t* self) @nogc nothrow is_popup;
	extern(C) int function(cef_browser_t* self) @nogc nothrow has_document;
	extern(C) cef_frame_t* function(cef_browser_t* self) @nogc nothrow get_main_frame;
	extern(C) cef_frame_t* function(cef_browser_t* self) @nogc nothrow get_focused_frame;
	extern(C) cef_frame_t* function(cef_browser_t* self, long identifier) @nogc nothrow get_frame_byident;
	extern(C) cef_frame_t* function(cef_browser_t* self, const (cef_string_t)* name) @nogc nothrow get_frame;
	extern(C) size_t function(cef_browser_t* self) @nogc nothrow get_frame_count;
	extern(C) void function(cef_browser_t* self, size_t* identifiersCount, long* identifiers) @nogc nothrow get_frame_identifiers;
	extern(C) void function(cef_browser_t* self, cef_string_list_t names) @nogc nothrow get_frame_names;
	extern(C) int function(cef_browser_t* self, cef_process_id_t target_process, cef_process_message_t* message) @nogc nothrow send_process_message;
}

extern(C) int cef_browser_host_create_browser(const (cef_window_info_t)* windowInfo, cef_client_t* client, const (cef_string_t)* url, const (cef_browser_settings_t)* settings, cef_request_context_t* request_context) @nogc nothrow;
extern(C) cef_browser_t* cef_browser_host_create_browser_sync(const (cef_window_info_t)* windowInfo, cef_client_t* client, const (cef_string_t)* url, const (cef_browser_settings_t)* settings, cef_request_context_t* request_context) @nogc nothrow;

/* lifespan */

struct cef_life_span_handler_t {
	cef_base_ref_counted_t base;
	extern(C) int function(cef_life_span_handler_t* self, cef_browser_t* browser, cef_frame_t* frame, const (cef_string_t)* target_url, const (cef_string_t)* target_frame_name, cef_window_open_disposition_t target_disposition, int user_gesture, const (cef_popup_features_t)* popupFeatures, cef_window_info_t* windowInfo, cef_client_t** client, cef_browser_settings_t* settings, int* no_javascript_access) @nogc nothrow on_before_popup;
	extern(C) void function(cef_life_span_handler_t* self, cef_browser_t* browser) @nogc nothrow on_after_created;
	extern(C) int function(cef_life_span_handler_t* self, cef_browser_t* browser) @nogc nothrow do_close;
	extern(C) void function(cef_life_span_handler_t* self, cef_browser_t* browser) @nogc nothrow on_before_close;
}

/* frame */

struct cef_frame_t {
	cef_base_ref_counted_t base;
	int function(cef_frame_t* self) is_valid;
	void function(cef_frame_t* self) undo;
	void function(cef_frame_t* self) redo;
	void function(cef_frame_t* self) cut;
	void function(cef_frame_t* self) copy;
	void function(cef_frame_t* self) paste;
	void function(cef_frame_t* self) del;
	void function(cef_frame_t* self) select_all;
	void function(cef_frame_t* self) view_source;
	void function(cef_frame_t* self, cef_string_visitor_t* visitor) get_source;
	void function(cef_frame_t* self, cef_string_visitor_t* visitor) get_text;
	void function(cef_frame_t* self, cef_request_t* request) load_request;
	void function(cef_frame_t* self, const (cef_string_t)* url) load_url;
	void function(cef_frame_t* self, const (cef_string_t)* string_val, const (cef_string_t)* url) load_string;
	void function(cef_frame_t* self, const (cef_string_t)* code, const (cef_string_t)* script_url, int start_line) execute_java_script;
	int function(cef_frame_t* self) is_main;
	int function(cef_frame_t* self) is_focused;
	cef_string_userfree_t function(cef_frame_t* self) get_name;
	long function(cef_frame_t* self) get_identifier;
	cef_frame_t* function(cef_frame_t* self) get_parent;
	cef_string_userfree_t function(cef_frame_t* self) get_url;
	cef_browser_t* function(cef_frame_t* self) get_browser;
	cef_v8context_t* function(cef_frame_t* self) get_v8context;
	void function(cef_frame_t* self, cef_domvisitor_t* visitor) visit_dom;
}
