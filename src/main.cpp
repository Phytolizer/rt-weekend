#include "rt/camera.hpp"
#include "rt/color.hpp"
#include "rt/hittable.hpp"
#include "rt/hittable_list.hpp"
#include "rt/ray.hpp"
#include "rt/sphere.hpp"
#include "rt/vec3.hpp"

#include <array>
#include <cstdint>
#include <iostream>

rt::color
ray_color(const rt::ray& r, const rt::hittable& world, std::size_t depth) {
  constexpr rt::color white{1.0, 1.0, 1.0};
  constexpr rt::color sky_blue{0.5, 0.7, 1.0};

  if (depth == 0) {
    return rt::color{0.0, 0.0, 0.0};
  }

  constexpr double min_distance = 0.001;
  if (auto rec = world.hit(r, min_distance, rt::INFINITE); rec) {
    rt::point3 target =
        rec->p + rec->normal + rt::random_unit_vector();
    return ray_color(rt::ray{rec->p, target - rec->p}, world, depth - 1) / 2;
  }

  constexpr double half_pixel = 0.5;

  rt::vec3 unit_direction = rt::unit_vector(r.direction());
  double t = half_pixel * (unit_direction.y() + 1.0);
  return (1.0 - t) * white + t * sky_blue;
}

int main() {
  // Image
  constexpr double aspect = 16.0 / 9.0;
  constexpr int image_width = 400;
  constexpr int image_height = static_cast<int>(image_width / aspect);
  constexpr const char progress_msg[] = "Scanlines remaining: ";
  constexpr int samples_per_pixel = 100;
  constexpr std::size_t max_depth = 50;

  // Camera
  rt::camera cam;

  // World
  rt::hittable_list world;
  constexpr std::array sphere_positions{
      rt::point3{0, 0, -1},
      rt::point3{0, -100.5, -1},
  };
  constexpr std::array sphere_radii{
      0.5,
      100.0,
  };
  static_assert(sphere_positions.size() == sphere_radii.size());
  for (std::size_t i = 0; i < sphere_positions.size(); ++i) {
    world.add(
        std::make_unique<rt::sphere>(sphere_positions[i], sphere_radii[i]));
  }

  std::cout << "P3\n" << image_width << ' ' << image_height << "\n255\n";

  std::cerr << progress_msg;

  for (int j = image_height - 1; j >= 0; j--) {
    std::cerr << "\x1b[?25l\x1b[" << sizeof(progress_msg) << "G\x1b[K" << j
              << "\x1b[?25h" << std::flush;
    for (int i = 0; i < image_width; i++) {
      rt::color pixel_color{0, 0, 0};
      for (int s = 0; s < samples_per_pixel; ++s) {
        auto u = (i + rt::random_double()) / (image_width - 1);
        auto v = (j + rt::random_double()) / (image_height - 1);
        rt::ray r = cam.get_ray(u, v);
        pixel_color += ray_color(r, world, max_depth);
      }
      rt::write_color(std::cout, pixel_color, samples_per_pixel);
    }
  }
  std::cerr << "\nDone.\n";
}
