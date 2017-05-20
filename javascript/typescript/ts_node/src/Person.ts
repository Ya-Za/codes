export default class Person {
    constructor(
        public fname: string,
        public lname: string
    ) { }

    toString() {
        return `${this.fname} ${this.lname}`;
    }
}