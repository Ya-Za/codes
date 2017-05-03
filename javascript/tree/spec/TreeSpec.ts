/// <reference path="../typings/globals/jasmine/index.d.ts" />

import Tree from "../Tree";

describe("Tree", () => {
    it("equals", () => {
        let expected = Tree.fromStr('a(b,c)');
        let actual = Tree.fromStr('a(b,c)');
        
        if (actual.equals(actual)) {
            expect(true).toBeTruthy();
        } else {
            expect(true).toBeFalsy();
        }
    })
    it("fromStr", () => {
        let str = "a(b,c)";
    })
})