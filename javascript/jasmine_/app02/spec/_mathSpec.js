/// <reference path="../jasmine.d.ts" />
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var _math_1 = require("../_math");
describe("_math", function () {
    it('add', function () {
        expect(_math_1._math.add(1, 2)).toEqual(3);
    });
    it('subtract', function () {
        expect(_math_1._math.subtract(1, 2)).toEqual(-1);
    });
});
//# sourceMappingURL=_mathSpec.js.map