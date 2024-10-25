use env_logger::Env;
use log::info;

fn main() {
    // Init env_logger.
    env_logger::Builder::from_env(Env::default().default_filter_or("debug")).init();

    info!("Hello, world!");
}
