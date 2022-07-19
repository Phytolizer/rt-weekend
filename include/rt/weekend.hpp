#pragma once

#include <limits>
#include <random>

namespace rt {

constexpr double ALMOST_ONE = 0.999;
constexpr double ALMOST_FULL = 255 + ALMOST_ONE;
constexpr double FULL = 256;
constexpr double INFINITE = std::numeric_limits<double>::infinity();
constexpr double PI = 3.1415926535897932385;

constexpr double degrees_to_radians(double degrees) {
  constexpr double half_turn = 180.0;
  return degrees * PI / half_turn;
}

inline double random_double(double min, double max) {
  static std::random_device rd{};
  static std::default_random_engine eng{rd()};
  return std::uniform_real_distribution<double>{min, max}(eng);
}

inline double random_double() {
  return random_double(0, 1);
}

template <typename T> constexpr T clamp(T x, T min, T max) {
  if (x < min) {
    return min;
  }
  if (x > max) {
    return max;
  }
  return x;
}

} // namespace rt
