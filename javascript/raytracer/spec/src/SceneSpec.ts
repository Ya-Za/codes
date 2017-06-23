import { CheckerBoard, Shiny } from "../../src/Surface";
import { Plane, Sphere } from "../../src/Thing";

import { Camera } from "../../src/Camera";
import { Color } from "../../src/Color";
import { Intersection } from "../../src/Intersection";
import { Light } from "../../src/Light";
import { Ray } from "../../src/Ray";
import { Scene } from "../../src/Scene";
import { Vector } from "../../src/Vector";

describe("Scene", () => {
    let scene: Scene;
    let sphere: Sphere;
    let plane: Plane;
    let light: Light;
    let camera: Camera;

    beforeAll(() => {
        // things
        sphere = new Sphere(
            new Vector(0, 0, -2),
            1,
            Shiny
        );

        plane = new Plane(
            new Vector(0, -1, 0),
            new Vector(0, 1, 0),
            CheckerBoard
        );

        // lights
        light = new Light(
            new Vector(0, 2, 0),
            new Color(1, 1, 1)
        );

        // camera
        camera = new Camera(
            new Vector(0, 0, 0),
            new Vector(0, 0, -1)
        );

        // scene
        scene = new Scene(
            [sphere, plane],
            [light],
            camera
        );
    });

    it("constructor", () => {
        expect(scene.things).toEqual([sphere, plane]);
        expect(scene.lights).toEqual([light]);
        expect(scene.camera).toEqual(camera);
    });

    it("intersect", () => {
        // sphere
        let raySphere = new Ray(
            new Vector(0, 0, 0),
            new Vector(0, 0, -1)
        );

        let intersectionSphere = new Intersection(
            raySphere,
            sphere,
            1
        );

        expect(scene.intersect(raySphere)).toEqual(intersectionSphere);

        // plane
        let rayPlane = new Ray(
            new Vector(0, 1, 0),
            new Vector(0, -1, 0)
        );

        let intersectionPlane = new Intersection(
            rayPlane,
            plane,
            2
        );

        expect(scene.intersect(rayPlane)).toEqual(intersectionPlane);
    });

    it("isInShadow", () => {
        let pointInShadow = new Vector(0, 0, -3);
        let pointNotInShadow = new Vector(0, 2, -2);

        expect(scene.isInShadow(pointInShadow, light)).toBeTruthy();
        expect(scene.isInShadow(pointNotInShadow, light)).toBeFalsy();
    });
});
