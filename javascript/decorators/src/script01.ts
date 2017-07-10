function addAge(age: number) {
    return function (targetClass: Person) {
        return class {
            name = new targetClass().name;
            age = age;
        }
    }
}

@addAge(30)
class Person {
    name: string;
    constructor() {
        this.name = "Yasin";
    }
}

console.log(new Person());
