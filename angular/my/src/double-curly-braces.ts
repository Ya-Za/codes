import { Angular } from './angular';

class Person {
    _firstName: string;
    _lastName: string;
    onchange: () => void;

    constructor(fristName = '', lastName = '') {
        this._firstName = fristName;
        this._lastName = lastName;
    }

    set firstName(value: string) {
        this._firstName = value;
        this.onchange();
    }
    get firstName(): string {
        return this._firstName;
    }
    set lastName(value: string) {
        this._lastName = value;
        this.onchange();
    }
    get lastName(): string {
        return this._lastName;
    }
}

const ng = new Angular(document);
const person = new Person();
person.onchange = () => {
    ng.render(person, 'app-root', '<h1>Hello, {{firstName}} {{lastName}}!');
}


// add event listener
// - first name
const firstNameInputElement = document.getElementById('firstName') as HTMLInputElement;
firstNameInputElement.addEventListener('input', (event: Event) => {
    const target = event.target as HTMLInputElement;
    person.firstName = target.value;
})
// - last name
const lastNameInputElement = document.getElementById('lastName') as HTMLInputElement;
lastNameInputElement.addEventListener('input', (event: Event) => {
    const target = event.target as HTMLInputElement;
    person.lastName = target.value;
})