import { Color } from "../../src/Color";
import { Vector } from "../../src/Vector";
import { Light } from "../../src/Light";

describe("Light", () => {
    it("constructor", () => {
        let pos = new Vector(1, 2, 3);
        let color = new Color(0, 0.5, 1);
        let light = new Light(pos, color);

        expect(light.pos).toEqual(pos);
        expect(light.color).toEqual(color);
    });
});
