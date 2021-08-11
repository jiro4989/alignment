import unittest
import strutils
import alignment

doAssert "a".len == 1
doAssert "あ".len == 3
doAssert "a".alignLeft(5) == "a    "
doAssert "あ".alignLeft(5) == "あ  "
doAssert "a".alignLeft(5).len == 5
doAssert "あ".alignLeft(5).len == 5

doAssert "abcd".alignLeft(6) == "abcd  "
doAssert "abcd".align(6) == "  abcd"
doAssert "あい".alignLeft(6) == "あい" # あ == 3byte
doAssert "あい".align(6) == "あい" # あ == 3byte
doAssert " ".repeat(0).join == ""

suite "alignLeft":
  test "Half width and full width":
    check @["Hello", "こんにちは"].alignLeft == @[
      "Hello     ",
      "こんにちは",
      ]
    check @["こんにちは", "Hello"].alignLeft == @[
      "こんにちは",
      "Hello     ",
      ]
    check @["こんにちは", "Hello", "1"].alignLeft == @[
      "こんにちは",
      "Hello     ",
      "1         ",
      ]
  test "Half width and full width and set width = 14":
    let width = 14
    check @["Hello", "こんにちは"].alignLeft(width = width) == @[
      "Hello         ",
      "こんにちは    ",
      ]
    check @["こんにちは", "Hello"].alignLeft(width = width) == @[
      "こんにちは    ",
      "Hello         ",
      ]
    check @["こんにちは", "Hello", "1"].alignLeft(width = width) == @[
      "こんにちは    ",
      "Hello         ",
      "1             ",
      ]
    check @["こんにちは", "Hello", "1"].alignLeft(width = 0) == @[
      "こんにちは",
      "Hello     ",
      "1         ",
      ]
    check @["こんにちは", "Hello", "1"].alignLeft(width = 1) == @[
      "こんにちは",
      "Hello     ",
      "1         ",
      ]
  test "Additional pad width":
    check @["Hello", "こんにちは"].alignLeft(additionalPadWidth = 10, pad = " ") == @[
      "Hello               ",
      "こんにちは          ",
      ]
    check @["Hello", "こんにちは"].alignLeft(additionalPadWidth = 10, pad = "　") == @[
      "Hello 　　　　　　　",
      "こんにちは　　　　　",
      ]
    check @["Hello", "こんにちは"].alignLeft(additionalPadWidth = 10, pad = "あ") == @[
      "Hello あああああああ",
      "こんにちはあああああ",
      ]
  test "Pad = x":
    check @["Hello1", "こんにちは"].alignLeft(pad = "x") == @[
      "Hello1xxxx",
      "こんにちは",
      ]
  test "Pad is multibyte string":
    check @["Hello1", "こんにちは"].alignLeft(pad = "　") == @[
      "Hello1　　",
      "こんにちは",
      ]
    check @["Hello", "こんにちは"].alignLeft(pad = "あ") == @[
      "Hello ああ",
      "こんにちは",
      ]
    check @["a", "aa", "aaa", "aaaa", "aaaaa"].alignLeft(pad = "　") == @[
      "a　　",
      "aa 　",
      "aaa　",
      "aaaa ",
      "aaaaa",
      ]
    check @["あ", "ああ", "あああ", "ああああ",
        "あああああ"].alignLeft(pad = "　") == @[
      "あ　　　　",
      "ああ　　　",
      "あああ　　",
      "ああああ　",
      "あああああ",
      ]
    check @["あ", "bcd", "あああ", "ああああ",
        "あああああ"].alignLeft(pad = "　") == @[
      "あ　　　　",
      "bcd 　　　",
      "あああ　　",
      "ああああ　",
      "あああああ",
      ]
    check @["b", "bb", "bbb", "bbbb", "bbbbb"].alignLeft(pad = "あa") == @[
      "b あa",
      "bbあa",
      "bbb  ",
      "bbbb ",
      "bbbbb",
      ]
  test "Set half pad":
    check @["a", "aa", "aaa", "aaaa", "aaaaa"].alignLeft(pad = "　",
        halfPad = "x") == @[
      "a　　",
      "aax　",
      "aaa　",
      "aaaax",
      "aaaaa",
      ]
  test "Count of data is 1":
    check @["Hello"].alignLeft == @["Hello"]
  test "Count of data is empty":
    var empty: seq[string]
    check empty.alignLeft == empty
  test "Pad is empty":
    check @["Hello1", "こんにちは"].alignLeft(pad = "") == @[
      "Hello1",
      "こんにちは",
      ]

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
  test "Half width and full width and set width = 14":
    let width = 14
    check @["Hello", "こんにちは"].alignCenter(width = width) == @[
      "    Hello     ",
      "  こんにちは  ",
      ]
    check @["Hello", "こんにちは"].alignCenter(width = 0) == @[
      "  Hello   ",
      "こんにちは",
      ]
    check @["Hello", "こんにちは"].alignCenter(width = 1) == @[
      "  Hello   ",
      "こんにちは",
      ]
  test "Additional pad width":
    check @["Hello", "こんにちは"].alignCenter(additionalPadWidth = 10, pad = " ") == @[
      "       Hello        ",
      "     こんにちは     ",
      ]
    check @["Hello", "こんにちは"].alignCenter(additionalPadWidth = 10, pad = "あ") == @[
      "あああ Hello  あああ",
      "ああ こんにちは ああ",
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
    check @["a", "aa", "aaa", "aaaa", "aaaaa"].alignCenter(pad = "　") == @[
      "　a　",
      " aa  ",
      " aaa ",
      "aaaa ",
      "aaaaa",
      ]
  test "Set half pad":
    check @["a", "aa", "aaa", "aaaa", "aaaaa"].alignCenter(pad = "　",
        halfPad = "x") == @[
      "　a　",
      "xaaxx",
      "xaaax",
      "aaaax",
      "aaaaa",
      ]
  test "Count of data is 1":
    check @["Hello"].alignCenter == @["Hello"]
  test "Count of data is empty":
    var empty: seq[string]
    check empty.alignCenter == empty
  test "Pad is empty":
    check @["Hello1", "こんにちは"].alignCenter(pad = "") == @[
      "Hello1",
      "こんにちは",
      ]

suite "alignRight":
  test "Half width and full width":
    check @["Hello", "こんにちは"].alignRight == @[
      "     Hello",
      "こんにちは",
      ]
    check @["こんにちは", "Hello"].alignRight == @[
      "こんにちは",
      "     Hello",
      ]
    check @["こんにちは", "Hello", "1"].alignRight == @[
      "こんにちは",
      "     Hello",
      "         1",
      ]
  test "Half width and full width and set width = 14":
    let width = 14
    check @["Hello", "こんにちは"].alignRight(width = width) == @[
      "         Hello",
      "    こんにちは",
      ]
    check @["こんにちは", "Hello"].alignRight(width = width) == @[
      "    こんにちは",
      "         Hello",
      ]
    check @["こんにちは", "Hello", "1"].alignRight(width = width) == @[
      "    こんにちは",
      "         Hello",
      "             1",
      ]
    check @["こんにちは", "Hello", "1"].alignRight(width = 0) == @[
      "こんにちは",
      "     Hello",
      "         1",
      ]
    check @["こんにちは", "Hello", "1"].alignRight(width = 1) == @[
      "こんにちは",
      "     Hello",
      "         1",
      ]
  test "Additional pad width":
    check @["Hello", "こんにちは"].alignRight(additionalPadWidth = 10, pad = " ") == @[
      "               Hello",
      "          こんにちは",
      ]
    check @["Hello", "こんにちは"].alignRight(additionalPadWidth = 10, pad = "　") == @[
      "　　　　　　　 Hello",
      "　　　　　こんにちは",
      ]
    check @["Hello", "こんにちは"].alignRight(additionalPadWidth = 10, pad = "あ") == @[
      "あああああああ Hello",
      "あああああこんにちは",
      ]
  test "Pad = x":
    check @["Hello1", "こんにちは"].alignRight(pad = "x") == @[
      "xxxxHello1",
      "こんにちは",
      ]
  test "Pad is multibyte string":
    check @["Hello1", "こんにちは"].alignRight(pad = "　") == @[
      "　　Hello1",
      "こんにちは",
      ]
    check @["Hello", "こんにちは"].alignRight(pad = "あ") == @[
      "ああ Hello",
      "こんにちは",
      ]
    check @["a", "aa", "aaa", "aaaa", "aaaaa"].alignRight(pad = "　") == @[
      "　　a",
      "　 aa",
      "　aaa",
      " aaaa",
      "aaaaa",
      ]
    check @["あ", "bcd", "あああ", "ああああ",
        "あああああ"].alignRight(pad = "　") == @[
      "　　　　あ",
      "　　　 bcd",
      "　　あああ",
      "　ああああ",
      "あああああ",
      ]
    check @["b", "bb", "bbb", "bbbb", "bbbbb"].alignRight(pad = "あa") == @[
      "あa b",
      "あabb",
      "  bbb",
      " bbbb",
      "bbbbb",
      ]
  test "Set half pad":
    check @["a", "aa", "aaa", "aaaa", "aaaaa"].alignRight(pad = "　",
        halfPad = "x") == @[
      "　　a",
      "　xaa",
      "　aaa",
      "xaaaa",
      "aaaaa",
      ]
  test "Count of data is 1":
    check @["Hello"].alignRight == @["Hello"]
  test "Count of data is empty":
    var empty: seq[string]
    check empty.alignRight == empty
  test "Pad is empty":
    check @["Hello1", "こんにちは"].alignRight(pad = "") == @[
      "Hello1",
      "こんにちは",
      ]
