#include "rt/sphere.hpp"

std::optional<rt::hit_record>
rt::sphere::hit(const ray& r, double t_min, double t_max) const {
  vec3 oc = r.origin() - m_center;
  double a = r.direction().length_squared();
  double half_b = dot(oc, r.direction());
  double c = oc.length_squared() - m_radius * m_radius;

  double discriminant = half_b * half_b - a * c;
  if (discriminant < 0) {
    return {};
  }

  double sqrtd = std::sqrt(discriminant);

  double root = (-half_b - sqrtd) / a;
  if (t_min > root || root > t_max) {
    root = (-half_b + sqrtd) / a;
    if (t_min > root || root > t_max) {
      return std::nullopt;
    }
  }

  hit_record result;
  result.t = root;
  result.p = r.at(result.t);
  vec3 outward_normal = (result.p - m_center) / m_radius;
  result.set_face_normal(r, outward_normal);
  result.mat_ptr = m_mat_ptr;
  return result;
}
