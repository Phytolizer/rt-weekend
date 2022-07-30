import vec3

proc writeColor*(f: File, pixelColor: Color) =
  f.writeLine(
    (255.999 * pixelColor.x).int,
    ' ',
    (255.999 * pixelColor.y).int,
    ' ',
    (255.999 * pixelColor.z).int,
  )
