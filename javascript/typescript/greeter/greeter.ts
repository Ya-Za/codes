class Student {
    /**
     * Implement student class
     */
    fullName: string
    constructor(public fname: string, public mname: string, public lname: string) {
        /**
         * Construtor of `student` class
         */
        this.fullName = `${fname} ${mname} ${lname}`
    }
}

interface Person {
    fname: string,
    lname: string
}

/**
 * Return greeting message
 * 
 */
function greeter(person: Person): string {
    return `Hello, ${person.fname} ${person.lname}`
}

var user = new Student('Yasin', '--', 'Zamani')

document.body.innerHTML = greeter(user)

