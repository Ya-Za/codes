import { Vector } from "./Vector";

export class Color {
    r: number;
    g: number;
    b: number;

    constructor(r: number, g: number, b: number) {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    toDrawable() {
        function legalize(intensity: number): number {
            if (intensity < 0) return 0;
            if (intensity > 1) return 1;
            return intensity;
        }

        return new Color(
            Math.floor(legalize(this.r) * 255),
            Math.floor(legalize(this.g) * 255),
            Math.floor(legalize(this.b) * 255)
        );
    }

    toString(): string {
        let color = this.toDrawable();
        return `rgb(${color.r}, ${color.g}, ${color.b})`;
    }

    static black = new Color(0, 0, 0);
    static gray = new Color(0.5, 0.5, 0.5);
    static white = new Color(1, 1, 1);

    static default = Color.black;
    static background = Color.black;

    static toVector(c: Color) {
        return new Vector(c.r, c.g, c.b);
    }

    static fromVector(v: Vector) {
        return new Color(v.x, v.y, v.z);
    }

    static add(c1: Color, c2: Color) {
        let v1 = Color.toVector(c1);
        let v2 = Color.toVector(c2);

        return Color.fromVector(
            Vector.add(v1, v2)
        )
    }

    static mul(c1: number | Color, c2: Color) {
        let v1: number | Vector;
        if (typeof (c1) === "number") {
            v1 = c1 as number;
        } else {
            v1 = Color.toVector(c1);
        }
        let v2 = Color.toVector(c2);

        return Color.fromVector(
            Vector.mul(v1, v2)
        )
    }

    static sum(...colors: Color[]): Color {
        return colors.reduce(
            Color.add,
            new Color(0, 0, 0)
        );
    }
}
