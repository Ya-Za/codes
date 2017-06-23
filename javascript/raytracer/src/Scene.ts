import { CheckerBoard, Shiny } from "./Surface";
import { Plane, Sphere } from "./Thing";
import { Point, Vector } from "./Vector";

import { Camera } from "./Camera";
import { Color } from "./Color";
import { Intersection } from "./Intersection";
import { Light } from "./Light";
import { Ray } from "./Ray";
import { Thing } from "./Thing";

export class Scene {
    things: Thing[];
    lights: Light[];
    camera: Camera;

    constructor(things: Thing[], lights: Light[], camera: Camera) {
        this.things = things;
        this.lights = lights;
        this.camera = camera;
    }

    intersect(ray: Ray): Intersection | null {
        let distance_: number = Infinity;
        let thing_: Thing | null = null; // todo: we can use `undefined` instead of `null` and after that we can
        // define `intersection: Intersection = undefined`. No, sorry. because we need to use 
        // `new Intersecton(... undefined, ...)

        for (let thing of this.things) {
            let intersection = thing.intersect(ray);
            if (intersection !== null) {
                intersection = intersection as Intersection;
                if (intersection.distance < distance_) {
                    distance_ = intersection.distance;
                    thing_ = thing;
                }
            }
        }

        if (distance_ === Infinity) {
            return null;
        } else {
            return new Intersection(ray, thing_ as Thing, distance_);
        }
    }

    isInShadow(point: Point, light: Light): boolean {
        let l = Vector.sub(light.pos, point);
        let intersection = this.intersect(new Ray(point, l));
        if (intersection === null) {
            return false;
        }

        return (<Intersection>intersection).distance < Vector.norm(l);
    }
}
