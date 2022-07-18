#pragma once

#include "vec3.hpp"
#include "weekend.hpp"

#include <ostream>

namespace rt {

inline void
write_color(std::ostream& os, const color& pixel_color, int samples_per_pixel) {
  double r = pixel_color.x();
  double g = pixel_color.y();
  double b = pixel_color.z();

  double scale = 1.0 / samples_per_pixel;
  r *= scale;
  g *= scale;
  b *= scale;

  os << static_cast<int>(FULL * std::clamp(r, 0.0, ALMOST_ONE)) << ' '
     << static_cast<int>(FULL * std::clamp(g, 0.0, ALMOST_ONE)) << ' '
     << static_cast<int>(FULL * std::clamp(b, 0.0, ALMOST_ONE)) << '\n';
}

} // namespace rt
