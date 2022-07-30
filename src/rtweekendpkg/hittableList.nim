import hittable
import ray
import vec3

import std/options

type HittableList* = ref object of Hittable
  objects: seq[Hittable]

proc newHittableList*: HittableList =
  HittableList(
    objects: @[]
  )

proc newHittableList*(obj: Hittable): HittableList =
  HittableList(
    objects: @[obj]
  )

proc clear*(self: var HittableList) =
  self.objects = @[]

proc add*(self: var HittableList, obj: Hittable) =
  self.objects &= obj

method hit*(
  self: HittableList,
  r: Ray,
  tMin: float,
  tMax: float,
): Option[HitRecord] =
  var tempRec = newHitRecord(newVec3(), 0)
  var hitAnything = false
  var closestSoFar = tMax

  for obj in self.objects:
    let rec = obj.hit(r, tMin, closestSoFar)
    if rec.isSome:
      hitAnything = true
      closestSoFar = rec.get.t
      tempRec = rec.get

  if hitAnything:
    some(tempRec)
  else:
    none[HitRecord]()
