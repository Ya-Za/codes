/// <reference path="../jasmine.d.ts" />

import {_math} from "../_math";

describe("_math", () => {
    it('add', () => {
        expect(_math.add(1, 2)).toEqual(3);
    });

    it('subtract', () => {
        expect(_math.subtract(1, 2)).toEqual(-1);
    });
})