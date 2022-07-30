import rtweekendpkg/color
import rtweekendpkg/vec3

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
      let pixelColor = newColor(
        float(i) / (ImageWidth - 1),
        float(j) / (ImageHeight - 1),
        0.25,
      )
      f.writeColor(pixelColor)

  stderr.writeLine(fmt(
    "\e[?25l\e[{StatusMessage.len + 1}G\e[KDone.\e[?25h"
  ))

when isMainModule:
  main()
