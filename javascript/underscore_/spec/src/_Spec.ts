import * as _ from "../../src/_";

describe("_", () => {
    let list: number[];
    let dict: { [key: string]: number };
    beforeEach(() => {
        list = [1, 2, 3, 4, 5];
        dict = {
            one: 1,
            two: 2,
            three: 3,
            four: 4,
            five: 5
        }
    });
    it("forEach - list", () => {
        // arrange
        const expected = [1, 2, 3, 4, 5];
        // act
        let actual: number[] = [];
        _.forEach(list, (x: number) => actual.push(x));
        // assert
        expect(actual).toEqual(expected);
    });
    it("forEach - dict", () => {
        // arrange
        const expected = {
            one: 1,
            two: 2,
            three: 3,
            four: 4,
            five: 5
        };
        // act
        let actual: {[key: string]: number} = {};
        _.forEach(dict, (v: number, k: string) => actual[k] = v);
        // assert
        expect(actual).toEqual(expected);
    });
});