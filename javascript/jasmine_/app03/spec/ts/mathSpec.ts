import * as math from "../../ts/math";

describe("math", () => {
    it("add", () => {
        expect(math.add(1, 2)).toEqual(3);
    })

    it("sub", () => {
        expect(math.sub(1, 2)).toEqual(-1);
    })
})
