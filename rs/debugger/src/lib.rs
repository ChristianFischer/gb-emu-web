
use gemi_debugger::app::EmulatorApplication;
use wasm_bindgen::prelude::wasm_bindgen;


#[wasm_bindgen(start)]
pub fn debugger_init() {
    // redirect log messages and panics to the browser console
    eframe::WebLogger::init(log::LevelFilter::Debug).ok();
    std::panic::set_hook(Box::new(console_error_panic_hook::hook));

    let web_options = eframe::WebOptions::default();

    wasm_bindgen_futures::spawn_local(async {
        eframe::WebRunner::new()
            .start(
                "gemi_canvas",
                web_options,
                Box::new(|cc| {
                    Box::new(
                        EmulatorApplication::from_creation_context(cc)
                        .unwrap_or_else(|| EmulatorApplication::default())
                    )
                })
            )
            .await
            .expect("failed to start eframe");
    });
}

