namespace MyNamespace {
    export class Person {
        fname: string;
        lname: string;
        constructor(fname: string, lname: string) {
            this.fname = fname;
            this.lname = lname;
        }
        toString() {
            return `${this.fname} ${this.lname}`;
        }
    }

    export function printPerson(person: Person) {
        console.log(person.toString());
    }
}