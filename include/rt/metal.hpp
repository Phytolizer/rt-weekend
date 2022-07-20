#pragma once

#include "hittable.hpp"
#include "material.hpp"

namespace rt {

class metal : public material {
  color m_albedo;

public:
  metal(color a) : m_albedo(std::move(a)) {}

  [[nodiscard]] std::optional<scatter_result>
  scatter(const ray& r, const hit_record& rec) const override {
    vec3 reflected = reflect(unit_vector(r.direction()), rec.normal);
    scatter_result result{
        .attenuation = m_albedo,
        .scattered = ray{rec.p, reflected},
    };

    if (dot(result.scattered.direction(), rec.normal) < 0) {
      return {};
    }

    return result;
  }
};

} // namespace rt
