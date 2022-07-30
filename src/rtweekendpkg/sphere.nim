import hittable
import vec3
import ray

import std/math
import std/options

type Sphere* = ref object of Hittable
  center: Point3
  radius: float

proc newSphere*(center: Point3, radius: float): Sphere =
  Sphere(
    center: center,
    radius: radius,
  )

method hit*(
  s: Sphere,
  r: Ray,
  tMin: float,
  tMax: float,
): Option[HitRecord] =
  let oc = r.origin - s.center
  let a = r.direction.lengthSquared
  let halfB = oc.dot(r.direction)
  let c = oc.lengthSquared - s.radius * s.radius

  let discriminant = halfB * halfB - a * c
  if discriminant < 0:
    return none[HitRecord]()
  let sqrtd = discriminant.sqrt
  var root = (-halfB - sqrtd) / a
  if root < tMin or tMax < root:
    root = (-halfB + sqrtd) / a
    if root < tMin or tMax < root:
      return none[HitRecord]()

  let t = root
  let p = r.at(t)
  var hit = newHitRecord(p, t)
  let outwardNormal = (p - s.center) / s.radius
  hit.setFaceNormal(r, outwardNormal)
  some(hit)
