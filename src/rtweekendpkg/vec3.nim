import weekend

import std/math
import std/strformat

type Vec3* = object
  e: array[3, float]

proc newVec3*(x: float, y: float, z: float): Vec3 =
  Vec3(
    e: [x, y, z]
  )

proc newVec3*: Vec3 =
  newVec3(0.0, 0.0, 0.0)

proc x*(v: Vec3): float =
  v.e[0]

proc y*(v: Vec3): float =
  v.e[1]

proc z*(v: Vec3): float =
  v.e[2]

proc `-`*(v: Vec3): Vec3 =
  newVec3(-v.x, -v.y, -v.z)

proc `[]`*(v: Vec3, i: int): float =
  v.e[i]

proc `[]`*(v: var Vec3, i: int): var float =
  v.e[i]

proc `+=`*(v: var Vec3, u: Vec3) =
  for i in 0..<3:
    v.e[i] += u.e[i]

proc `*=`*(v: var Vec3, t: float) =
  for i in 0..<3:
    v.e[i] *= t

proc `/=`*(v: var Vec3, t: float) =
  v *= 1 / t

proc lengthSquared*(v: Vec3): float =
  v.x * v.x + v.y * v.y + v.z * v.z

proc length*(v: Vec3): float =
  v.lengthSquared.sqrt

proc `$`*(v: Vec3): string =
  fmt"{v.x} {v.y} {v.z}"

proc `+`*(u: Vec3, v: Vec3): Vec3 =
  newVec3(u.x + v.x, u.y + v.y, u.z + v.z)

proc `-`*(u: Vec3, v: Vec3): Vec3 =
  newVec3(u.x - v.x, u.y - v.y, u.z - v.z)

proc `*`*(v: Vec3, t: float): Vec3 =
  newVec3(v.x * t, v.y * t, v.z * t)

proc `*`*(t: float, v: Vec3): Vec3 =
  v * t

proc `/`*(v: Vec3, t: float): Vec3 =
  (1 / t) * v

proc dot*(u: Vec3, v: Vec3): float =
  u.x * v.x + u.y * v.y + u.z * v.z

proc cross*(u: Vec3, v: Vec3): Vec3 =
  newVec3(
    u.y * v.z - u.z * v.y,
    u.z * v.x - u.x * v.z,
    u.x * v.y - u.y * v.x
  )

proc unitVector*(v: Vec3): Vec3 =
  v / v.length

proc random*: Vec3 =
  newVec3(
    randomFloat(),
    randomFloat(),
    randomFloat(),
  )

proc random*(min: float, max: float): Vec3 =
  newVec3(
    randomFloat(min, max),
    randomFloat(min, max),
    randomFloat(min, max),
  )

proc randomInUnitSphere*: Vec3 =
  while true:
    let p = random(-1.0, 1.0)
    if p.lengthSquared >= 1:
      continue
    return p

proc randomUnitVector*: Vec3 =
  randomInUnitSphere().unitVector

type Point3* = Vec3

proc newPoint3*: Point3 =
  newVec3()

proc newPoint3*(x: float, y: float, z: float): Point3 =
  newVec3(x, y, z)

type Color* = Vec3

proc newColor*: Color =
  newVec3()

proc newColor*(x: float, y: float, z: float): Color =
  newVec3(x, y, z)
