var MyNamespace;
(function (MyNamespace) {
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
    MyNamespace.Person = Person;
    function printPerson(person) {
        console.log(person.toString());
    }
    MyNamespace.printPerson = printPerson;
})(MyNamespace || (MyNamespace = {}));
//# sourceMappingURL=main.js.map