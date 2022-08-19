import os

fn keepcheckingloop(path string, guid string, p2 string) {
    files := os.ls(path) or { panic(err) }
    for pat in files {
        realpath := os.abs_path(p2 + "/" + pat)
        // println(realpath)
        if pat != ".." && pat != "." && pat != os.dir(path) {
            if os.is_dir(realpath) {
                keepcheckingloop(realpath, guid, realpath)
            } else {
                if realpath.ends_with(".meta") {
                    // println(realpath)
                    mut txt := os.read_file(realpath) or { panic(err) }
                    // println("a")
                    txt.index("guid: ") or { continue }
                    txt.index("timeCreated") or { continue }
                    txt = txt.substr(txt.index("guid: ") or { panic(err) }, txt.index("timeCreated") or { panic(err) })
                    if txt.contains(guid) {
                        println(realpath)
                        break
                    }
                }
            }
        }
    }
}

fn main() {
    print("target guid: ")
    guid := os.get_line()
    keepcheckingloop(".", guid, ".")
}
