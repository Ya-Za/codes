import { integer } from "../../src/numbers";

describe("numbers", () => {
    it("integer", () => {
        // arrange
        const num = "123456789";
        const expected = "one hundred [and] twenty-three million, four hundred [and] fifty-six thousand, seven hundred [and] eighty-nine";
        // act
        const actual = integer(num);
        // expect
        expect(actual).toEqual(expected);
    });
});
