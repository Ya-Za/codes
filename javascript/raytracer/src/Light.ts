import { Color } from "./Color";
import { Vector, Point } from "./Vector";

export class Light {
    pos: Point;
    color: Color;

    constructor(pos: Point, color: Color) {
        this.pos = pos;
        this.color = color;
    }
}
