.PHONY: deps clean

WASM_PROJECT_LOCAL_PATH	= ../gemi/bin/wasm-player
RUST_PROJECT_PATH		= rs
WWW_ROOT_PACKAGE_PATH	= ../../content/wasm


deps:
	# Add WASM target for rust
	rustup target add wasm32-unknown-unknown

	# Install wasm tools
	cargo install wasm-pack


clean:


# build all wasm targets
all: wasm-player wasm-debugger


# build the player wasm package from the cargo project within this repository
# this has a dependency on the emulator's git repo and will pull the source code from there
wasm-player:
	wasm-pack build --release --target web --out-name wasm-player --out-dir $(WWW_ROOT_PACKAGE_PATH)/player $(RUST_PROJECT_PATH)/player

# build the debugger wasm package from the cargo project within this repository
# this has a dependency on the emulator's git repo and will pull the source code from there
wasm-debugger:
	wasm-pack build --release --target web --out-name wasm-debugger --out-dir $(WWW_ROOT_PACKAGE_PATH)/debugger $(RUST_PROJECT_PATH)/debugger


# build the wasm package from a local folder
wasm-player-from-local:
	wasm-pack build --release --target web --out-name wasm-player --out-dir out/ $(WASM_PROJECT_LOCAL_PATH)
	rm -rf $(WWW_ROOT_PACKAGE_PATH)
	mv $(WASM_PROJECT_LOCAL_PATH)/out $(WWW_ROOT_PACKAGE_PATH)
