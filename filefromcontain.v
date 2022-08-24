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
                    if realpath.contains(guid) {
                        println(realpath)
                    }
                }
            }
        }
    }
}

fn main() {
    print("target text: ")
    guid := os.get_line()
    keepcheckingloop(".", guid, ".")
}
