import os

fn walker(path string) {
    if path.ends_with(".meta") && path.starts_with("./Assets/Scripts/Assembly-CSharp/UI") {
        println("reading " + path)
        mut txt := os.read_file(path) or { panic(err) }
        // println("a")
        println("checking for guid")
        txt.index("guid: ") or { panic(err) }
        println("checking for timecreated")
        txt.index("timeCreated") or { 
            return
        }
// + 6
        theindex := txt.index("guid: ") or { panic(err) }
        txt = txt.substr(theindex + 6, txt.index("timeCreated") or { panic(err) })
        mut resulttxt := os.read_file("./result.txt") or { panic(err) }
        resulttxt += path + ": " + txt + "\n"
        os.write_file("./result.txt", resulttxt) or { panic(err) }
        /*mut final := os.read_file(path) or { panic(err) }
        os.write_file(path, final) or { panic(err) }*/
    }
}

fn main() {
    os.write_file("./result.txt", "") or { panic(err) }
    os.walk("./Assets/Scripts/Assembly-CSharp", walker)
}
