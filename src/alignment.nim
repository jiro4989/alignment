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

proc alignLeft*(lines: openArray[string], pad = " ", halfPad = " ",
    width = -1): seq[string] =
  ## Aligns strings with padding, so that it is of max look length of strings.
  ## Padding string are added before resulting in left alignment.
  runnableExamples:
    let aligned = @["abcde", "あいうえお"].alignLeft
    doAssert aligned[0] == "abcde     "
    doAssert aligned[1] == "あいうえお"

    let aligned2 = @["abcde", "あいうえお"].alignLeft(pad = "ん", halfPad = "X")
    doAssert aligned2[0] == "abcdeXんん"
    doAssert aligned2[1] == "あいうえお"

  if lines.len < 1: return
  if pad == "":
    result.add lines
    return
  let lineMaxWidth =
    block:
      let lineMax = lines.mapIt(it.stringWidth).max
      if width < 0: lineMax
      elif width < lineMax: lineMax
      else: width

  for line in lines:
    let diff = lineMaxWidth - line.stringWidth
    let repeatCount = int(diff / pad.stringWidth)
    var s = line
    if 0 < repeatCount:
      let pads = pad.repeat(repeatCount).join
      s.add halfPad.repeat(lineMaxWidth - line.stringWidth -
          pads.stringWidth).join
      s.add pads
    elif 0 < diff:
      s.add halfPad.repeat(diff)
    result.add s

proc alignCenter*(lines: openArray[string], pad = " ", halfPad = " ",
    width = -1): seq[string] =
  ## Aligns strings with padding, so that it is of max look length of strings.
  ## Padding string are added before and after resulting in center alignment.
  runnableExamples:
    let aligned = @["abcde", "あいうえお"].alignCenter
    doAssert aligned[0] == "  abcde   "
    doAssert aligned[1] == "あいうえお"

    let aligned2 = @["abcde", "あいうえお"].alignCenter(pad = "ん", halfPad = "X")
    doAssert aligned2[0] == "んabcdeXん"
    doAssert aligned2[1] == "あいうえお"

  if lines.len < 1: return
  if pad == "":
    result.add lines
    return
  let lineMaxWidth =
    block:
      let lineMax = lines.mapIt(it.stringWidth).max
      if width < 0: lineMax
      elif width < lineMax: lineMax
      else: width
  for line in lines:
    let diff = lineMaxWidth - line.stringWidth
    var s: string
    if 0 < diff:
      let repeatCount = int(diff / pad.stringWidth / 2)
      let p = pad.repeat(repeatCount).join
      s.add p

      let lc2 = int((lineMaxWidth - line.stringWidth - int(p.stringWidth * 2)) / 2)
      let p2 = halfPad.repeat(lc2).join
      s.add p2
      s.add line
      s.add halfPad.repeat(lineMaxWidth - line.stringWidth - p.stringWidth * 2 -
          p2.stringWidth * 2).join
      s.add p2

      s.add p
    else:
      s.add line
    result.add s

proc alignRight*(lines: openArray[string], pad = " ", halfPad = " ",
    width = -1): seq[string] =
  ## Aligns strings with padding, so that it is of max look length of strings.
  ## Padding string are added after resulting in right alignment.
  runnableExamples:
    let aligned = @["abcde", "あいうえお"].alignRight
    doAssert aligned[0] == "     abcde"
    doAssert aligned[1] == "あいうえお"

    let aligned2 = @["abcde", "あいうえお"].alignRight(pad = "ん", halfPad = "X")
    doAssert aligned2[0] == "んんXabcde"
    doAssert aligned2[1] == "あいうえお"

  if lines.len < 1: return
  if pad == "":
    result.add lines
    return
  let lineMaxWidth =
    block:
      let lineMax = lines.mapIt(it.stringWidth).max
      if width < 0: lineMax
      elif width < lineMax: lineMax
      else: width
  for line in lines:
    let diff = lineMaxWidth - line.stringWidth
    let repeatCount = int(diff / pad.stringWidth)
    var s: string
    if 0 < repeatCount:
      let pads = pad.repeat(repeatCount).join
      s.add pads
      s.add halfPad.repeat(lineMaxWidth - line.stringWidth -
          pads.stringWidth).join
    elif 0 < diff:
      s.add halfPad.repeat(diff)
    s.add line
    result.add s
