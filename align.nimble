# Package

version       = "1.0.0"
author        = "jiro4989"
description   = "align is a library"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 0.19.4"
requires "eastasianwidth >= 1.1.0"

task docs, "Generate documents":
  exec "nimble doc src/align.nim -o:docs/align.html"

task ci, "Run CI":
  exec "nim -v"
  exec "nimble -v"
  exec "nimble install -Y"
  exec "nimble docs -Y"
  exec "nimble test -Y"