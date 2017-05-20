"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Person = (function () {
    function Person(fname, lname) {
        this.fname = fname;
        this.lname = lname;
    }
    Person.prototype.toString = function () {
        return this.fname + " " + this.lname;
    };
    return Person;
}());
exports.default = Person;
//# sourceMappingURL=Person.js.map