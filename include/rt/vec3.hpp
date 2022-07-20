#pragma once

#include "weekend.hpp"

#include <cmath>
#include <ostream>

namespace rt {

class vec3 {
  double m_e[3];

public:
  constexpr vec3() : m_e{0, 0, 0} {}
  constexpr vec3(double e0, double e1, double e2) : m_e{e0, e1, e2} {}

  [[nodiscard]] constexpr double x() const {
    return m_e[0];
  }
  [[nodiscard]] constexpr double y() const {
    return m_e[1];
  }
  [[nodiscard]] constexpr double z() const {
    return m_e[2];
  }

  constexpr vec3 operator-() const {
    return {-m_e[0], -m_e[1], -m_e[2]};
  }
  constexpr double operator[](int i) const {
    return m_e[i];
  }
  constexpr double& operator[](int i) {
    return m_e[i];
  }

  constexpr vec3& operator+=(const vec3& v) {
    m_e[0] += v.m_e[0];
    m_e[1] += v.m_e[1];
    m_e[2] += v.m_e[2];
    return *this;
  }

  constexpr vec3& operator*=(double t) {
    m_e[0] *= t;
    m_e[1] *= t;
    m_e[2] *= t;
    return *this;
  }

  constexpr vec3& operator/=(double t) {
    m_e[0] /= t;
    m_e[1] /= t;
    m_e[2] /= t;
    return *this;
  }

  [[nodiscard]] inline double length() const {
    return std::sqrt(length_squared());
  }

  [[nodiscard]] constexpr double length_squared() const {
    return m_e[0] * m_e[0] + m_e[1] * m_e[1] + m_e[2] * m_e[2];
  }

  [[nodiscard]] static inline vec3 random() {
    return {random_double(), random_double(), random_double()};
  }

  [[nodiscard]] static inline vec3 random(double min, double max) {
    return {
        random_double(min, max),
        random_double(min, max),
        random_double(min, max),
    };
  }

  [[nodiscard]] static inline vec3 random_in_unit_sphere() {
    vec3 p;
    do {
      p = vec3::random(-1, 1);
    } while (p.length_squared() > 1);
    return p;
  }

  [[nodiscard]] constexpr bool near_zero() const {
    constexpr double s = 1e-8;
    return std::abs(m_e[0]) < s && std::abs(m_e[1]) < s && std::abs(m_e[2]) < s;
  }
};

using point3 = vec3;
using color = vec3;

inline std::ostream& operator<<(std::ostream& os, const vec3& v) {
  return os << v.x() << ' ' << v.y() << ' ' << v.z();
}

constexpr vec3 operator+(const vec3& u, const vec3& v) {
  return {u.x() + v.x(), u.y() + v.y(), u.z() + v.z()};
}

constexpr vec3 operator-(const vec3& u, const vec3& v) {
  return {u.x() - v.x(), u.y() - v.y(), u.z() - v.z()};
}

// component multiplication
constexpr vec3 operator*(const vec3& u, const vec3& v) {
  return {u.x() * v.x(), u.y() * v.y(), u.z() * v.z()};
}

constexpr vec3 operator*(double t, const vec3& v) {
  return {t * v.x(), t * v.y(), t * v.z()};
}

constexpr vec3 operator*(const vec3& v, double t) {
  return t * v;
}

constexpr vec3 operator/(const vec3& v, double t) {
  return (1.0 / t) * v;
}

constexpr double dot(const vec3& u, const vec3& v) {
  return u.x() * v.x() + u.y() * v.y() + u.z() * v.z();
}

constexpr vec3 cross(const vec3& u, const vec3& v) {
  return {
      u.y() * v.z() - u.z() * v.y(),
      u.z() * v.x() - u.x() * v.z(),
      u.x() * v.y() - u.y() * v.x(),
  };
}

inline vec3 unit_vector(const vec3& v) {
  return v / v.length();
}

inline vec3 random_unit_vector() {
  return unit_vector(vec3::random_in_unit_sphere());
}

constexpr vec3 reflect(const vec3& v, const vec3& n) {
  return v - 2 * dot(v, n) * n;
}

} // namespace rt
