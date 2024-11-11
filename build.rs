use cmake;

fn main() {
    let dst = cmake::Config::new("third_party/sentencepiece/")
        .generator("Ninja")
        .define("SPM_ENABLE_SHARED", "OFF")
        .very_verbose(false)
        .build();

    println!("cargo:rustc-link-search=native={}/lib", dst.display());
    println!("cargo:rustc-link-lib=static=sentencepiece");
}
