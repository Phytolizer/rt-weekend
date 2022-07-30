import rtweekendpkg/camera
import rtweekendpkg/color
import rtweekendpkg/hittable
import rtweekendpkg/hittableList
import rtweekendpkg/ray
import rtweekendpkg/sphere
import rtweekendpkg/vec3
import rtweekendpkg/weekend

import std/algorithm
import std/options
import std/sequtils
import std/strformat

proc rayColor(r: Ray, world: Hittable, depth: int): Color =
  if depth == 0:
    return newColor(0, 0, 0)

  let rec = world.hit(r, 0.001, Infinity)
  if rec.isSome:
    let target = rec.get.p + rec.get.normal + vec3.randomInUnitSphere()
    return 0.5 * rayColor(
      newRay(rec.get.p, target - rec.get.p),
      world,
      depth - 1
    )
  let unitDirection = r.direction.unitVector
  let t = 0.5 * (unitDirection.y + 1)
  (1 - t) * newColor(1, 1, 1) + t * newColor(0.5, 0.7, 1)

proc main =
  var f = open("image.ppm", fmWrite)
  defer: f.close()

  const AspectRatio = 16.0 / 9.0
  const ImageWidth = 400
  const ImageHeight = (ImageWidth / AspectRatio).int
  const SamplesPerPixel = 100
  const MaxDepth = 50

  const StatusMessage = "Scanlines remaining: "

  var world = newHittableList()
  world.add(newSphere(newPoint3(0, 0, -1), 0.5))
  world.add(newSphere(newPoint3(0, -100.5, -1), 100))

  let cam = newCamera()

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
      var pixelColor = newColor()
      for s in 0..<SamplesPerPixel:
        let u = (i.float + randomFloat()) / (ImageWidth - 1)
        let v = (j.float + randomFloat()) / (ImageHeight - 1)
        let r = cam.getRay(u, v)
        pixelColor += rayColor(r, world, MaxDepth)
      f.writeColor(pixelColor, SamplesPerPixel)

  stderr.writeLine(fmt(
    "\e[?25l\e[{StatusMessage.len + 1}G\e[KDone.\e[?25h"
  ))

when isMainModule:
  main()
