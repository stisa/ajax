# Package
version       = "0.1.0"
author        = "stisa"
description   = "Wrapper for js websockets"
license       = "MIT"

srcDir = "src"

# Deps
requires: "nim >= 0.14.0"

task docs:
  exec("nim doc2 -o:docs/jswebsockets.html ./src/jswebsockets.nim")
  exec("nim e buildex.nims")
task exampler:
  exec("nim e buildex.nims")
