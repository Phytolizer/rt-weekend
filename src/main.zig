const std = @import("std");
const Vec3 = @import("Vec3.zig");
const Point3 = Vec3;
const Color = Vec3;
const Ray = @import("Ray.zig");
const writeColor = @import("color.zig").writeColor;

fn rayColor(r: Ray) Color {
    const unit_direction = r.direction.unit();
    const t = 0.5 * unit_direction.e[1] + 1.0;
    return Color.init(1.0, 1.0, 1.0).scale(1.0 - t)
        .add(Color.init(0.5, 0.7, 1.0).scale(t));
}

pub fn main() !void {
    std.testing.refAllDeclsRecursive(@This());

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const a = gpa.allocator();

    const args = try std.process.argsAlloc(a);
    const output_path = switch (args.len) {
        1 => "image.ppm",
        2 => args[1],
        else => return error.Usage,
    };

    const output_file = try std.fs.cwd().createFile(output_path, .{});
    defer output_file.close();
    const output = output_file.writer();

    const aspect_ratio = 16.0 / 9.0;
    const image_width = 400;
    const image_height = @floatToInt(
        comptime_int,
        @intToFloat(comptime_float, image_width) / aspect_ratio,
    );

    const viewport_height = 2.0;
    const viewport_width = aspect_ratio * viewport_height;
    const focal_length = 1.0;

    const origin = Point3.init(0.0, 0.0, 0.0);
    const horizontal = Vec3.init(viewport_width, 0.0, 0.0);
    const vertical = Vec3.init(0.0, viewport_height, 0.0);
    const lower_left_corner = origin
        .sub(horizontal.scaleInv(2))
        .sub(vertical.scaleInv(2))
        .sub(Vec3.init(0.0, 0.0, focal_length));

    try output.print("P6\n{d} {d}\n255\n", .{ image_width, image_height });
    var j: usize = image_height;
    while (j > 0) : (j -= 1) {
        std.debug.print("\x1b[G\x1b[KScanlines remaining: {d}", .{j});
        var i: usize = 0;
        while (i < image_width) : (i += 1) {
            const u = @intToFloat(f64, i) / (image_width - 1);
            const v = @intToFloat(f64, j - 1) / (image_height - 1);
            const r = Ray.init(
                origin,
                lower_left_corner
                    .add(horizontal.scale(u))
                    .add(vertical.scale(v))
                    .sub(origin),
            );
            const pixel_color = rayColor(r);
            try writeColor(output, pixel_color);
        }
    }
    std.debug.print("\nDone.\n", .{});
}
