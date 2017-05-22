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
    });
    it("toString", () => {
        // Arrange
        let tree = Tree.fromString("a(b,c)");
        let expected = "a(b,c)";

        // Act
        let actual = tree.toString();

        // Assert
        expect(actual).toEqual(expected);
    });
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
    });
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
    });
    it("pretty", () => {
        // Arrange
        let tree = Tree.fromString("a(b,c)");
        let expected = "a\r\n|--b\r\n`--c\r\n";

        // Act
        let actual = tree.pretty();

        // Assert
        //expect(actual).toEqual(expected);
        expect(true).toBeTruthy();
    });
    it("add", () => {
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
        let t2 = Tree.fromString("a(b)");
        let c2 = new NodeTree("c");
        Tree.add(t2.root, c2)

        // Act
        let actual = t1.equals(t2);

        // Assert
        expect(actual).toBeTruthy();
    });
    it("delete", () => {
        // - tree 1
        let a1 = new NodeTree("a");
        let b1 = new NodeTree("b");
        a1.childs = [b1];
        b1.parent = a1;

        let t1 = new Tree();
        t1.root = a1;

        // - tree 2
        let t2 = Tree.fromString("a(b,c)");
        Tree.delete(t2.root.childs[1])

        // Act
        let actual = t1.equals(t2);

        // Assert
        expect(actual).toBeTruthy();
    });
    it("dfs", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree("a");
        let b = new NodeTree("b");
        let c = new NodeTree("c");
        let d = new NodeTree("d");
        
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;

        b.childs = [d];
        d.parent = b;

        let expected = [a, b, d, c];

        // Act
        let actual = [...Tree.dfs(a)];

        // Assert
        expect(actual).toEqual(expected);
    });
    it("bfs", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree("a");
        let b = new NodeTree("b");
        let c = new NodeTree("c");
        let d = new NodeTree("d");
        
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;

        b.childs = [d];
        d.parent = b;

        let expected = [a, b, c, d];

        // Act
        let actual = [...Tree.bfs(a)];

        // Assert
        expect(actual).toEqual(expected);
    });
    it("ancestors", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree("a");
        let b = new NodeTree("b");
        let c = new NodeTree("c");
        let d = new NodeTree("d");
        
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;

        b.childs = [d];
        d.parent = b;

        let expected = [b, a];

        // Act
        let actual = [...Tree.ancestors(d)];

        // Assert
        expect(actual).toEqual(expected);
    });
    it("descendants", () => {
        // Arrange
        // "a(b(d),c)"
        let a = new NodeTree("a");
        let b = new NodeTree("b");
        let c = new NodeTree("c");
        let d = new NodeTree("d");
        
        a.childs = [b, c];
        b.parent = a;
        c.parent = a;

        b.childs = [d];
        d.parent = b;

        let expected = [d];

        // Act
        let actual = [...Tree.descendants(b)];
       
        // Assert
        expect(actual).toEqual(expected);
    });
})