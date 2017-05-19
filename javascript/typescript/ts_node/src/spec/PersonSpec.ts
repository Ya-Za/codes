/// <reference path="../../typings/globals/jasmine/index.d.ts" />

import Person from '../Person'

describe("Person", () => {
    it("toString", () => {
        {
            // Arrange
            let person = new Person("John", "Doe");
            let expected = "John Doe";

            // Act
            let actual = person.toString();

            // Arrange
            expect(expected).toEqual(actual);
        }
    });
});