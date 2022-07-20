use std::io::{stderr, Write};

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
            let r = (i as f64) / ((IMAGE_WIDTH - 1) as f64);
            let g = (j as f64) / ((IMAGE_HEIGHT - 1) as f64);
            let b = 0.25;

            let ir = (255.999 * r) as u8;
            let ig = (255.999 * g) as u8;
            let ib = (255.999 * b) as u8;

            println!("{ir} {ig} {ib}");
        }
    }

    eprintln!("\nDone.");
}
