import { Point, Vector } from "./Vector";

import { Intersection } from "./Intersection";
import { Ray } from "./Ray";
import { Surface } from "./Surface";

// todo: difference between `class` and `interfac` in initialization? for example
// is it possible to initial a class with this assignment: obj = {...}
export interface Thing {
    normal: (point: Point) => Vector;
    intersect: (ray: Ray) => Intersection | null; // todo: which one is better? `null` or `undefined`
    surface: Surface;
}

export class Sphere implements Thing {
    center: Point;
    radius: number;
    surface: Surface;

    constructor(center: Point, radius: number, surface: Surface) {
        this.center = center;
        this.radius = radius;
        this.surface = surface;
    }

    normal(point: Point) {
        return Vector.sub(point, this.center);
    }

    intersect(ray: Ray): Intersection | null {
        let sc = Vector.sub(this.center, ray.start);
        let v = Vector.dot(ray.dir, sc);

        if (v <= 0) { // todo: instead of `0` we should use the more accurate value.
            return null;
        } else {
            let delta = (v * v) + (this.radius * this.radius) - Vector.dot(sc, sc);

            if (delta > 0) {
                return new Intersection(
                    ray,
                    this,
                    v - Math.sqrt(delta)
                );
            } else {
                return null;
            }
        }
    }
}

export class Plane implements Thing {
    P0: Point;
    n: Vector;
    surface: Surface;

    constructor(P0: Point, n: Vector, surface: Surface) {
        // equation of plane is `<n, P> = <n, P0>`
        this.P0 = P0;
        this.n = n;
        this.surface = surface;
    }

    normal(point: Point) {
        return this.n;
    }

    // todo: why we have to declare type of this method?
    intersect(ray: Ray): Intersection | null {
        let denominator = Vector.dot(this.n, ray.dir);
        if (denominator >= 0) {
            return null;
        } else {
            return new Intersection(
                ray,
                this,
                Vector.dot(this.n, Vector.sub(this.P0, ray.start)) / denominator
            );
        }
    }
}