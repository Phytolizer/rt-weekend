#include "rt/camera.hpp"
#include "rt/color.hpp"
#include "rt/hittable.hpp"
#include "rt/hittable_list.hpp"
#include "rt/lambertian.hpp"
#include "rt/material.hpp"
#include "rt/metal.hpp"
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
    if (auto scatter = rec->mat_ptr->scatter(r, *rec); scatter) {
      return scatter->attenuation *
          ray_color(scatter->scattered, world, depth - 1);
    }

    return rt::color{0, 0, 0};
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
  constexpr rt::color ground_color{0.8, 0.8, 0.0};
  auto material_ground = std::make_shared<rt::lambertian>(ground_color);
  constexpr rt::color center_color{0.7, 0.3, 0.3};
  auto material_center = std::make_shared<rt::lambertian>(center_color);
  constexpr rt::color left_color{0.8, 0.8, 0.8};
  auto material_left = std::make_shared<rt::metal>(left_color);
  constexpr rt::color right_color{0.8, 0.6, 0.2};
  auto material_right = std::make_shared<rt::metal>(right_color);

  world.add(std::make_unique<rt::sphere>(
      rt::point3{0.0, -100.5, -1.0}, 100.0, material_ground));
  world.add(std::make_unique<rt::sphere>(
      rt::point3{0.0, 0.0, -1.0}, 0.5, material_center));
  world.add(std::make_unique<rt::sphere>(
      rt::point3{-1.0, 0.0, -1.0}, 0.5, material_left));
  world.add(std::make_unique<rt::sphere>(
      rt::point3{1.0, 0.0, -1.0}, 0.5, material_right));

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
