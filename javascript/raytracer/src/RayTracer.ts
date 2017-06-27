import { Point, Vector } from "./Vector";

import { Color } from "./Color";
import { Intersection } from "./Intersection";
import { Light } from "./Light";
import { Ray } from "./Ray";
import { Scene } from "./Scene";

export class RayTracer {
    scene: Scene; // todo: Should be a `property` or just we have `render(width, height)`
    maxDepth: Number

    constructor(scene: Scene, maxDepth: number = 5) {
        this.scene = scene;
        this.maxDepth = maxDepth;
    }

    // todo: `scene` should be an input parameter or a `property` of the class?
    getNaturalColor(intersection: Intersection): Color {
        let color = Color.default;

        let pos = intersection.pos();
        let n = intersection.thing.normal(pos);
        let R = Vector.reflect(intersection.ray.dir, n);
        let scolor = intersection.thing.surface.specular(pos);
        let dcolor = intersection.thing.surface.diffuse(pos);
        let roughness = intersection.thing.surface.roughness;

        for (let light of this.scene.lights) {
            if (!this.scene.isInShadow(pos, light)) {
                let l = Vector.unit(Vector.sub(light.pos, pos));
                // specular
                let specularColor = Color.default;
                let ks = Vector.dot(l, R);
                if (ks > 0) {
                    specularColor = Color.mul(
                        scolor,
                        Color.mul(
                            Math.pow(ks, roughness),
                            light.color
                        )
                    );
                }
                // diffues
                let diffuseColor = Color.default;
                let kd = Vector.dot(l, n);
                if (kd > 0) {
                    diffuseColor = Color.mul(
                        dcolor,
                        Color.mul(
                            kd,
                            light.color
                        )
                    );
                }
                // color
                color = Color.sum(color, specularColor, diffuseColor);
            }
        }

        return color;
    }

    getReflectedColor(intersection: Intersection, depth: number): Color {
        if (depth >= this.maxDepth) {
            return Color.gray; // todo: `gray` or `default`
        }

        let R = Vector.reflect(
            intersection.ray.dir,
            intersection.thing.normal(intersection.pos())
        );

        return this.trace(new Ray(intersection.pos(), R), depth + 1)
    }

    shade(intersection: Intersection, depth: number): Color {
        return Color.add(
            this.getReflectedColor(intersection, depth),
            this.getNaturalColor(intersection)
        );
    }

    trace(ray: Ray, depth: number): Color {
        let intersection = this.scene.intersect(ray);
        if (intersection !== null) {
            intersection = intersection as Intersection;
            return this.shade(intersection, depth);
        } else {
            return Color.background;
        }
    }

    render(canvas: HTMLCanvasElement): string {
        let camera = this.scene.camera;
        let width = canvas.width;
        let height = canvas.height;
        let ctx = canvas.getContext("2d") as CanvasRenderingContext2D;

        let text: string[] = [];
        for (let { x, y, ray } of camera.rays(width, height)) {
            ctx.fillStyle = this.trace(ray, 0).toString();
            ctx.fillRect(x, y, 1, 1);

            // text.push(`${ray.dir.x}, ${ray.dir.y}, ${ray.dir.z}\n`)
        }

        return text.join("");
    }
}
