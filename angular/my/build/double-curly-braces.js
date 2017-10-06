define(["require", "exports", "./angular"], function (require, exports, angular_1) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    class Person {
        constructor(fristName = '', lastName = '') {
            this._firstName = fristName;
            this._lastName = lastName;
        }
        set firstName(value) {
            this._firstName = value;
            this.onchange();
        }
        get firstName() {
            return this._firstName;
        }
        set lastName(value) {
            this._lastName = value;
            this.onchange();
        }
        get lastName() {
            return this._lastName;
        }
    }
    const ng = new angular_1.Angular(document);
    const person = new Person();
    person.onchange = () => {
        ng.render(person, 'app-root', '<h1>Hello, {{firstName}} {{lastName}}!');
    };
    // add event listener
    // - first name
    const firstNameInputElement = document.getElementById('firstName');
    firstNameInputElement.addEventListener('input', (event) => {
        const target = event.target;
        person.firstName = target.value;
    });
    // - last name
    const lastNameInputElement = document.getElementById('lastName');
    lastNameInputElement.addEventListener('input', (event) => {
        const target = event.target;
        person.lastName = target.value;
    });
});
//# sourceMappingURL=double-curly-braces.js.map