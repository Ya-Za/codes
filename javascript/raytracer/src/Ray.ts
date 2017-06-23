import { Vector, Point } from "./Vector";

export class Ray {
    start: Point;
    dir: Vector;// todo: Add `stop` to properties because I think the distance
    // between `start` and `stop` is important! for example when we want to know
    // if an object is ahead or back of image plane.

    constructor(start: Point, dir: Vector) {
        this.start = start;
        this.dir = Vector.unit(dir);
    }
}
