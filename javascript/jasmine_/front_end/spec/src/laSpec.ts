import * as la from "../../src/la"
import * as math from "mathjs"

describe("la", () => {
    it("dot", () => {
        let u = [1, 2, 3];
        let v = [4, 5, 6];

        expect(la.dot(u, v)).toBe(math.dot(u, v));
    })
})
