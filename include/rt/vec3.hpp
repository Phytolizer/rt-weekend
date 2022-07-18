#pragma once

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

constexpr vec3 unit_vector(const vec3& v) {
  return v / v.length();
}

} // namespace rt
