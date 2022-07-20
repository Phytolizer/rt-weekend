#pragma once

#include "ray.hpp"
#include "vec3.hpp"

#include <optional>

namespace rt {

struct hit_record;
struct scatter_result {
  color attenuation;
  ray scattered;
};

class material {
public:
  [[nodiscard]] virtual std::optional<scatter_result>
  scatter(const ray& r, const hit_record& rec) const = 0;
};

} // namespace rt
