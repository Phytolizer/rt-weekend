const std = @import("std");
const Color = @import("Vec3.zig");

pub fn writeColor(out: anytype, color: Color) !void {
    try out.writeAll(&[_]u8{
        @floatToInt(u8, 255.999 * color.e[0]),
        @floatToInt(u8, 255.999 * color.e[1]),
        @floatToInt(u8, 255.999 * color.e[2]),
    });
}
