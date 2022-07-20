import std.stdio;

immutable int IMAGE_WIDTH = 256;
immutable int IMAGE_HEIGHT = 256;

immutable string PROGRESS_MSG = "Scanlines remaining: ";
immutable int PROGRESS_MSG_SIZE = PROGRESS_MSG.length + 1;

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
			auto r = cast(double)(i) / (IMAGE_WIDTH - 1);
			auto g = cast(double)(j) / (IMAGE_HEIGHT - 1);
			auto b = 0.25;

			auto ir = cast(int)(255.999 * r);
			auto ig = cast(int)(255.999 * g);
			auto ib = cast(int)(255.999 * b);

			writeln(ir, ' ', ig, ' ', ib);
		}
	}

	stderr.writeln("\nDone.");
}
