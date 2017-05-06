/// <reference path="../typings/globals/jasmine/index.d.ts" />

import Tree from "../Tree";
import NodeTree from "../NodeTree"

describe("Tree", () => {
    it("equals", () => {
        // arrange
        // - expected
        let a1 = new NodeTree("a");
        let b1 = new NodeTree("b");
        let c1 = new NodeTree("c");
        a1.childs = [b1, c1];
        b1.parent = a1;
        c1.parent = a1;

        let expected = new Tree();
        expected.root = a1;

        // act
        // - actual
        let a2 = new NodeTree("a");
        let b2 = new NodeTree("b");
        let c2 = new NodeTree("c");
        a2.childs = [b2, c2];
        b2.parent = a2;
        c2.parent = a2;

        let actual = new Tree();
        actual.root = a2;
        
        if (actual.equals(expected)) {
            expect(true).toBeTruthy();
        } else {
            expect(true).toBeFalsy();
        }
    })
})