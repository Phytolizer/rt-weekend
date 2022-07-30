import ray
import vec3

type Camera* = object
  origin: Point3
  lowerLeftCorner: Point3
  horizontal: Vec3
  vertical: Vec3

proc newCamera*: Camera =
  const AspectRatio = 16.0 / 9.0
  const ViewportHeight = 2.0
  const ViewportWidth = AspectRatio * ViewportHeight
  const FocalLength = 1.0

  result.origin = newPoint3(0, 0, 0)
  result.horizontal = newVec3(ViewportWidth, 0, 0)
  result.vertical = newVec3(0, ViewportHeight, 0)
  result.lowerLeftCorner = (
    result.origin -
    result.horizontal / 2 -
    result.vertical / 2 -
    newVec3(0, 0, FocalLength)
  )

proc getRay*(self: Camera, u: float, v: float): Ray =
  newRay(
    self.origin,
    self.lowerLeftCorner + u * self.horizontal + v * self.vertical - self.origin,
  )
