#pragma once

#include "hittable.hpp"
#include "vec3.hpp"

namespace rt {

class sphere final : public hittable {
  point3 m_center;
  double m_radius = 0.0;

public:
  constexpr sphere() = default;
  constexpr sphere(point3 center, double radius)
      : m_center(std::move(center)), m_radius(radius) {}

  [[nodiscard]] std::optional<hit_record>
  hit(const ray& r, double t_min, double t_max) const override;
};

} // namespace rt
