import std/random

const Pi* = 3.1415926535897932385
const Infinity* = Inf

proc toRadians*(degrees: float): float =
  degrees * Pi / 180

var r = initRand()

proc randomFloat*: float =
  r.rand(1.0)

proc randomFloat*(min: float, max: float): float =
  r.rand(max - min) + min
