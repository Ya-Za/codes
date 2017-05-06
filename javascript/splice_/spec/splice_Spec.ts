/// <reference path="../typings/globals/jasmine/index.d.ts" />

import splice_ from "../splice_";

describe('splice_', () => {
    it('push front', () => {
        let expected1 = [0, 1];
        let expected2 = [];

        let actual1 = [1];
        let actual2 = splice_(actual1, 0, 0, 0);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('push back', () => {
        let expected1 = [0, 1];
        let expected2 = [];

        let actual1 = [0];
        let actual2 = splice_(actual1, 1, 0, 1);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('pop front', () => {
        let expected1 = [1];
        let expected2 = [0];

        let actual1 = [0, 1];
        let actual2 = splice_(actual1, 0, 1);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('pop back', () => {
        let expected1 = [0];
        let expected2 = [1];

        let actual1 = [0, 1];
        let actual2 = splice_(actual1, 1, 1);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('insert', () => {
        let expected1 = [0, 1, 2];
        let expected2 = [];

        let actual1 = [0, 2];
        let actual2 = splice_(actual1, 1, 0, 1);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('remove', () => {
        let expected1 = [0, 2];
        let expected2 = [1];

        let actual1 = [0, 1, 2];
        let actual2 = splice_(actual1, 1, 1);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('concat', () => {
        let expected1 = [0, 1, 2, 3];
        let expected2 = [];

        let actual1 = [0, 1];
        let actual2 = splice_(actual1, 2, 0, ...[2, 3]);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('clear', () => {
        let expected1 = [];
        let expected2 = [0, 1];

        let actual1 = [0, 1];
        let actual2 = splice_(actual1, 0);

        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
});