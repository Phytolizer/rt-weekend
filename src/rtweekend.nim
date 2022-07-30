import std/algorithm
import std/sequtils
import std/strformat

proc main =
  var f = open("image.ppm", fmWrite)
  defer: f.close()

  const ImageWidth = 255
  const ImageHeight = 255

  const StatusMessage = "Scanlines remaining: "

  f.writeLine("P3")
  f.writeLine(fmt"{ImageWidth} {ImageHeight}")
  f.writeLine("255")

  stderr.write(StatusMessage)

  for j in (0..<ImageHeight).toSeq.reversed:
    stderr.write(fmt(
      "\e[?25l\e[{StatusMessage.len + 1}G\e[K{j}\e[?25h"
    ))
    stderr.flushFile()
    for i in 0..<ImageWidth:
      let r = i.float / (ImageWidth - 1)
      let g = j.float / (ImageHeight - 1)
      let b = 0.25

      let ir = (255.999 * r).int
      let ig = (255.999 * g).int
      let ib = (255.999 * b).int

      f.writeLine(fmt"{ir} {ig} {ib}")

  stderr.writeLine(fmt(
    "\e[?25l\e[{StatusMessage.len + 1}G\e[KDone.\e[?25h"
  ))

when isMainModule:
  main()
