# Package

version       = "1.1.0"
author        = "jiro4989"
description   = "alignment is a library to align strings."
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.0.0"
requires "eastasianwidth >= 1.1.0"

task docs, "Generate documents":
  exec "nimble doc src/alignment.nim -o:docs/alignment.html"

task ci, "Run CI":
  exec "nim -v"
  exec "nimble -v"
  exec "nimble install -Y"
  exec "nimble docs -Y"
  exec "nimble test -Y"
