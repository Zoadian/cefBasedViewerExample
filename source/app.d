import core.runtime;
import core.sys.windows.windows;
import std.meta;
import std.string;

pragma(lib, "user32.lib");
pragma(lib, "./dep/cef/libcef.lib");

import cef;

import cef_app;
import cef_base;
import cef_client;
import cef_life_span_handler;

import libasync;

enum views = AliasSeq!(
	"app"
);

enum styles = [
	"app",
	"flexboxgrid",
];

__gshared EventLoop g_evl;

extern (Windows) int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	int result;

	try {
		Runtime.initialize();
		result = myWinMain(hInstance, hPrevInstance, lpCmdLine, nCmdShow);
		Runtime.terminate();
	}
	catch (Throwable e) {
		MessageBoxA(null, e.toString().toStringz(), null, MB_ICONEXCLAMATION);
		result = 0;
	}

	return result;
}

void msgbox(T)(T t) {
	import std.conv;
	import std.string;
	MessageBoxA(null, t.to!string.toStringz(), null, MB_ICONEXCLAMATION);
}

int myWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	cef_enable_highdpi_support();

	// Main args
	cef_main_args_t main_args = {};
	main_args.instance = hInstance;

	// App
	cef_app_t app = {};
	initialize_cef_app(&app);

	// Execute subprocesses
	int exit_code = cef_execute_process(&main_args, &app, null);
	if (exit_code >= 0) {
		return exit_code;
	}

	// Application settings
	cef_settings_t settings = {};
	settings.size = cef_settings_t.sizeof;
	settings.log_severity = cef_log_severity_t.LOGSEVERITY_WARNING; // Show only warnings/errors
	settings.no_sandbox = 1;

	// Initialize CEF
	cef_initialize(&main_args, &settings, &app, null);

	cef_window_info_t window_info = {};
	window_info.style = WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN | WS_CLIPSIBLINGS | WS_VISIBLE;
	window_info.parent_window = null;
	window_info.x = CW_USEDEFAULT;
	window_info.y = CW_USEDEFAULT;
	window_info.width = CW_USEDEFAULT;
	window_info.height = CW_USEDEFAULT;

	string _windowName = `aqView`;
	cef_string_t cef_window_name = {};
	cef_string_utf8_to_utf16(_windowName.ptr, _windowName.length, &cef_window_name);
	window_info.window_name = cef_window_name;

	// Initial url
	string _url = `http://google.de`;
	cef_string_t cef_url = {};
	cef_string_utf8_to_utf16(_url.ptr, _url.length, &cef_url);

	cef_browser_settings_t browser_settings = {};
	browser_settings.size = cef_browser_settings_t.sizeof;

	// Client handlers
	cef_client_t client = {};
	initialize_cef_client(&client);
	initialize_cef_life_span_handler(&g_life_span_handler);

	// Create browser asynchronously. There is also a
	// synchronous version of this function available.
	cef_browser_t* browser = cef_browser_host_create_browser_sync(&window_info, &client, &cef_url, &browser_settings, null);

	// auto mainframe = browser.get_main_frame(browser);

	// string nurl = `http://www.google.de`;
	// cef_string_t cef_nurl = {};
	// cef_string_utf8_to_utf16(nurl.ptr, nurl.length, &cef_nurl);

	// mainframe.load_url(mainframe, &cef_nurl);

	// cef_run_message_loop();

	// event loop
	g_evl = new EventLoop;
	while(!g_closed) {
		g_evl.loop();
		cef_do_message_loop_work();
	}
	destroyAsyncThreads();

	// msgbox(r);
	cef_shutdown();

	return 0;
}
