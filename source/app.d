import std.stdio;
import vec3;
import color;
import ray;

immutable ASPECT_RATIO = 16.0 / 9.0;
immutable IMAGE_WIDTH = 256;
immutable IMAGE_HEIGHT = 256;
immutable VIEWPORT_HEIGHT = 2.0;
immutable VIEWPORT_WIDTH = ASPECT_RATIO * VIEWPORT_HEIGHT;
immutable FOCAL_LENGTH = 1.0;
immutable ORIGIN = cast(immutable)(new Point3(0, 0, 0));
immutable HORIZONTAL = cast(immutable)(new Vec3(VIEWPORT_WIDTH, 0, 0));
immutable VERTICAL = cast(immutable)(new Vec3(0, VIEWPORT_HEIGHT, 0));
immutable LOWER_LEFT_CORNER = cast(immutable)(
	ORIGIN - HORIZONTAL / 2 - VERTICAL / 2 - new Vec3(0, 0, FOCAL_LENGTH));

immutable PROGRESS_MSG = "Scanlines remaining: ";
immutable PROGRESS_MSG_SIZE = PROGRESS_MSG.length + 1;

Color rayColor(const Ray r)
{
	Vec3 unitDirection = r.direction().unitVector();
	auto t = 0.5 * (unitDirection.y() + 1);
	return (1 - t) * new Color(1, 1, 1) + t * new Color(0.5, 0.7, 1.0);
}

void main()
{
	writeln("P3");
	writeln(IMAGE_WIDTH, ' ', IMAGE_HEIGHT);
	writeln(255);
	stderr.write(PROGRESS_MSG);

	foreach_reverse (int j; 0 .. IMAGE_HEIGHT)
	{
		stderr.write("\x1b[?25l\x1b[", PROGRESS_MSG_SIZE, "G\x1b[K", j, "\x1b[?25h");
		stderr.flush();
		foreach (int i; 0 .. IMAGE_WIDTH)
		{
			immutable u = cast(double)(i) / (IMAGE_WIDTH - 1);
			immutable v = cast(double)(j) / (IMAGE_HEIGHT - 1);
			immutable r = cast(immutable)(new Ray(ORIGIN, LOWER_LEFT_CORNER + u * HORIZONTAL + v * VERTICAL - ORIGIN));
			immutable pixelColor = cast(immutable) rayColor(r);
			writeColor(stdout, pixelColor);
		}
	}

	stderr.writeln("\nDone.");
}
