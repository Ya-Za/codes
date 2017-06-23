import { Point, Vector } from "./Vector";

import { Ray } from "./Ray";

export class Camera {
    pos: Point;
    right: Vector;
    up: Vector;
    forward: Vector;

    constructor(pos: Point, lookAt: Vector) {
        this.pos = pos;

        this.forward = Vector.unit(
            Vector.sub(lookAt, pos)
        );

        let j = new Vector(0, 1, 0); // i, `j`, k unit vectors
        this.right = Vector.unit(
            Vector.cross(j, this.forward)
        );

        this.up = Vector.unit(
            Vector.cross(this.forward, this.right)
        );
    }

    // todo: add principal point `(ox, oy)`
    *rays(
        width: number,
        height: number,
        sx: number = 0,
        sy: number = 0,
        f: number = 1
    ) {
        if (sx === 0) {
            sx = width;
        }

        if (sy === 0) {
            sy = height;
        }

        let halfWidth = width / 2;
        let halfHeight = height / 2;
        for (let y = 0; y < height; y++) {
            for (let x = 0; x < width; x++) {
                let x_ = (x - halfWidth) / sx;
                let y_ = (-y + halfHeight) / sy;
                let ray = new Ray(
                    this.pos,
                    Vector.sum(
                        Vector.mul(x_, this.right),
                        Vector.mul(y_, this.up),
                        Vector.mul(f, this.forward)
                    )
                );
                
                yield {x, y, ray};
            }
        }
    }
}
