import os

fn wcb(path string) {
    if !path.contains("marathon") {
        if path.ends_with(".meta") {
            mut t := os.read_file(path) or { panic(err) }
            a := os.read_file("./icontext") or { panic(err) }
            b := t.index("TextureImporter") or { panic(err) }
            vr := t.substr(0, b)
            t = vr + a
            os.write_file(path, t) or { panic(err) }
        }
    }
}

fn main() {
    os.walk("./Assets/Resources/offericons", wcb)
}
