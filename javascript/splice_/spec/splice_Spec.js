/// <reference path="../typings/globals/jasmine/index.d.ts" />
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var splice_1 = require("../splice_");
describe('splice_', function () {
    it('push front', function () {
        var expected = [1];
        var actual = [];
        splice_1.default(actual, 0, 0, 1);
        expect(actual).toEqual(expected);
    });
});
//# sourceMappingURL=splice_Spec.js.map