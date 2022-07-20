module color;
import std.stdio;
import vec3;

void writeColor(File f, const ref Color pixelColor)
{
    f.write(cast(int)(255.999 * pixelColor.x()), ' ');
    f.write(cast(int)(255.999 * pixelColor.y()), ' ');
    f.write(cast(int)(255.999 * pixelColor.z()), '\n');
}
