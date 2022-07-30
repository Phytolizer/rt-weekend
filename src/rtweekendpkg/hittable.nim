import ray
import vec3

import std/options

type HitRecord* = object
  p*: Point3
  normal*: Vec3
  t*: float
  frontFace*: bool

proc newHitRecord*(p: Point3, t: float): HitRecord =
  HitRecord(
    p: p,
    normal: newVec3(),
    t: t,
    frontFace: false
  )

proc setFaceNormal*(self: var HitRecord, r: Ray, outwardNormal: Vec3) =
  self.frontFace = r.direction.dot(outwardNormal) < 0
  self.normal =
    if self.frontFace:
      outwardNormal
    else:
      -outwardNormal

type Hittable* = ref object of RootObj

method hit*(
  h: Hittable,
  r: Ray,
  tMin: float,
  tMax: float,
): Option[HitRecord] {.base.} =
  raiseAssert "hit() not implemented"
