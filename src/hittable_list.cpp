#include "rt/hittable_list.hpp"

std::optional<rt::hit_record>
rt::hittable_list::hit(const ray& r, double t_min, double t_max) const {
  std::optional<hit_record> rec = std::nullopt;
  double closest_so_far = t_max;

  for (const auto& object : m_objects) {
    if (auto temp_rec = object->hit(r, t_min, closest_so_far); temp_rec) {
      closest_so_far = temp_rec->t;
      rec = temp_rec;
    }
  }

  return rec;
}
