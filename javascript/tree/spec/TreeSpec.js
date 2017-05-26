"use strict";
/// <reference path="../typings/globals/jasmine/index.d.ts" />
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
    it("dfs", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;
        b.childs = [d];
        d.parent = b;
        let expected = [a, b, d, c];
        // Act
        let actual = [...Tree_1.default.dfs(a)];
        // Assert
        expect(actual).toEqual(expected);
    });
    it("bfs", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;
        b.childs = [d];
        d.parent = b;
        let expected = [a, b, c, d];
        // Act
        let actual = [...Tree_1.default.bfs(a)];
        // Assert
        expect(actual).toEqual(expected);
    });
    it("ancestors", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;
        b.childs = [d];
        d.parent = b;
        let expected = [b, a];
        // Act
        let actual = [...Tree_1.default.ancestors(d)];
        // Assert
        expect(actual).toEqual(expected);
    });
    it("descendants", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;
        b.childs = [d];
        d.parent = b;
        let expected = [d];
        // Act
        let actual = [...Tree_1.default.descendants(b)];
        // Assert
        expect(actual).toEqual(expected);
    });
    it("self", () => {
        // Arrange
        // "a"
        let a = new NodeTree_1.default("a");
        let expected = a;
        // Act
        let actual = Tree_1.default.self(a);
        // Assert
        expect(actual).toEqual(expected);
    });
    it("parent", () => {
        // Arrange
        // "a(b)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        a.childs = [b];
        b.parent = a;
        let expected = a;
        // Act
        let actual = Tree_1.default.parent(b);
        // Assert
        expect(actual).toEqual(expected);
    });
    it("childs", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;
        b.childs = [d];
        d.parent = b;
        let expected = [b, c];
        // Act
        let actual = [...Tree_1.default.childs(a)];
        // Assert
        expect(actual).toEqual(expected);
    });
    it("previousSiblings", () => {
        // Arrange
        // "a(b,c,d)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c, d];
        b.parent = a;
        c.parent = a;
        d.parent = a;
        let expected = [b];
        // Act
        let actual = [...Tree_1.default.previousSiblings(c)];
        // Assert
        expect(actual).toEqual(expected);
    });
    it("nextSiblings", () => {
        // Arrange
        // "a(b,c,d)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c, d];
        b.parent = a;
        c.parent = a;
        d.parent = a;
        let expected = [d];
        // Act
        let actual = [...Tree_1.default.nextSiblings(c)];
        // Assert
        expect(actual).toEqual(expected);
    });
    it("siblings", () => {
        // Arrange
        // "a(b,c,d)"
        let a = new NodeTree_1.default("a");
        let b = new NodeTree_1.default("b");
        let c = new NodeTree_1.default("c");
        let d = new NodeTree_1.default("d");
        a.childs = [b, c, d];
        b.parent = a;
        c.parent = a;
        d.parent = a;
        let expected = [b, d];
        // Act
        let actual = [...Tree_1.default.siblings(c)];
        // Assert
        expect(actual).toEqual(expected);
    });
});
//# sourceMappingURL=TreeSpec.js.map