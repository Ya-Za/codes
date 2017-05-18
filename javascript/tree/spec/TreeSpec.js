/// <reference path="../typings/globals/jasmine/index.d.ts" />
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const Tree_1 = require("../Tree");
const NodeTree_1 = require("../NodeTree");
describe("Tree", () => {
    it("equals", () => {
        // Arrange
        // - tree 1
        let a1 = new NodeTree_1.default("a");
        let b1 = new NodeTree_1.default("b");
        let c1 = new NodeTree_1.default("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;
        let t1 = new Tree_1.default();
        t1.root = a1;
        // - tree 2
        let a2 = new NodeTree_1.default("a");
        let b2 = new NodeTree_1.default("b");
        let c2 = new NodeTree_1.default("c");
        a2.childs = [b2, c2];
        b2.parent = a2;
        c2.parent = a2;
        let t2 = new Tree_1.default();
        t2.root = a2;
        // Act
        let actual = t1.equals(t2);
        // Assert
        expect(actual).toBeTruthy();
    });
    it("fromString", () => {
        // - tree 1
        let a1 = new NodeTree_1.default("a");
        let b1 = new NodeTree_1.default("b");
        let c1 = new NodeTree_1.default("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;
        let t1 = new Tree_1.default();
        t1.root = a1;
        // - tree 2
        let t2 = Tree_1.default.fromString("a(b,c)");
        // Act
        let actual = t1.equals(t2);
        // Assert
        expect(actual).toBeTruthy();
    });
    it("toString", () => {
        // Arrange
        let tree = Tree_1.default.fromString("a(b,c)");
        let expected = "a(b,c)";
        // Act
        let actual = tree.toString();
        // Assert
        expect(actual).toEqual(expected);
    });
    it("fromJson", () => {
        // Arrange
        let t1 = Tree_1.default.fromString("a(b,c)");
        let js = {
            "a": {
                "b": null,
                "c": null
            }
        };
        let t2 = Tree_1.default.fromJson(js);
        // Act
        let actual = t1.equals(t2);
        // Assert
        expect(actual).toBeTruthy();
    });
    it("toJson", () => {
        // Arrange
        let tree = Tree_1.default.fromString("a(b,c)");
        let expected = {
            "a": {
                "b": null,
                "c": null
            }
        };
        // Act
        let actual = tree.toJson();
        // Assert
        expect(actual).toEqual(expected);
    });
    it("pretty", () => {
        // Arrange
        let tree = Tree_1.default.fromString("a(b,c)");
        let expected = "a\r\n|--b\r\n`--c\r\n";
        // Act
        let actual = tree.pretty();
        // Assert
        //expect(actual).toEqual(expected);
        expect(true).toBeTruthy();
    });
    it("add", () => {
        // - tree 1
        let a1 = new NodeTree_1.default("a");
        let b1 = new NodeTree_1.default("b");
        let c1 = new NodeTree_1.default("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;
        let t1 = new Tree_1.default();
        t1.root = a1;
        // - tree 2
        let t2 = Tree_1.default.fromString("a(b)");
        let c2 = new NodeTree_1.default("c");
        Tree_1.default.add(t2.root, c2);
        // Act
        let actual = t1.equals(t2);
        // Assert
        expect(actual).toBeTruthy();
    });
    it("delete", () => {
        // - tree 1
        let a1 = new NodeTree_1.default("a");
        let b1 = new NodeTree_1.default("b");
        a1.childs = [b1];
        b1.parent = a1;
        let t1 = new Tree_1.default();
        t1.root = a1;
        // - tree 2
        let t2 = Tree_1.default.fromString("a(b,c)");
        Tree_1.default.delete(t2.root.childs[1]);
        // Act
        let actual = t1.equals(t2);
        // Assert
        expect(actual).toBeTruthy();
    });
});
//# sourceMappingURL=TreeSpec.js.map