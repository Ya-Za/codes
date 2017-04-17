import type, {Person as PersonClass, sayHello as sayHelloFunction, message} from './lib'

import * as lib from './lib'

let person = new PersonClass('Yasin', 'Zamani')
console.log(person.toString())

sayHelloFunction()

console.log(message)

console.log(lib.default)
