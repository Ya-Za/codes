declare namespace MyNamespace {
    class Person {
        fname: string;
        lname: string;
        constructor(fname: string, lname: string);
        toString(): string;
    }
    function printPerson(person: Person): void;
}
