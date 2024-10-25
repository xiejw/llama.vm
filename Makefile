run:
	cargo run

fmt:
	cargo fmt

test:
	cargo clippy -- -D warnings && cargo build

release:
	cargo run --release

clean:
	cargo clean
