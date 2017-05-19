/// <reference path="../typings/globals/jasmine/index.d.ts" />

import Tree from "../Tree";
import NodeTree from "../NodeTree"

describe("Tree", () => {
    it("equals", () => {
        // Arrange
        // - tree 1
        let a1 = new NodeTree("a");
        let b1 = new NodeTree("b");
        let c1 = new NodeTree("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;

        let t1 = new Tree();
        t1.root = a1;

        // - tree 2
        let a2 = new NodeTree("a");
        let b2 = new NodeTree("b");
        let c2 = new NodeTree("c");
        a2.childs = [b2, c2];
        b2.parent = a2;
        c2.parent = a2;

        let t2 = new Tree();
        t2.root = a2;

        // Act
        let actual = t1.equals(t2);

        // Assert
        expect(actual).toBeTruthy();
    });
    it("fromString", () => {
        // - tree 1
        let a1 = new NodeTree("a");
        let b1 = new NodeTree("b");
        let c1 = new NodeTree("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;

        let t1 = new Tree();
        t1.root = a1;

        // - tree 2
        let t2 = Tree.fromString("a(b,c)")

        // Act
        let actual = t1.equals(t2);

        // Assert
        expect(actual).toBeTruthy();
    })
    it("toString", () => {
        // Arrange
        let tree = Tree.fromString("a(b,c)");
        let expected = "a(b,c)";

        // Act
        let actual = tree.toString();

        // Assert
        expect(actual).toEqual(expected);
    })
    it("fromJson", () => {
        // Arrange
        let t1 = Tree.fromString("a(b,c)");

        let js = {
            "a": {
                "b": null,
                "c": null
            }
        };
        let t2 = Tree.fromJson(js);

        // Act
        let actual = t1.equals(t2);

        // Assert
        expect(actual).toBeTruthy();
    })
    it("toJson", () => {
        // Arrange
        let tree = Tree.fromString("a(b,c)");
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
    })
})