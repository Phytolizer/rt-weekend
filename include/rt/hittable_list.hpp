#pragma once

#include "hittable.hpp"

#include <memory>
#include <vector>

namespace rt {

class hittable_list final : public hittable {
  std::vector<std::unique_ptr<hittable>> m_objects;

public:
  constexpr hittable_list() = default;
  explicit inline hittable_list(std::unique_ptr<hittable> object) {
    add(std::move(object));
  }

  constexpr void clear() {
    m_objects.clear();
  }

  inline void add(std::unique_ptr<hittable> object) {
    m_objects.emplace_back(std::move(object));
  }

  [[nodiscard]] std::optional<hit_record>
  hit(const ray& r, double t_min, double t_max) const override;
};

} // namespace rt
