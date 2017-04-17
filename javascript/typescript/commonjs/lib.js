"use strict";
exports.__esModule = true;
// default
exports["default"] = 'Person';
// class
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
exports.Person = Person;
// class
function sayHello() {
    console.log('Hello');
}
exports.sayHello = sayHello;
// variable
exports.message = 'Hello, World!';
