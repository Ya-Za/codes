// default
export default 'Person'

// class
export class Person {
    constructor(public fname: string, public lname: string) {}

    toString() {
        return `${this.fname} ${this.lname}`
    }
}

// class
export function sayHello() {
    console.log('Hello')
}

// variable

export let message = 'Hello, World!'