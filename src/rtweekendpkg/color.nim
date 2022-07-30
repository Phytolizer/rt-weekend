import vec3

proc writeColor*(f: File, pixelColor: Color, samplesPerPixel: int) =
  var r = pixelColor.x
  var g = pixelColor.y
  var b = pixelColor.z

  let scale = 1.0 / samplesPerPixel.float
  r *= scale
  g *= scale
  b *= scale

  f.writeLine(
    (256 * clamp(r, 0.0, 0.999)).int,
    ' ',
    (256 * clamp(g, 0.0, 0.999)).int,
    ' ',
    (256 * clamp(b, 0.0, 0.999)).int,
  )
