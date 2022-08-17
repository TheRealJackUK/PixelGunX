import os
import term

fn main() {
    mut tagstext := os.read_file("./ProjectSettings/TagManager.asset") or { panic("No TagManager.asset found!") }
    tagstext = tagstext.substr("%YAML 1.1\n%TAG !u! tag:unity3d.com,2011:\n--- !u!78 &1\nTagManager:\n  serializedVersion: 2\n  tags:".len, tagstext.index("  layers:") or { panic("Couldn't find layers part of the TagManager.asset file!")})
    for tag in tagstext.split("\n") {
        if tag != "" {
            mut realtag := tag.substr("  - ".len, tag.len)
            //println("Checking " + realtag + "..")
            os.read_file("./Assets/Resources/offericons/" + realtag + "_icon1_big.png") or { println(term.red("[" + realtag + "] NOT FOUND!!")) continue }
            println(term.green("[" + realtag + "] FOUND!"))
        }
    }
}
