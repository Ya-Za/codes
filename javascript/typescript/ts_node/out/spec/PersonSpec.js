"use strict";
/// <reference path="../../typings/globals/jasmine/index.d.ts" />
Object.defineProperty(exports, "__esModule", { value: true });
var Person_1 = require("../Person");
describe("Person", function () {
    it("toString", function () {
        {
            // Arrange
            var person = new Person_1.default("John", "Doe");
            var expected = "John Doe";
            // Act
            var actual = person.toString();
            // Arrange
            expect(expected).toEqual(actual);
        }
    });
});
//# sourceMappingURL=PersonSpec.js.map