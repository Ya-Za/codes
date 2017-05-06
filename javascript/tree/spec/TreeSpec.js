/// <reference path="../typings/globals/jasmine/index.d.ts" />
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Tree_1 = require("../Tree");
var NodeTree_1 = require("../NodeTree");
describe("Tree", function () {
    it("equals", function () {
        // arrange
        // - expected
        var a1 = new NodeTree_1.default("a");
        var b1 = new NodeTree_1.default("b");
        var c1 = new NodeTree_1.default("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;
        var expected = new Tree_1.default();
        expected.root = a1;
        // act
        // - actual
        var a2 = new NodeTree_1.default("a");
        var b2 = new NodeTree_1.default("b");
        var c2 = new NodeTree_1.default("c");
        a2.childs = [b2, c2];
        b2.parent = a2;
        c2.parent = a2;
        var actual = new Tree_1.default();
        actual.root = a2;
        if (actual.equals(expected)) {
            expect(true).toBeTruthy();
        }
        else {
            expect(true).toBeFalsy();
        }
    });
});
//# sourceMappingURL=TreeSpec.js.map