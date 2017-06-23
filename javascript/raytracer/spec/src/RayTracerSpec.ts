import { CheckerBoard, Shiny } from "../../src/Surface";
import { Plane, Sphere } from "../../src/Thing";

import { Camera } from "../../src/Camera";
import { Color } from "../../src/Color";
import { Intersection } from "../../src/Intersection";
import { Light } from "../../src/Light";
import { Ray } from "../../src/Ray";
import { RayTracer } from "../../src/RayTracer";
import { Scene } from "../../src/Scene";
import { Vector } from "../../src/Vector";

describe("RayTracer", () => {
    let scene: Scene;
    let maxDepth: number;
    let rayTracer: RayTracer;
    let ray: Ray;
    let intersection: Intersection | null;

    beforeAll(() => {
        // scene
        // - things
        let sphere = new Sphere(
            new Vector(0, 0, -2),
            1,
            Shiny
        );

        let plane = new Plane(
            new Vector(0, -1, 0),
            new Vector(0, 1, 0),
            CheckerBoard
        );

        // - lights
        let light = new Light(
            new Vector(0, 2, 0),
            new Color(1, 1, 1)
        );

        // - camera
        let camera = new Camera(
            new Vector(0, 0, 0),
            new Vector(0, 0, -1)
        );

        // - scene
        scene = new Scene(
            [sphere, plane],
            [light],
            camera
        );

        // max depth
        maxDepth = 2;

        // ray-tracer
        rayTracer = new RayTracer(scene, maxDepth);

        // ray
        ray = new Ray(
            new Vector(0, 0, 0),
            new Vector(0, 0, -1)
        );

        // intersection
        intersection = scene.intersect(ray);
    });

    it("constructor", () => {
        expect(rayTracer.scene).toEqual(scene);
        expect(rayTracer.maxDepth).toEqual(maxDepth);
    });

    it("getNaturalColor", () => {
        // todo: find a guessable color!
        let color = rayTracer.getNaturalColor(intersection);
        expect(color).toEqual(color);
    });

    it("getReflectionColor", () => {
        // after max depth
        expect(rayTracer.getReflectedColor(intersection, maxDepth))
            .toEqual(Color.gray);

        // before max depth
        // todo: find a guessable color!
        let color = rayTracer.getReflectedColor(intersection, maxDepth - 1);
        expect(color).toEqual(color);
    });

    it("shade", () => {
        // todo: find a guessable color!
        let color = rayTracer.shade(intersection, maxDepth);
        expect(color).toEqual(color);
    });

    it("trace", () => {
        // todo: find a guessable color!
        let color = rayTracer.trace(ray, maxDepth);
        expect(color).toEqual(color);
    });
});