# Package
version       = "0.1.1"
author        = "stisa"
description   = "Wrapper for js ajax"
license       = "MIT"

srcDir = "src"

# Deps
requires: "nim >= 1.4.0"

import ospaths

task builddocs, "Build docs folder - examples and documentation":
  exec("exampler") # custom utility to generate example pages
  exec("nim doc2 -o:docs/ajax.html src/ajax.nim")
  withdir "examples":
    for file in listfiles("."):
      if splitfile(file).ext == ".nim":
        exec "nim js -o:../docs/examples/"&file.changefileext("js")&" "&file
