#pragma once

#include "hittable.hpp"
#include "vec3.hpp"

#include <utility>

namespace rt {

class sphere final : public hittable {
  point3 m_center;
  double m_radius = 0.0;
  std::shared_ptr<material> m_mat_ptr;

public:
  constexpr sphere() = default;
  inline sphere(point3 center, double radius, std::shared_ptr<material> m)
      : m_center(std::move(center)), m_radius(radius), m_mat_ptr(std::move(m)) {
  }

  [[nodiscard]] std::optional<hit_record>
  hit(const ray& r, double t_min, double t_max) const override;
};

} // namespace rt
