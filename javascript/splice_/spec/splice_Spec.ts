/// <reference path="../typings/globals/jasmine/index.d.ts" />

import splice_ from "../splice_";

describe('splice_', () => {
    it('push front', () => {
        let expected = [1];

        let actual = [];
        splice_(actual, 0, 0, 1);

        expect(actual).toEqual(expected);
    })
})