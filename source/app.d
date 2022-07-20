import std.stdio;

immutable int IMAGE_WIDTH = 256;
immutable int IMAGE_HEIGHT = 256;

void main()
{
	writeln("P3");
	writeln(IMAGE_WIDTH, ' ', IMAGE_HEIGHT);
	writeln(255);

	foreach_reverse (int j; 0 .. IMAGE_HEIGHT)
	{
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
}
