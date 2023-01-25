#![allow(dead_code)]

use std::{
    fs::File,
    io::{stderr, Write},
    rc::Rc,
};

use hittable::Hittable;
use hittable_list::HittableList;
use ray::Ray;
use vec3::{Point3, Vec3};

use crate::{color::write_color, sphere::Sphere, vec3::Color};

mod color;
mod hittable;
mod hittable_list;
mod ray;
mod sphere;
mod vec3;

const ASPECT_RATIO: f64 = 16.0 / 9.0;
const IMAGE_WIDTH: usize = 400;
const IMAGE_HEIGHT: usize = (IMAGE_WIDTH as f64 / ASPECT_RATIO) as usize;
const VIEWPORT_HEIGHT: f64 = 2.0;
const VIEWPORT_WIDTH: f64 = ASPECT_RATIO * VIEWPORT_HEIGHT;
const FOCAL_LENGTH: f64 = 1.0;
const ORIGIN: Point3 = Point3::new(0.0, 0.0, 0.0);
const HORIZONTAL: Vec3 = Vec3::new(VIEWPORT_WIDTH, 0.0, 0.0);
const VERTICAL: Vec3 = Vec3::new(0.0, VIEWPORT_HEIGHT, 0.0);
const PROGRESS_MESSAGE: &str = "Scanlines remaining: ";
const PROGRESS_MSG_SIZE: usize = PROGRESS_MESSAGE.len() + 1;

fn ray_color(r: &Ray, world: &HittableList) -> Color {
    if let Some(rec) = world.hit(r, 0.0, f64::INFINITY) {
        return 0.5 * (rec.normal + Color::new(1.0, 1.0, 1.0));
    }
    let unit_direction = r.direction().unit_vector();
    let t = 0.5 * (unit_direction.y() + 1.0);
    (1.0 - t) * Color::new(1.0, 1.0, 1.0) + t * Color::new(0.5, 0.7, 1.0)
}

fn main() {
    let lower_left_corner =
        ORIGIN - HORIZONTAL / 2.0 - VERTICAL / 2.0 - Vec3::new(0.0, 0.0, FOCAL_LENGTH);

    let args = std::env::args().collect::<Vec<_>>();
    let out_path = if args.len() == 1 {
        "image.ppm"
    } else {
        &args[1]
    };
    let mut out_file = File::create(out_path).unwrap();

    let mut world = HittableList::new();
    world.add(Rc::new(Sphere::new(Point3::new(0.0, 0.0, -1.0), 0.5)));
    world.add(Rc::new(Sphere::new(Point3::new(0.0, -100.5, -1.0), 100.0)));

    writeln!(out_file, "P3").unwrap();
    writeln!(out_file, "{IMAGE_WIDTH} {IMAGE_HEIGHT}").unwrap();
    writeln!(out_file, "255").unwrap();
    eprint!("{PROGRESS_MESSAGE}");

    for j in (0..IMAGE_HEIGHT).rev() {
        eprint!("\x1b[?25l\x1b[{PROGRESS_MSG_SIZE}G\x1b[K{j}\x1b[?25h");
        stderr().flush().unwrap();
        for i in 0..IMAGE_WIDTH {
            let u = i as f64 / (IMAGE_WIDTH - 1) as f64;
            let v = j as f64 / (IMAGE_HEIGHT - 1) as f64;
            let r = Ray::new(
                ORIGIN,
                lower_left_corner + u * HORIZONTAL + v * VERTICAL - ORIGIN,
            );
            let pixel_color = ray_color(&r, &world);
            write_color(&mut out_file, &pixel_color).unwrap();
        }
    }

    eprintln!("\nDone.");
}
