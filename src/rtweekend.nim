import rtweekendpkg/color
import rtweekendpkg/ray
import rtweekendpkg/vec3

import std/algorithm
import std/math
import std/sequtils
import std/strformat

proc hitSphere(center: Point3, radius: float, r: Ray): float =
  let oc = r.origin - center
  let a = r.direction.lengthSquared
  let halfB = oc.dot(r.direction)
  let c = oc.lengthSquared - radius * radius
  let discriminant = halfB * halfB - a * c
  if discriminant < 0:
    -1.0
  else:
    (-halfB - sqrt(discriminant)) / a


proc rayColor(r: Ray): Color =
  var t = hitSphere(newPoint3(0, 0, -1), 0.5, r)
  if t > 0:
    let n = (r.at(t) - newVec3(0, 0, -1)).unitVector
    return 0.5 * newColor(n.x + 1, n.y + 1, n.z + 1)
  let unitDirection = r.direction.unitVector
  t = 0.5 * (unitDirection.y + 1)
  (1 - t) * newColor(1, 1, 1) + t * newColor(0.5, 0.7, 1)

proc main =
  var f = open("image.ppm", fmWrite)
  defer: f.close()

  const AspectRatio = 16.0 / 9.0
  const ImageWidth = 400
  const ImageHeight = (ImageWidth / AspectRatio).int

  const ViewportHeight = 2.0
  const ViewportWidth = AspectRatio * ViewportHeight
  const FocalLength = 1.0

  const Origin = newPoint3(0, 0, 0)
  const Horizontal = newVec3(ViewportWidth, 0, 0)
  const Vertical = newVec3(0, ViewportHeight, 0)
  const LowerLeftCorner = Origin - Horizontal / 2 - Vertical / 2 - newVec3(0, 0, FocalLength)

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
      let u = i.float / (ImageWidth - 1)
      let v = j.float / (ImageHeight - 1)
      let r = newRay(Origin, LowerLeftCorner + u * Horizontal + v * Vertical - Origin)
      let pixelColor = rayColor(r)
      f.writeColor(pixelColor)

  stderr.writeLine(fmt(
    "\e[?25l\e[{StatusMessage.len + 1}G\e[KDone.\e[?25h"
  ))

when isMainModule:
  main()
