import eastasianwidth
import strutils
from sequtils import mapIt

proc alignLeft*(lines: openArray[string], pad = " "): seq[string] =
  let lineMaxWidth = lines.mapIt(it.stringWidth).max
  for line in lines:
    let diff = lineMaxWidth - line.stringWidth
    var s = line
    if 0 < diff:
      let repeatCount = int(diff / pad.stringWidth)
      if 0 < repeatCount:
        let pads = pad.repeat(repeatCount).join
        s.add " ".repeat(lineMaxWidth - line.stringWidth - pads.stringWidth).join
        s.add pads
    result.add s

proc alignCenter*(lines: openArray[string], pad = " ", marginLeft = 0, marginRight = 0): seq[string] =
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
  let lineMaxWidth = lines.mapIt(it.stringWidth).max
  for line in lines:
    let
      diff = lineMaxWidth - line.stringWidth
      repeatCount = int(diff / pad.stringWidth)
    var s: string
    if 0 < repeatCount:
      let pads = pad.repeat(repeatCount).join
      s.add pads
      s.add " ".repeat(lineMaxWidth - line.stringWidth - pads.stringWidth).join
    s.add line
    result.add s