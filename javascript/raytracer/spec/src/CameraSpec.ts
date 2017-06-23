import { Camera } from "../../src/Camera";
import { Vector } from "../../src/Vector";
import { Ray } from "../../src/Ray";

describe("Camera", () => {
    let camera: Camera;

    beforeAll(() => {
        camera = new Camera(
            new Vector(0, 0, 0),
            new Vector(0, 0, -1)
        );
    });

    it("construct", () => {
        expect(camera.pos).toEqual(new Vector(0, 0, 0));
        expect(camera.right).toEqual(new Vector(-1, 0, 0));
        expect(camera.up).toEqual(new Vector(0, 1, 0));
        expect(camera.forward).toEqual(new Vector(0, 0, -1));
    });

    it("rays", () => {
        let width = 2;
        let height = 2;

        let {x, y, ray} = camera.rays(width, height).next().value;

        expect(x).toEqual(0);
        expect(y).toEqual(0);
        expect(ray).toEqual(
            new Ray(
                new Vector(0, 0, 0), 
                Vector.unit(new Vector(1, 1, -1))
            )
        );
    });
});
