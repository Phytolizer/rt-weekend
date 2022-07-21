use crate::vec3::{Point3, Vec3};

pub(crate) struct Ray {
    origin: Point3,
    direction: Vec3,
}

impl Default for Ray {
    fn default() -> Self {
        Self {
            origin: Point3::default(),
            direction: Vec3::default(),
        }
    }
}

impl Ray {
    pub(crate) fn new(origin: Point3, direction: Vec3) -> Self {
        Self { origin, direction }
    }

    pub(crate) fn origin(&self) -> &Point3 {
        &self.origin
    }

    pub(crate) fn direction(&self) -> &Vec3 {
        &self.direction
    }

    pub(crate) fn at(&self, t: f64) -> Point3 {
        self.origin + t * self.direction
    }
}
