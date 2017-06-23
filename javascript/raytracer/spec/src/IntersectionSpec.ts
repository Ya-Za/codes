import { Intersection } from "../../src/Intersection";
import { Ray } from "../../src/Ray";
import { Shiny } from "../../src/Surface";
import { Sphere } from "../../src/Thing";
import { Vector } from "../../src/Vector";

describe("Intersection", () => {
    let ray: Ray;
    let sphere: Sphere;
    let distance: number;
    let intersection: Intersection;

    beforeAll(() => {
        // ray
        ray = new Ray(
            new Vector(0, 0, 0),
            new Vector(0, 0, -1)
        );

        // thing
        sphere = new Sphere(
            new Vector(0, 0, -2),
            1,
            Shiny
        );

        // distance
        distance = 2;

        // intersection
        intersection = new Intersection(
            ray,
            sphere,
            distance
        );
    });

    it("constructor", () => {
        expect(intersection.ray).toEqual(ray);
        expect(intersection.thing).toEqual(sphere);
        expect(intersection.distance).toEqual(distance);
    });
});
