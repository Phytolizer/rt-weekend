const Pi* = 3.1415926535897932385
const Infinity* = Inf

proc toRadians*(degrees: float): float =
  degrees * Pi / 180
