#pragma once

#include "vec3.hpp"

namespace rt {

class ray {
  point3 m_orig;
  vec3 m_dir;

public:
  constexpr ray() = default;
  constexpr ray(const point3& origin, const vec3& direction)
      : m_orig(origin), m_dir(direction) {}

  [[nodiscard]] constexpr const point3& origin() const {
    return m_orig;
  }
  [[nodiscard]] constexpr const vec3& direction() const {
    return m_dir;
  }

  [[nodiscard]] constexpr point3 at(double t) const {
    return m_orig + t * m_dir;
  }
};

} // namespace rt
