#pragma once

#include "hittable.hpp"
#include "material.hpp"
#include "vec3.hpp"

#include <optional>

namespace rt {

class lambertian : public material {
  color m_albedo;

public:
  constexpr lambertian(color a) : m_albedo(std::move(a)) {}

  [[nodiscard]] std::optional<scatter_result>
  scatter([[maybe_unused]] const ray& r, const hit_record& rec) const override {
    vec3 scatter_direction = rec.normal + random_unit_vector();

    if (scatter_direction.near_zero()) {
      scatter_direction = rec.normal;
    }

    return scatter_result{
        .attenuation = m_albedo,
        .scattered = ray{rec.p, scatter_direction},
    };
  }
};

} // namespace rt
