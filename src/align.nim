import eastasianwidth
import strutils
from sequtils import mapIt

proc alignLeft*(lines: openArray[string], pad = " "): seq[string] =
  discard

proc alignCenter*(lines: openArray[string], pad = " ", marginLeft = 0, marginRight = 0): seq[string] =
  ## "Hello" -> "|  Hello  |"
  let lineMaxWidth = lines.mapIt(it.stringWidth).max
  for line in lines:
    let diff = lineMaxWidth - line.stringWidth
    var s: string
    if 0 < diff:
      let repeatCount = int(diff / pad.stringWidth / 2)
      s.add pad.repeat(repeatCount).join
      s.add line
      if diff mod 2 != 0:
        s.add " "
      s.add pad.repeat(repeatCount).join
    else:
      s.add line
    result.add s

proc alignRight*(lines: openArray[string], pad = " "): seq[string] =
  discard
