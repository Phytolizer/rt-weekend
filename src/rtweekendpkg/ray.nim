import vec3

type Ray* = object
  orig: Point3
  dir: Vec3

proc newRay*(origin: Point3, dir: Vec3): Ray =
  Ray(orig: origin, dir: dir)

proc newRay*: Ray =
  newRay(newPoint3(), newVec3())

proc origin*(r: Ray): Point3 =
  r.orig

proc direction*(r: Ray): Vec3 =
  r.dir

proc at*(r: Ray, t: float): Point3 =
  r.orig + t * r.dir
