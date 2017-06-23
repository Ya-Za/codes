import { Sphere, Plane } from "../../src/Thing";
import { Vector } from "../../src/Vector";
import { Shiny, CheckerBoard } from "../../src/Surface";
import { Ray } from "../../src/Ray";
import { Intersection } from "../../src/Intersection";

describe("Thing", () => {
    describe("Sphere", () => {
        let sphere: Sphere;

        beforeAll(() => {
            sphere = new Sphere(
                new Vector(0, 0, 0),
                1,
                Shiny
            );
        });

        it("constructor", () => {
            expect(sphere.center).toEqual(new Vector(0, 0, 0));
            expect(sphere.radius).toEqual(1);
            expect(sphere.surface).toEqual(Shiny);
        });

        it("normal", () => {
            expect(sphere.normal(new Vector(1, 0, 0)))
                .toEqual(new Vector(1, 0, 0));
        });

        it("intersect", () => {
            let ray = new Ray(
                new Vector(-2, 0, 0),
                new Vector(1, 0, 0)
            );

            let intersection = new Intersection(ray, sphere, 1);

            expect(sphere.intersect(ray))
                .toEqual(intersection);
        });
    });

    describe("Plane", () => {
        let plane: Plane;

        beforeAll(() => {
            plane = new Plane(
                new Vector(0, 0, 0),
                new Vector(0, 1, 0),
                CheckerBoard
            );
        });

        it("constructor", () => {
            expect(plane.P0).toEqual(new Vector(0, 0, 0));
            expect(plane.n).toEqual(new Vector(0, 1, 0));
            expect(plane.surface).toEqual(CheckerBoard);
        });

        it("normal", () => {
            expect(plane.normal(new Vector(1, 0, 0)))
                .toEqual(new Vector(0, 1, 0));
        });

        it("intersect", () => {
            let ray = new Ray(
                new Vector(0, 2, 0),
                new Vector(0, -1, 0)
            );

            let intersection = new Intersection(ray, plane, 2);

            expect(plane.intersect(ray))
                .toEqual(intersection);
        });
    });
});
