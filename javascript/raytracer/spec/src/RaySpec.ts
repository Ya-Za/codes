import { Vector } from "../../src/Vector";
import { Ray } from "../../src/Ray";

describe("Ray", () => {
    it("constructor", () => {
        let start = new Vector(1, 2, 3);
        let dir = new Vector(0.5, 0, 0);
        let ray = new Ray(start, dir);

        expect(ray.start).toEqual(start);
        expect(ray.dir).toEqual(Vector.unit(dir));
    });
});