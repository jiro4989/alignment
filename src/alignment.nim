## This module provides functions to align texts.
## The procedures consider multibyte strings (ex: あいうえお, 漢字).
##
## Basic usage
## ===========
##
## Show example that aligns text that has half width string and full width
## string.

runnableExamples:
  import alignment

  let s = @["abcde", "あいうえお", "ABC", "あ", "123456789"]
  let aligned = s.alignCenter
  doAssert aligned[0] == "  abcde   "
  doAssert aligned[1] == "あいうえお"
  doAssert aligned[2] == "   ABC    "
  doAssert aligned[3] == "    あ    "
  doAssert aligned[4] == "123456789 "

  for line in aligned:
    echo "| ", line, " |"
  
  ## Output:
  ## |   abcde    |
  ## | あいうえお |
  ## |    ABC     |
  ## |     あ     |
  ## | 123456789  |

import eastasianwidth
import strutils
from sequtils import mapIt

proc alignLeft*(lines: openArray[string], pad = " "): seq[string] =
  ## Aligns strings with padding, so that it is of max look length of strings.
  ## Padding string are added before resulting in left alignment. 
  runnableExamples:
    let aligned = @["abcde", "あいうえお"].alignLeft
    doAssert aligned[0] == "abcde     "
    doAssert aligned[1] == "あいうえお"

  if lines.len < 1: return
  if pad == "":
    result.add lines
    return
  let lineMaxWidth = lines.mapIt(it.stringWidth).max
  for line in lines:
    let
      diff = lineMaxWidth - line.stringWidth
      repeatCount = int(diff / pad.stringWidth)
    var s = line
    if 0 < repeatCount:
      let pads = pad.repeat(repeatCount).join
      s.add " ".repeat(lineMaxWidth - line.stringWidth - pads.stringWidth).join
      s.add pads
    result.add s

proc alignCenter*(lines: openArray[string], pad = " "): seq[string] =
  ## Aligns strings with padding, so that it is of max look length of strings.
  ## Padding string are added before and after resulting in center alignment. 
  runnableExamples:
    let aligned = @["abcde", "あいうえお"].alignCenter
    doAssert aligned[0] == "  abcde   "
    doAssert aligned[1] == "あいうえお"

  if lines.len < 1: return
  if pad == "":
    result.add lines
    return
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
  ## Aligns strings with padding, so that it is of max look length of strings.
  ## Padding string are added after resulting in right alignment. 
  runnableExamples:
    let aligned = @["abcde", "あいうえお"].alignRight
    doAssert aligned[0] == "     abcde"
    doAssert aligned[1] == "あいうえお"

  if lines.len < 1: return
  if pad == "":
    result.add lines
    return
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
