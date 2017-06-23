import { Color } from "../../src/Color";
import { Vector } from "../../src/Vector";

describe("Color", () => {
    let c1: Color;
    let c2: Color;
    let c3: Color;

    beforeAll(() => {
        c1 = new Color(0, 0.5, 1);
        c2 = new Color(1, 0.5, 0);
        c3 = new Color(1, 0, 0);
    });
    
    it("constructor", () => {
        expect(c1.r).toEqual(0);
        expect(c1.g).toEqual(0.5);
        expect(c1.b).toEqual(1);
    });

    it("toDrawable", () => {
        let color = new Color(-1, 0.5, 2);
        expect(color.toDrawable())
            .toEqual(new Color(0, 127.5, 255));
    });

    it("toString", () => {
        expect(c1.toString())
            .toEqual("rgb(0, 127.5, 255)");
    });

    it("Static Properties", () => {
        expect(Color.black)
            .toEqual(new Color(0, 0, 0));

        expect(Color.gray)
            .toEqual(new Color(0.5, 0.5, 0.5));

        expect(Color.white)
            .toEqual(new Color(1, 1, 1));
    });

    it("toVector", () => {
        expect(Color.toVector(c1))
            .toEqual(new Vector(0, 0.5, 1));
    });

    it("fromVector", () => {
        expect(Color.fromVector(new Vector(0, 0.5, 1)))
            .toEqual(c1);
    });

    it("add", () => {
        expect(Color.add(c1, c2))
            .toEqual(new Color(1, 1, 1));
    });

    it("mul", () => {
        // scalar multiplication
        expect(Color.mul(2, c1))
            .toEqual(new Color(0, 1, 2));

        // element-wise multiplication
        expect(Color.mul(c1, c2))
            .toEqual(new Color(0, 0.25, 0));
    });

    it("sum", () => {
        expect(Color.sum(c1, c2, c3))
            .toEqual(new Color(2, 1, 1));
    });
});
