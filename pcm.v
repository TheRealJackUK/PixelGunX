import os

fn checkaud(path string) {
    mut ext := []string{}
    ext << "mp3"
    ext << "wav"
    ext << "ogg"
    for extension in ext {
        if path.ends_with(extension) {
            os.read_file(path + ".meta") or { continue }
            mut meta := os.read_file(path + ".meta") or { panic(err) }
            meta.index("    compressionFormat:") or { continue }
            a := meta.index("    compressionFormat: 0") or { panic(err) }
            if a > 0 {
                meta = meta.replace("    compressionFormat: 1", "    compressionFormat: 0")
                os.write_file(path + ".meta", meta) or { panic(err) }
            }
        }
    }
}

fn main() {
    os.walk("./Assets/", checkaud)
}
