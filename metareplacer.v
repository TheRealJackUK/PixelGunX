import os

fn walker(path string) {
    mut lo := os.read_file("./result.txt") or { panic(err) }
    mut le := os.read_file("./pgwresult.txt") or { panic(err) }
    mut correct_guid := ""
    mut pgw_guid := ""
    for lin in lo.split("\n") {
        if lin.contains(": ") {
            correct_guid = lin.split(": ")[1]
            for lieen in le.split("\n") {
                if lieen.contains(": ") {
                    if lieen.split(": ")[0] == lin.split(": ")[0] {
                        pgw_guid = lin.split(": ")[1]
                        println("Checking " + path + ". The correct GUID is " + correct_guid + " and the incorrect one is " + pgw_guid)
                        mut finaltext := os.read_file(path) or { panic(err) }
                        finaltext = finaltext.replace(correct_guid, pgw_guid)
                        os.write_file(path, finaltext) or { panic(err) }
                    }
                }
            }
        }
    }
}

fn main() {
    // os.write_file("./result.txt", "") or { panic(err) }
    os.walk("./Assets/Export/PGW/Resources/ui/common", walker)
}
