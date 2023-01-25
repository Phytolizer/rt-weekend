const std = @import("std");

e: [3]Component,

const Component = f64;
const Self = @This();

pub fn init(x: Component, y: Component, z: Component) Self {
    return .{ .e = .{ x, y, z } };
}

pub fn neg(self: Self) Self {
    return init(-self.e[0], -self.e[1], -self.e[2]);
}

pub fn get(self: Self, i: usize) Component {
    return self.e[i];
}

pub fn getMut(self: *Self, i: usize) *Component {
    return &self.e[i];
}

pub fn iadd(self: *Self, v: Self) *Self {
    self.e[0] += v.e[0];
    self.e[1] += v.e[1];
    self.e[2] += v.e[2];
    return self;
}

pub fn iscale(self: *Self, t: Component) *Self {
    self.e[0] *= t;
    self.e[1] *= t;
    self.e[2] *= t;
    return self;
}

pub fn iscaleInv(self: *Self, t: Component) *Self {
    self.e[0] /= t;
    self.e[1] /= t;
    self.e[2] /= t;
    return self;
}

pub fn length(self: Self) Component {
    return std.math.sqrt(self.lengthSquared());
}

pub fn lengthSquared(self: Self) Component {
    return self.e[0] * self.e[0] +
        self.e[1] * self.e[1] +
        self.e[2] * self.e[2];
}

pub fn format(self: Self, comptime _: []const u8, _: std.fmt.FormatOptions, writer: anytype) !void {
    try writer.print("{d} {d} {d}", .{ self.e[0], self.e[1], self.e[2] });
}

pub fn add(u: Self, v: Self) Self {
    return .{ .e = .{
        u.e[0] + v.e[0],
        u.e[1] + v.e[1],
        u.e[2] + v.e[2],
    } };
}

pub fn sub(u: Self, v: Self) Self {
    return .{ .e = .{
        u.e[0] - v.e[0],
        u.e[1] - v.e[1],
        u.e[2] - v.e[2],
    } };
}

pub fn componentMul(u: Self, v: Self) Self {
    return .{ .e = .{
        u.e[0] * v.e[0],
        u.e[1] * v.e[1],
        u.e[2] * v.e[2],
    } };
}

pub fn scale(v: Self, t: Component) Self {
    return .{ .e = .{
        v.e[0] * t,
        v.e[1] * t,
        v.e[2] * t,
    } };
}

pub fn scaleInv(v: Self, t: Component) Self {
    return .{ .e = .{
        v.e[0] / t,
        v.e[1] / t,
        v.e[2] / t,
    } };
}

pub fn dot(u: Self, v: Self) Component {
    return u.e[0] * v.e[0] +
        u.e[1] * v.e[1] +
        u.e[2] * v.e[2];
}

pub fn cross(u: Self, v: Self) Self {
    return .{ .e = .{
        u.e[1] * v.e[2] - u.e[2] * v.e[1],
        u.e[2] * v.e[0] - u.e[0] * v.e[2],
        u.e[0] * v.e[1] - u.e[1] * v.e[0],
    } };
}

pub fn unit(v: Self) Self {
    return v.scaleInv(v.length());
}
