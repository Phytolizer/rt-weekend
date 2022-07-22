internal static class Program
{
    private const int IMAGE_WIDTH = 256;
    private const int IMAGE_HEIGHT = 256;

    private static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.Error.WriteLine("Usage: rt-weekend <file>");
            Environment.ExitCode = 1;
            return;
        }
        using var file = File.CreateText(args[0]);

        file.WriteLine("P3");
        file.WriteLine($"{IMAGE_WIDTH} {IMAGE_HEIGHT}");
        file.WriteLine("255");

        foreach (var j in Enumerable.Range(0, IMAGE_HEIGHT).Reverse())
        {
            foreach (var i in Enumerable.Range(0, IMAGE_WIDTH))
            {
                var r = (double)i / (IMAGE_WIDTH - 1);
                var g = (double)j / (IMAGE_HEIGHT - 1);
                var b = 0.25;

                var ir = (int)(255.999 * r);
                var ig = (int)(255.999 * g);
                var ib = (int)(255.999 * b);

                file.WriteLine($"{ir} {ig} {ib}");
            }
        }
    }
}
