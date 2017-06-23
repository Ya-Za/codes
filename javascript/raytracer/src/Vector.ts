export class Vector {
    x: number;
    y: number;
    z: number;

    constructor(x: number, y: number, z: number) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    static add(v1: Vector, v2: Vector) {
        return new Vector(
            v1.x + v2.x,
            v1.y + v2.y,
            v1.z + v2.z
        )
    }

    static sum(...v: Vector[]) {
        return v.reduce(
            Vector.add,
            new Vector(0, 0, 0)
        );
    }

    static mul(v1: number | Vector, v2: Vector): Vector {
        if (typeof (v1) === "number") {
            v1 = new Vector(v1, v1, v1);
        }

        return new Vector(
            v1.x * v2.x,
            v1.y * v2.y,
            v1.z * v2.z
        )
    }

    static neg(v: Vector) {
        return Vector.mul(-1, v);
    }

    static sub(v1: Vector, v2: Vector) {
        return Vector.add(v1, Vector.neg(v2));
    }

    static dot(v1: Vector, v2: Vector) {
        return v1.x * v2.x +
            v1.y * v2.y +
            v1.z * v2.z;
    }

    static norm(v: Vector) {
        return Math.sqrt(Vector.dot(v, v));
    }

    static dist(p1: Point, p2: Point) {
        return Vector.norm(Vector.sub(p1, p2));
    }

    static unit(v: Vector) {
        return Vector.mul(
            1 / Vector.norm(v),
            v
        );
    }

    static cross(v1: Vector, v2: Vector) {
        return new Vector(
            v1.y * v2.z - v1.z * v2.y,
            v1.z * v2.x - v1.x * v2.z,
            v1.x * v2.y - v1.y * v2.x
        );
    }

    static reflect(I: Vector, n: Vector) {
        return Vector.sub(
            I,
            Vector.mul(
                2 * Vector.dot(n, I),
                n
            )
        );
    }
}

export type Point = Vector;

