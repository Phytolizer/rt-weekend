module ray;
import vec3;

class Ray
{
    private Point3 m_origin;
    private Vec3 m_direction;

    this(const Point3 origin, const Vec3 direction)
    {
        m_origin = new Point3(origin);
        m_direction = new Vec3(direction);
    }

    const(Point3) origin() const
    {
        return m_origin;
    }

    const(Vec3) direction() const
    {
        return m_direction;
    }

    Point3 at(double t) const
    {
        return m_origin + t * m_direction;
    }
}
