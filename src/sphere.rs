use crate::{
    hittable::{HitRecord, Hittable},
    vec3::{dot, Point3},
};

pub(crate) struct Sphere {
    center: Point3,
    radius: f64,
}

impl Sphere {
    pub(crate) fn new(center: Point3, radius: f64) -> Self {
        Self { center, radius }
    }

    pub(crate) fn center(&self) -> &Point3 {
        return &self.center;
    }

    pub(crate) fn radius(&self) -> f64 {
        return self.radius;
    }
}

impl Hittable for Sphere {
    fn hit(&self, r: &crate::ray::Ray, t_min: f64, t_max: f64) -> Option<HitRecord> {
        let oc = *r.origin() - self.center;
        let a = r.direction().length_squared();
        let half_b = dot(&oc, r.direction());
        let c = oc.length_squared() - self.radius * self.radius;
        let discriminant = half_b * half_b - a * c;
        if discriminant < 0.0 {
            return None;
        }
        let sqrtd = discriminant.sqrt();

        let mut root = (-half_b - sqrtd) / a;
        if root < t_min || t_max < root {
            root = (-half_b + sqrtd) / a;
            if root < t_min || t_max < root {
                return None;
            }
        }

        let t = root;
        let p = r.at(t);
        let normal = (p - self.center) / self.radius;
        Some(HitRecord::new(p, t, r, normal))
    }
}
