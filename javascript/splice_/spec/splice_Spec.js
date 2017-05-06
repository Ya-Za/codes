/// <reference path="../typings/globals/jasmine/index.d.ts" />
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var splice_1 = require("../splice_");
describe('splice_', function () {
    it('push front', function () {
        var expected1 = [0, 1];
        var expected2 = [];
        var actual1 = [1];
        var actual2 = splice_1.default(actual1, 0, 0, 0);
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('push back', function () {
        var expected1 = [0, 1];
        var expected2 = [];
        var actual1 = [0];
        var actual2 = splice_1.default(actual1, 1, 0, 1);
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('pop front', function () {
        var expected1 = [1];
        var expected2 = [0];
        var actual1 = [0, 1];
        var actual2 = splice_1.default(actual1, 0, 1);
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('pop back', function () {
        var expected1 = [0];
        var expected2 = [1];
        var actual1 = [0, 1];
        var actual2 = splice_1.default(actual1, 1, 1);
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('insert', function () {
        var expected1 = [0, 1, 2];
        var expected2 = [];
        var actual1 = [0, 2];
        var actual2 = splice_1.default(actual1, 1, 0, 1);
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('remove', function () {
        var expected1 = [0, 2];
        var expected2 = [1];
        var actual1 = [0, 1, 2];
        var actual2 = splice_1.default(actual1, 1, 1);
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('concat', function () {
        var expected1 = [0, 1, 2, 3];
        var expected2 = [];
        var actual1 = [0, 1];
        var actual2 = splice_1.default.apply(void 0, [actual1, 2, 0].concat([2, 3]));
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
    it('clear', function () {
        var expected1 = [];
        var expected2 = [0, 1];
        var actual1 = [0, 1];
        var actual2 = splice_1.default(actual1, 0);
        expect(actual1).toEqual(expected1);
        expect(actual2).toEqual(expected2);
    });
});
//# sourceMappingURL=splice_Spec.js.map