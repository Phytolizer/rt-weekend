module vec3;
import std.math;
import std.string;

class Vec3
{
    private double[3] e;

    this()
    {
        this(0, 0, 0);
    }

    this(double x, double y, double z)
    {
        e = [x, y, z];
    }

    double x() const
    {
        return e[0];
    }

    double y() const
    {
        return e[1];
    }

    double z() const
    {
        return e[2];
    }

    Vec3 opUnary(string op : "-")() const
    {
        return Vec3(-x(), -y(), -z());
    }

    double opIndex(int i) const
    {
        return e[i];
    }

    ref double opIndex(int i)
    {
        return e[i];
    }

    ref Vec3 opOpAssign(string op : "+")(const ref Vec3 v)
    {
        e[0] += v.e[0];
        e[1] += v.e[1];
        e[2] += v.e[2];
        return this;
    }

    ref Vec3 opOpAssign(string op : "*")(double t)
    {
        e[0] *= t;
        e[1] *= t;
        e[2] *= t;
        return this;
    }

    ref Vec3 opOpAssign(string op : "/")(double t)
    {
        return this * (1 / t);
    }

    double length() const
    {
        return sqrt(lengthSquared());
    }

    double lengthSquared() const
    {
        return x() * x() + y() * y() + z() * z();
    }

    override string toString() const
    {
        return format("%f %f %f", e[0], e[1], e[2]);
    }

    Vec3 opBinary(string op : "+")(const ref Vec3 v) const
    {
        return new Vec3(e[0] + v.e[0], e[1] + v.e[1], e[2] + v.e[2]);
    }

    Vec3 opBinary(string op : "-")(const ref Vec3 v) const
    {
        return new Vec3(e[0] - v.e[0], e[1] - v.e[1], e[2] - v.e[2]);
    }

    Vec3 opBinary(string op : "*")(const ref Vec3 v) const
    {
        return new Vec3(e[0] * v.e[0], e[1] * v.e[1], e[2] * v.e[2]);
    }

    Vec3 opBinary(string op : "*")(double t) const
    {
        return new Vec3(e[0] * t, e[1] * t, e[2] * t);
    }

    Vec3 opBinaryRight(string op : "*")(double t) const
    {
        return this * t;
    }

    Vec3 opBinary(string op : "/")(double t) const
    {
        return new Vec3(e[0] / t, e[1] / t, e[2] / t);
    }

    double dot(const ref Vec3 v) const
    {
        return e[0] * v.e[0] + e[1] * v.e[1] + e[2] * v.e[2];
    }

    Vec3 cross(const ref Vec3 v) const
    {
        return new Vec3(
            e[1] * v.e[2] - e[2] * v.e[1],
            e[2] * v.e[0] - e[0] * v.e[2],
            e[0] * v.e[1] - e[1] * v.e[0],
        );
    }

    Vec3 unitVector() const
    {
        return this / length();
    }
}

alias Point3 = Vec3;
alias Color = Vec3;
