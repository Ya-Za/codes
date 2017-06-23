import { Ray } from "./Ray";
import { Thing } from "./Thing";
import { Vector, Point } from "./Vector";

export class Intersection {
    ray: Ray;
    thing: Thing;
    distance: number;

    constructor(ray: Ray, thing: Thing, distance: number) {
        this.ray = ray;
        this.thing = thing;
        this.distance = distance;
    }

    pos(): Point {
        return Vector.add(
            this.ray.start,
            Vector.mul(
                this.distance,
                this.ray.dir
            )
        );
    }
}