import unittest
import align, strutils

doAssert "abcd".alignLeft(6) == "abcd  "
doAssert "abcd".align(6) == "  abcd"
doAssert "あい".alignLeft(6) == "あい" # あ == 3byte
doAssert "あい".align(6) == "あい" # あ == 3byte

suite "alignLeft":
  test "Normal":
    discard

suite "alignCenter":
  test "Half width and full width (odd)":
    check @["Hello", "こんにちは"].alignCenter == @[
      "  Hello   ",
      "こんにちは",
      ]
    check @["こんにちは", "Hello"].alignCenter == @[
      "こんにちは",
      "  Hello   ",
      ]
    check @["こんにちは", "Hello", "1"].alignCenter == @[
      "こんにちは",
      "  Hello   ",
      "    1     ",
      ]
  test "Half width and full width (even)":
    check @["Hello1", "こんにちは"].alignCenter == @[
      "  Hello1  ",
      "こんにちは",
      ]
  test "Pad = x":
    check @["Hello1", "こんにちは"].alignCenter(pad = "x") == @[
      "xxHello1xx",
      "こんにちは",
      ]
  test "Pad is multibyte string":
    check @["Hello1", "こんにちは"].alignCenter(pad = "あ") == @[
      "あHello1あ",
      "こんにちは",
      ]
    check @["Hello", "こんにちは"].alignCenter(pad = "あ") == @[
      "あHello あ",
      "こんにちは",
      ]
    check @["Hello1", "こんにちは"].alignCenter(pad = "　") == @[
      "　Hello1　",
      "こんにちは",
      ]
    check @["Hello", "こんにちは"].alignCenter(pad = "　") == @[
      "　Hello 　",
      "こんにちは",
      ]

suite "alignRight":
  test "Normal":
    discard
