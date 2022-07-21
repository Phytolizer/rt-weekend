use std::io::{stderr, stdout, Write};

use crate::{color::write_color, vec3::Color};

mod color;
mod vec3;

const IMAGE_WIDTH: usize = 256;
const IMAGE_HEIGHT: usize = 256;
const PROGRESS_MESSAGE: &str = "Scanlines remaining: ";
const PROGRESS_MSG_SIZE: usize = PROGRESS_MESSAGE.len() + 1;

fn main() {
    println!("P3");
    println!("{IMAGE_WIDTH} {IMAGE_HEIGHT}");
    println!("255");
    eprint!("{PROGRESS_MESSAGE}");

    for j in (0..IMAGE_HEIGHT).rev() {
        eprint!("\x1b[?25l\x1b[{PROGRESS_MSG_SIZE}G\x1b[K{j}\x1b[?25h");
        stderr().flush().unwrap();
        for i in 0..IMAGE_WIDTH {
            let pixel_color = Color::new(
                (i as f64) / ((IMAGE_WIDTH - 1) as f64),
                (j as f64) / ((IMAGE_HEIGHT - 1) as f64),
                0.25,
            );
            write_color(&mut stdout(), &pixel_color).unwrap();
        }
    }

    eprintln!("\nDone.");
}
