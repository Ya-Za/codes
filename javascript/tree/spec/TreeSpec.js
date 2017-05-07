"use strict";
/// <reference path="../typings/globals/jasmine/index.d.ts" />
Object.defineProperty(exports, "__esModule", { value: true });
var Tree_1 = require("../Tree");
var NodeTree_1 = require("../NodeTree");
describe("Tree", function () {
    it("equals", function () {
        // Arrange
        // - tree 1
        var a1 = new NodeTree_1.default("a");
        var b1 = new NodeTree_1.default("b");
        var c1 = new NodeTree_1.default("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;
        var t1 = new Tree_1.default();
        t1.root = a1;
        // - tree 2
        var a2 = new NodeTree_1.default("a");
        var b2 = new NodeTree_1.default("b");
        var c2 = new NodeTree_1.default("c");
        a2.childs = [b2, c2];
        b2.parent = a2;
        c2.parent = a2;
        var t2 = new Tree_1.default();
        t2.root = a2;
        // Act
        var actual = t1.equals(t2);
        // Assert
        expect(actual).toBeTruthy();
    });
    it("fromString", function () {
        // - tree 1
        var a1 = new NodeTree_1.default("a");
        var b1 = new NodeTree_1.default("b");
        var c1 = new NodeTree_1.default("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;
        var t1 = new Tree_1.default();
        t1.root = a1;
        // - tree 2
        var t2 = Tree_1.default.fromString("a(b,c)");
        // Act
        var actual = t1.equals(t2);
        // Assert
        expect(actual).toBeTruthy();
    });
});
//# sourceMappingURL=TreeSpec.js.map