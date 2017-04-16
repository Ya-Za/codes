class A {
    constructor(public a: string) {}
    sayA() {
        console.log(this.a)
    }

    static aa: string = 'aa'
    static sayAA() {
        console.log('aa')
    }
}

class B extends A {
    b: string
    constructor(a: string, b: string) {
        super(a)
        this.b = b
    }
    sayB() {
        console.log(this.b)
    }

    static bb: string = 'bb'
    static sayBB() {
        console.log('bb')
    }
}

var a = new A('a')

var b = new B('a', 'b')
b.sayA()
b.sayAA()
b.sayB()
b.sayBB()