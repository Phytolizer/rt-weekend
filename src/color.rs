use std::io;

use crate::vec3::Color;

pub(crate) fn write_color<O>(out: &mut O, pixel_color: &Color) -> io::Result<()>
where
    O: std::io::Write,
{
    writeln!(
        out,
        "{} {} {}",
        (255.999 * pixel_color.x()) as i32,
        (255.999 * pixel_color.y()) as i32,
        (255.999 * pixel_color.z()) as i32
    )
}
