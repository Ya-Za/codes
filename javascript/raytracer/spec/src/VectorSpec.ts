import { Vector } from "../../src/Vector"

describe("Vector", () => {
    let v1: Vector;
    let v2: Vector;
    let v3: Vector;

    beforeAll(() => {
        v1 = new Vector(1, 2, 3);
        v2 = new Vector(4, 5, 6);
        v3 = new Vector(7, 8, 9);
    })

    it("constructor", () => {
        expect(v1.x).toEqual(1);
        expect(v1.y).toEqual(2);
        expect(v1.z).toEqual(3);
    });

    it("add", () => {
        expect(Vector.add(v1, v2))
            .toEqual(new Vector(5, 7, 9));
    });

    it("sum", () => {
        expect(Vector.sum(v1, v2, v3))
            .toEqual(new Vector(12, 15, 18));
    });

    it("mul", () => {
        // scalar multiplication
        expect(Vector.mul(2, v1))
            .toEqual(new Vector(2, 4, 6));
        // element-wise multiplication
        expect(Vector.mul(v1, v2))
            .toEqual(new Vector(4, 10, 18));
    });

    it("neg", () => {
        expect(Vector.neg(v1))
            .toEqual(new Vector(-1, -2, -3));
    });

    it("sub", () => {
        expect(Vector.sub(v1, v2))
            .toEqual(new Vector(-3, -3, -3));
    });

    it("dot", () => {
        expect(Vector.dot(v1, v2))
            .toEqual(32);
    });

    it("norm", () => {
        expect(Vector.norm(v1))
            .toBeCloseTo(3.606, 0.001);
    });

    it("dist", () => {
        expect(Vector.dist(v1, v2))
            .toBeCloseTo(5.1962, 0.001);
    });

    it("unit", () => {
        let v1_ = Vector.unit(v1);

        expect(v1_.x)
            .toBeCloseTo(0.2673, 0.001);
        expect(v1_.y)
            .toBeCloseTo(0.5345, 0.001);
        expect(v1_.z)
            .toBeCloseTo(0.8018, 0.001);
    });

    it("cross", () => {
        expect(Vector.cross(v1, v2))
            .toEqual(new Vector(-3, 6, -3));
    });

    it("reflect", () => {
        let I = new Vector(1, -1, 0);
        let n = new Vector(0, 1, 0);

        expect(Vector.reflect(I, n))
            .toEqual(new Vector(1, 1, 0));
    });
})
