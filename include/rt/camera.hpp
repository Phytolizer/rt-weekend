#pragma once

#include "ray.hpp"
#include "vec3.hpp"
#include "weekend.hpp"

namespace rt {

class camera {
  point3 m_origin;
  point3 m_lower_left_corner;
  vec3 m_horizontal;
  vec3 m_vertical;

public:
  constexpr camera() {
    constexpr double aspect = 16.0 / 9.0;
    constexpr double viewport_height = 2.0;
    constexpr double viewport_width = aspect * viewport_height;
    constexpr double focal_length = 1.0;

    m_origin = point3(0.0, 0.0, 0.0);
    m_horizontal = vec3{viewport_width, 0.0, 0.0};
    m_vertical = vec3{0.0, viewport_height, 0.0};
    m_lower_left_corner = m_origin - m_horizontal / 2 - m_vertical / 2 -
        vec3{0.0, 0.0, focal_length};
  }

  [[nodiscard]] constexpr ray get_ray(double u, double v) const {
    return {
        m_origin,
        m_lower_left_corner + u * m_horizontal + v * m_vertical - m_origin,
    };
  }
};

} // namespace rt
